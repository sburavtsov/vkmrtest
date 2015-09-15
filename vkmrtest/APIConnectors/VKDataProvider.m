//
//  VKAPIConnector.m
//  vkmrtest
//
//  Created by Sergey Buravtsov on 9/13/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import "VKDataProvider.h"

@interface VKDataProvider ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation VKDataProvider

+ (VKDataProvider *)sharedInstance {

    static VKDataProvider *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[VKDataProvider alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/"];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void)getFriendsOnSuccess:(void (^)(NSArray *))success onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary *params = @{@"access_token":self.accessToken,
                             @"order":@"hints",
                             @"fields":@"photo_50",
                             @"name_case":@"nom"};
    
    [self.requestOperationManager GET:@"method/friends.get"
                           parameters:params
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  
                                  NSLog(@"JSON: %@", responseObject);
                                  NSArray *dictsArray = [responseObject objectForKey:@"response"];
                                  if (success) {
                                      
                                      success(dictsArray);
                                  }
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                                  NSLog(@"Error: %@", error);
                                  if (failure) {
                                      
                                      failure(error, operation.response.statusCode);
                                  }
                              }];
}

-(void)logout {
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies = [cookieStorage cookies];
    for (NSHTTPCookie *cookie in cookies) {
        
        if ([cookie.domain containsString:@"vk.com"]) {
            
            [cookieStorage deleteCookie:cookie];
        }
    }
    
    self.accessToken = nil;
}

@end
