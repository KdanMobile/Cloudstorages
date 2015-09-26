//
//  WebViewController.h
//  CloudStorages
//
//  Created by zhujunyu on 13-8-8.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpAndDownloadViewController.h"
@interface WebViewController : UIViewController<uploadChooseDelegate>
{
    UIWebView                       *web;
}

@property (nonatomic, retain)  NSMutableURLRequest * request;
@property (nonatomic) BOOL chooseRead;

@end
