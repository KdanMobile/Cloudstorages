//
//  LoginViewController.h
//  CloudStorages
//
//  Created by zhujunyu on 13-8-12.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudSDK/CSCloudServer.h>
@protocol loginDelegate <NSObject>

- (void)loginUserName:(NSString *)name andPassWord:(NSString *)passWord andHost:(NSString *)host andPort:(NSString *)port encoding:(NSStringEncoding)encoding;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UILabel *portLabel;
@property (retain, nonatomic) IBOutlet UILabel *hostLabel;
@property (nonatomic, assign) id delegate;
@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UITextField *passWord;
@property (retain, nonatomic) IBOutlet UITextField *hostName;
@property (retain, nonatomic) IBOutlet UITextField *port;
@property (retain, nonatomic) IBOutlet UIButton    *encodeButton;
@property (retain, nonatomic) IBOutlet UILabel     *encodeLabel;
@property (assign, nonatomic) CSCloudServerType type;
- (IBAction)login:(id)sender;
- (IBAction)onClickSelectEncoding:(id)sender;
@end
