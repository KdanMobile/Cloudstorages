//
//  LoginViewController.m
//  CloudStorages
//
//  Created by zhujunyu on 13-8-12.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize delegate;
@synthesize type;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
    NSString *serverName = nil;
      switch (self.type) {
        case CSMyDisk:{
            serverName = CSMydiskName;
        }
        case CSSugarSync:{
            if (![serverName length]) {
                serverName = CSSugarSyncName;
            }
        }
        case CSGoogleDocs:{
            if (![serverName length]) {
                serverName = CSGoogledriveName;
            }
            self.hostName.hidden = YES;
            self.port.hidden = YES;
            self.hostLabel.hidden = YES;
            self.portLabel.hidden = YES;
        }break;
        case CSWebDav:{
            serverName = CSWebDavName;
            self.port.hidden = YES;
            self.portLabel.hidden = YES;
        }break;
        default:
          {
              serverName = CSFtpName;
          }
            break;
    }
    self.title = serverName;
    [super viewDidAppear:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userName release];
    [_passWord release];
    [_hostName release];
    [_port release];
    [_hostLabel release];
    [_portLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUserName:nil];
    [self setPassWord:nil];
    [self setHostName:nil];
    [self setPort:nil];
    [self setHostLabel:nil];
    [self setPortLabel:nil];
    [super viewDidUnload];
}
- (IBAction)login:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(loginUserName:andPassWord:andHost:andPort:)]){
        [self.delegate loginUserName:self.userName.text andPassWord:self.passWord.text andHost:self.hostName.text andPort:self.port.text];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
