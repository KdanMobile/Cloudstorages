//
//  ChooseServerViewController.m
//  CloudStorages
//
//  Created by zhujunyu on 13-8-10.
//  Copyright (c) 2013 year kdanmobile. All rights reserved.
//

#import "ChooseServerViewController.h"
#import <CloudSDK/CSCloudServer.h>
#import "LoginViewController.h"
@interface ChooseServerViewController ()

@end

@implementation ChooseServerViewController
@synthesize serverArr;
@synthesize delegate;
@synthesize isUpload;
@synthesize filePath;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        serverArr = [[NSMutableArray alloc] init];
        filePath = [[NSString alloc] init];
         _server = [[CSCloudServer alloc]init];
    }
    return self;
}
- (void)dealloc{
    _server.delegate = nil;
    [serverArr                      release];
    [filePath                       release];
    [_server                        release];
    [super                          dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    _inDicView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _inDicView.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 50, 50);
    _inDicView.hidesWhenStopped = YES;
    _inDicView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_inDicView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:animated];
    if (isUpload) {
        [serverArr removeAllObjects];
        [serverArr addObjectsFromArray:[CSCloudServer getAllLoginServer]];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [serverArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    CSCloudServer *servers = [serverArr objectAtIndex:indexPath.row];
    cell.textLabel.text = servers.serverName;
    cell.detailTextLabel.text = servers.userName;
 //   cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cloud_%@.png",cell.textLabel.text]];
    NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CloudIcons" ofType:@"bundle"]];
    NSString *fileIconPath = [imageBundle pathForResource:[NSString stringWithFormat:@"cloud_%@",cell.textLabel.text] ofType:@"png"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:fileIconPath];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [_server autorelease];
      _server = [[serverArr objectAtIndex:indexPath.row] retain];
    _server.delegate = self;
    if (isUpload) {
        [_inDicView startAnimating];
        [_server uploadFilePath:filePath toFolder:nil];
        
    }
    else{
        self.title = @"Authenticating";
        if (_server.isWebLogin) {
            [_server loginFromController:self];
        }
        else{
            LoginViewController *loginCtr = [[LoginViewController alloc] init];
            loginCtr.delegate = self;
            loginCtr.type = _server.serverType;
            [self.navigationController pushViewController:loginCtr animated:YES];

        }
       
        
    }
}
- (void)serverLoginSuccess:(CSCloudServer *)server{
    self.title = nil;
    [self.navigationController popViewControllerAnimated:NO];
    if ([self.delegate respondsToSelector:@selector(logInSuccess:)]) {
        [self.delegate logInSuccess:server];
    }
}
- (void)serverLoginFaile:(CSCloudServer *)server withError:(NSError *)error{
    self.title = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Log in failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alt show];
    [alt release];
}
- (void)serverUploadFileSuccess:(CSCloudServer *)server{
    MyLog(@"uploadSuccess ");
    [_inDicView stopAnimating];
    server.delegate = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Upload Successful" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alt show];
    [alt release];
    [self.navigationController popViewControllerAnimated:NO];
    
   
}
- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_inDicView stopAnimating];
    server.delegate = nil;
       MyLog(@"%@  uploadFile",server.serverName);
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Upload failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alt show];
    [alt release];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)loginUserName:(NSString *)name andPassWord:(NSString *)passWord andHost:(NSString *)host andPort:(NSString *)port{
    _server.userName = name;
    _server.password = passWord;
    _server.hostName = host;
    _server.portID = port;
    [_server loginFromController:nil];
    
    
}
@end
