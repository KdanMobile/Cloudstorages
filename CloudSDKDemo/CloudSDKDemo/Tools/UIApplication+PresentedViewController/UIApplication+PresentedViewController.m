//
//  UIApplication+PresentedViewController.m
//  AnimationDesk Universal
//
//  Created by zhudongyong on 14/10/14.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#import "UIApplication+PresentedViewController.h"

@implementation UIApplication (PresentedViewController)

+ (UIViewController*)presentedViewController {
    return [[UIApplication sharedApplication] presentedViewController];
}

- (UIViewController*)presentedViewController {
    UIWindow *keyWindow = [self keyWindow];
    
    UIViewController *viewController = keyWindow.rootViewController;
    while (viewController &&
           viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    
    return viewController;
}

+ (UIView*)rootView {
    return [[UIApplication sharedApplication] rootView];
}

- (UIView*)rootView {
    UIWindow *keyWindow = [self keyWindow];
    
    if ([keyWindow subviews]) {
        return [keyWindow.subviews lastObject];
    }
    
    return keyWindow;
}

@end
