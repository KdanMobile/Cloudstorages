//
//  WebViewController.m
//  CloudStorages
//
//  Created by zhujunyu on 13-8-8.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize  request;
@synthesize chooseRead;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        request  = [[NSMutableURLRequest alloc] init];
        
    }
    return self;
}
- (void)dealloc{
    [request            release];
    [web                release];
    [super              dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   web = [[UIWebView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:web];
    [web loadRequest:request];
    if (chooseRead) {
        UIBarButtonItem *chooseItem = [[UIBarButtonItem alloc] initWithTitle:@"Preview" style:UIBarButtonItemStylePlain target:self action:@selector(chooseReadFile)];
        self.navigationItem.rightBarButtonItem = chooseItem;
    }
	// Do any additional setup after loading the view.
}
- (void)chooseReadFile{
    UpAndDownloadViewController * ctr = [[UpAndDownloadViewController alloc]initWithStyle:UITableViewStyleGrouped];
    ctr.delegate = self;
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)uploadFilePath:(NSString *)fileUrl{
    [request release];
    NSURL *url = [NSURL URLWithString:[fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    request = [[NSMutableURLRequest alloc] initWithURL:url];
    [web loadRequest:request];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
