//
//  VKAPIConnector.h
//  vkmrtest
//
//  Created by Sergey Buravtsov on 9/13/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKDataProvider : NSObject

@property (strong, nonatomic) NSString *accessToken;
+ (VKDataProvider *)sharedInstance;

- (void)getFriendsOnSuccess:(void(^)(NSArray *friendsDictionaries))success
                  onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

- (void)logout;

@end
