//
//  ActivityView.m
//  cqlt
//
//  Created by dongyongzhu on 15/5/19.
//  Copyright (c) 2015年 innovator. All rights reserved.
//

#import "ActivityView.h"
#import "UIApplication+PresentedViewController.h"

static ActivityView *__activityView = nil;

@interface ActivityView ()
@property (nonatomic, strong) IBOutlet UIView       *contentView;
@property (nonatomic, strong) IBOutlet UIImageView  *animationView;
@property (nonatomic, strong) IBOutlet UILabel      *titleLbl;

@end

@implementation ActivityView

+ (ActivityView*)activityView {
    if (!__activityView) {
//        __activityView = [[[NSBundle mainBundle] loadNibNamed:@"ActivityView" owner:nil options:nil] lastObject];
    }
    return __activityView;
}

- (void)awakeFromNib {
    self.contentView.layer.cornerRadius = 5;
    self.enableGestures = YES;
}

- (void)dealloc {
    [self stopAnimation];
    [super dealloc];
}

#pragma mark - Setter
- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLbl.text = title;
}

#pragma mark - Show & Hidden
- (void)showWithAnimated:(BOOL)animated {
    [self showWithAnimated:animated inView:[UIApplication rootView]];
}

- (void)showWithAnimated:(BOOL)animated inView:(UIView*)view {
    [self stopAnimation];
    
    if (!self.superview) {
        view = view?:[UIApplication rootView];
        self.frame = view.bounds;
        [view addSubview:self];
        
        if (animated) {
            self.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1;
            }completion:^(BOOL finished) {
                [self startAnimation];
            }];
        }else {
            [self startAnimation];
        }
    }
}

- (void)hiddenWithAnimated:(BOOL)animated {
    [self stopAnimation];
    if (self.superview) {
        if (animated) {
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.alpha = 0;
                             } completion:^(BOOL finished) {
                                 self.alpha = 1;
                                 [self removeFromSuperview];
                                 [self stopAnimation];
                             }];
        }else {
            [self removeFromSuperview];
        }
    }
    
    [self stopAnimation];
}

#pragma mark - Animation
- (void)startAnimation {
    float duration = 1;
    [self performSelector:@selector(startAnimation)
               withObject:nil
               afterDelay:duration+1/60.0];
    
    self.animationView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:duration/3.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.animationView.transform = CGAffineTransformMakeRotation(M_PI*2/3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/3.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.animationView.transform = CGAffineTransformMakeRotation(M_PI*2/3*2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration/3.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.animationView.transform = CGAffineTransformMakeRotation(M_PI*2);
            } completion:^(BOOL finished) {
                self.animationView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

- (void)stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - Touches 
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.contentView.frame, point)) {
        return YES;
    }
    return !self.enableGestures;
}

@end
