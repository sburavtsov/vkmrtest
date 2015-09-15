//
//  AppDelegate.h
//  vkmrtest
//
//  Created by Sergey Buravtsov on 9/13/15.
//  Copyright (c) 2015 Sergey Buravtsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)cleanAndResetupDB;

@end

