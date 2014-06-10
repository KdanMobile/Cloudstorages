//
//  LoginViewController.m
//  CloudStorages
//
//  Created by zhujunyu on 13-8-12.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//

#import "LoginViewController.h"
#import "CloudSDK/NSString+SupportEncode.h"

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
    if(self.type == CSFTP)
    {
        [self.encodeButton setHidden:NO];
        [self.encodeLabel setHidden:NO];
        [self.encodeButton setEnabled:YES];
    }
    else
    {
        [self.encodeButton setHidden:YES];
        [self.encodeLabel setHidden:YES];
        [self.encodeButton setEnabled:NO];
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
    if ([self.delegate respondsToSelector:@selector(loginUserName:andPassWord:andHost:andPort:encoding:)]){
        [self.delegate loginUserName:self.userName.text andPassWord:self.passWord.text andHost:self.hostName.text andPort:self.port.text encoding:[NSString encodingFromName:self.encodeButton.titleLabel.text]];
    }
}
- (IBAction)onClickSelectEncoding:(id)sender
{
    NSString *strn = [NSString nameOfEncoding:-1];
    NSLog(@"%@",strn);
    UITableView *tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65) style:UITableViewStylePlain] autorelease];
    tableView.tag = 10000;
    tableView.delegate = (id)self;
    tableView.dataSource = (id)self;
    [self.view addSubview:tableView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NSString supportEncodeNames].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentify"];
    cell.textLabel.text = [[NSString supportEncodeNames] objectAtIndex:indexPath.row];
    return [cell autorelease];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>=0&&indexPath.row<[NSString supportEncodeNames].count)
    {
        NSString *encodeName = [[NSString supportEncodeNames] objectAtIndex:indexPath.row];
        UIView *view = [self.view viewWithTag:10000];
        if(view)
        {
            [view removeFromSuperview];
        }
        self.encodeButton.titleLabel.text = encodeName;
    }
}
#pragma mrak -
@end
