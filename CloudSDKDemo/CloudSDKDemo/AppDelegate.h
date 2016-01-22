//
//  AppDelegate.h
//  CloudSDKDemo
//
//  Created by dongyongzhu on 15/9/8.
//  Copyright (c) 2015年 Kdan Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController * _theNavigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController * viewController;

@end

