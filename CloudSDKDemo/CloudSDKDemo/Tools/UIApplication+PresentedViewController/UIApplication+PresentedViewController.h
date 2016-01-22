//
//  UIApplication+PresentedViewController.h
//  AnimationDesk Universal
//
//  Created by zhudongyong on 14/10/14.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (PresentedViewController)

//View Controller
+ (UIViewController*)presentedViewController;

- (UIViewController*)presentedViewController;

//View
+ (UIView*)rootView;

- (UIView*)rootView;

@end
