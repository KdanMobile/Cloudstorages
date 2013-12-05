//
//  ChooseServerViewController.h
//  CloudStorages
//
//  Created by zhujunyu on 13-8-10.
//  Copyright (c) 2013 year kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudSDK/CSCloudServer.h>
@protocol CloudLoginSuccess <NSObject>

- (void)logInSuccess:(CSCloudServer *)server;
- (void)logIn:(CSCloudServer *)server withError:(NSError *)error;

@end
@interface ChooseServerViewController : UITableViewController<CSCloudServerDelegate>
{
    UIActivityIndicatorView                         *_inDicView;
    CSCloudServer                                   *_server;

}

@property (nonatomic, retain) NSMutableArray * serverArr;
@property (nonatomic, assign) id delegate;
@property (nonatomic) BOOL isUpload;
@property (nonatomic, copy) NSString *filePath;

@end
