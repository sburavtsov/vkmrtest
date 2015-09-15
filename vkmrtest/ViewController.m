//
//  ViewController.m
//  vkmrtest
//
//  Created by Sergey Buravtsov on 9/13/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//
#import "OAuth2Provider.h"
#import "OAuth2Credentials.h"
#import "VKDataProvider.h"
#import "VKFriend.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "LoginViewController.h"
#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *friendsData;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.dataSource = self;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {

    if (! [VKDataProvider sharedInstance].accessToken) {
        
        [self obtainAuthorizationToken];
    }
    [self refreshView];
}

- (void)refreshView {
    
    [self fetchAllFriends];
    [self.tableView reloadData];
}

- (IBAction)clearCacheDidTap:(UIButton *)sender {
    
    self.friendsData = nil;

    [self clearSDWebImageCaches];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate cleanAndResetupDB];

    if (! [VKDataProvider sharedInstance].accessToken) {
        
        [self obtainAuthorizationToken];
    } else {

        [self refreshData];
    }
}

- (IBAction)logoutDidTap:(UIButton *)sender {
    
    [[VKDataProvider sharedInstance] logout];
}

- (void)fetchAllFriends {
    
    self.friendsData = [VKFriend MR_findAll];
}

-(void)clearSDWebImageCaches {
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
}

-(void)obtainAuthorizationToken {
    
    OAuth2Provider * vkProvider = [[OAuth2Provider alloc] init];
    vkProvider.clientId = @"5069246";
    vkProvider.redirectURLString = @"http://com.buravtsov.vkmrtest/oauth.html";
    vkProvider.authorizeURLString = @"https://oauth.vk.com/authorize";
    vkProvider.scope = @"friends";
    vkProvider.name = @"VKOAuthProvider";
    vkProvider.urlHandlerClass = [LoginViewController class];
    vkProvider.credentialsClass = [OAuth2Credentials class];
    
    OA2Authorization *authorization = [[OA2Authorization alloc] initWithProvider:vkProvider];
    
    UIViewController <OA2AuthorizationURLHandler> *urlHandler = (UIViewController <OA2AuthorizationURLHandler> *) [authorization authorizeProvider:@"VKOAuthProvider" success:^(id <OA2Credentials> credentials) {
        
        NSLog(@"access token %@",[credentials accessToken]);
        
        [VKDataProvider sharedInstance].accessToken = [credentials accessToken];
        [urlHandler dismissViewControllerAnimated:YES completion:nil];
        
        [self refreshData];
    } error:^(NSError *error) {
        
        [urlHandler dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self presentViewController:urlHandler animated:YES completion:^{

        [urlHandler startURLHandling];
    }];
}

- (void)refreshData {
    
    if (! [VKDataProvider sharedInstance].accessToken) {
      
        [self obtainAuthorizationToken];
        return;
    }
    
    [[VKDataProvider sharedInstance] getFriendsOnSuccess:^(NSArray *friendsDictionaries) {

        for (NSDictionary *userInfo in friendsDictionaries) {


            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                
                NSUInteger numberOfEntities = [VKFriend MR_countOfEntitiesWithPredicate :[NSPredicate predicateWithFormat:@"uid == %@", userInfo[@"user_id"]] inContext:localContext];
                if (0 == numberOfEntities) {
                    
                    VKFriend *friend = [VKFriend MR_createEntityInContext:localContext];
                    [friend initWithDictionary:userInfo];
                }
            } completion:^(BOOL contextDidSave, NSError *error) {
                
                [self refreshView];
            }];
        }

    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.friendsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath {

    VKFriend *friend = self.friendsData[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.first_name, friend.last_name];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:friend.photo_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
 
        [weakCell setNeedsLayout];
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self clearSDWebImageCaches];
}

@end
