//
//  ActivityView.h
//  cqlt
//
//  Created by dongyongzhu on 15/5/19.
//  Copyright (c) 2015年 innovator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readwrite) BOOL enableGestures;

+ (ActivityView*)activityView;

- (void)showWithAnimated:(BOOL)animated;
- (void)showWithAnimated:(BOOL)animated inView:(UIView*)view;

- (void)hiddenWithAnimated:(BOOL)animated;

@end
