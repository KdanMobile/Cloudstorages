//
//  MyMainViewController.m
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#define viewFrame  self.view.frame
#define SavePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#import "MyMainViewController.h"
#import "ListViewController.h"
#import "WebViewController.h"
#import "ChooseServerViewController.h"

@interface MyMainViewController ()

@end

@implementation MyMainViewController


- (void)dealloc{
    [_indexPath             release];
    [_tableView             release];
    [_infoArray             release];
    [_indicatorView         release];
    [_fileArray             release];
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;

}
#ifdef NSFoundationVersionNumber_iOS_5_1
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
#endif

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
    self.title = @"loginservers";
    _infoArray = [[NSMutableArray alloc]init];
    _fileArray = [[NSMutableArray alloc] init];
    _indexPath = [[NSIndexPath alloc] init];
        UIBarButtonItem * addItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(LoginCloud)] autorelease];
    self.navigationItem.rightBarButtonItem = addItem;
    _tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    [self.view addSubview:_tableView];
    _indicatorView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(viewFrame.size.width/2, viewFrame.size.height/2, 50, 50);
    _indicatorView.hidesWhenStopped = YES;
    _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_indicatorView];
   
  	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MyLog(@"test");
    [_infoArray removeAllObjects];
    [_infoArray addObjectsFromArray:[CSCloudServer getAllLoginServer]];
    [_tableView reloadData];
    
    [_fileArray removeAllObjects];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//程序文件夹主目录
    NSString *documentsDirectory = [paths objectAtIndex:0];//Document目录
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    [_fileArray addObjectsFromArray:arr];
    [_tableView reloadData];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  //  [CloudManager sharedManager].delegate = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark-tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return [_infoArray count];
    }
    else{
        return [_fileArray count];
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIder = @"cellIder";
    UITableViewCell * cell = [_tableView  dequeueReusableCellWithIdentifier:cellIder];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIder] autorelease];
    }
    if (indexPath.section == 0) {
        NSLog(@"description is %@",[[_infoArray objectAtIndex:indexPath.row] description]);
            cell.textLabel.text = [[_infoArray objectAtIndex:indexPath.row] serverName];
            cell.detailTextLabel.text = [[_infoArray objectAtIndex:indexPath.row] userName];
        NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CloudIcons" ofType:@"bundle"]];
        NSString *filePath = [imageBundle pathForResource:[NSString stringWithFormat:@"cloud_%@",cell.textLabel.text] ofType:@"png"];
            cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
     
    }
    else{
        cell.textLabel.text = [_fileArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
    }
    return cell;

}
#pragma mark- tableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"已经登入的云端";
    }
    else{
        return @"可以上传的文件";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      _index = indexPath.row;
    if (indexPath.section == 0) {
        CSCloudServer *server = [_infoArray objectAtIndex:indexPath.row];
        server.delegate = self;
        if (server.isLogin) {
            ListViewController * lisView = [[[ListViewController alloc]initWithStyle:UITableViewStylePlain] autorelease];
            lisView.cloudServer = [server retain];
            lisView.currentFolder = nil;
            lisView.cloudServer.delegate = lisView;
            [self.navigationController pushViewController:lisView animated:YES];
            [lisView.indicatorView startAnimating];
            [lisView.cloudServer getRootListAndFolder];
          
        }
        else if (server.isWebLogin ) {
                [_indicatorView startAnimating];
                [server loginFromController:self];
        }else{
                 [server loginFromController:nil];
        }
    }
    else{
        ChooseServerViewController *chooseServer = [[[ChooseServerViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
        chooseServer.filePath = [SavePath stringByAppendingPathComponent:[_fileArray objectAtIndex:indexPath.row]];
        chooseServer.isUpload = YES;
        [self.navigationController pushViewController:chooseServer animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        if (indexPath.section == 0) {
            [_indexPath release];
            _indexPath = [indexPath retain];
            CSCloudServer *server = [_infoArray objectAtIndex:indexPath.row];
            server.delegate = self;
            [server logout];
        }
        else{
          NSString *filePath = [SavePath stringByAppendingPathComponent:[_fileArray objectAtIndex:indexPath.row]];
            if ([[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL]) {
                [_fileArray removeObjectAtIndex:indexPath.row];
                
                [tableView deleteRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                return;
            }
        }
    }
}

#pragma mark- mymethod
- (void)LoginCloud {
    ChooseServerViewController *chooseLoginCtr = [[[ChooseServerViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    chooseLoginCtr.isUpload = NO;
    [chooseLoginCtr.serverArr removeAllObjects];
    chooseLoginCtr.delegate = self;
    
    CSCloudServer * box = [CSCloudServer cloudServerForType:CSBox];
    if (box) {
        box.delegate = self;
        [chooseLoginCtr.serverArr  addObject:box];
    }
    
    CSCloudServer *dropbox = [CSCloudServer cloudServerForType:CSDropbox];
    if (dropbox) {
        dropbox.delegate = self;
        [chooseLoginCtr.serverArr   addObject:dropbox];
    }
    
    CSCloudServer *google = [CSCloudServer cloudServerForType:CSGoogleDrive];
    if (google) {
        google.delegate = self;
        [chooseLoginCtr.serverArr   addObject:google];
    }
    
    CSCloudServer *googleDocs = [CSCloudServer cloudServerForType:CSGoogleDocs];
    if (googleDocs) {
        googleDocs.delegate = self;
        [chooseLoginCtr.serverArr   addObject:googleDocs];
    }
    
    CSCloudServer * ftp = [CSCloudServer cloudServerForType:CSFTP];
    if (ftp) {
        ftp.delegate = self;
        [chooseLoginCtr.serverArr   addObject:ftp];
    }
    
    CSCloudServer *everNote = [CSCloudServer cloudServerForType:CSEvernote];
    if (everNote) {
        everNote.delegate = self;
        [chooseLoginCtr.serverArr   addObject:everNote];
    }
    
    CSCloudServer * mydisk = [CSCloudServer cloudServerForType:CSMyDisk];
    if (mydisk) {
        mydisk.delegate = self;
        [chooseLoginCtr.serverArr   addObject:mydisk];
    }
    
    CSCloudServer * webDev = [CSCloudServer cloudServerForType:CSWebDav];
    if (webDev) {
        webDev.delegate = self;
        [chooseLoginCtr.serverArr   addObject:webDev];
    }
    
    CSCloudServer *sugarSync = [CSCloudServer cloudServerForType:CSSugarSync];
    if (sugarSync) {
        sugarSync.delegate = self;
        [chooseLoginCtr.serverArr   addObject:sugarSync];
    }
    
    CSCloudServer *skyDrive = [CSCloudServer cloudServerForType:CSOneDrive];
    if (skyDrive) {
        skyDrive.delegate = self;
        [chooseLoginCtr.serverArr addObject:skyDrive];
    }
    CSCloudServer *iCloud = [CSCloudServer cloudServerForType:CSICloud];
    if(iCloud)
    {
        iCloud.delegate = self;
        [chooseLoginCtr.serverArr addObject:iCloud];
    }

    [self.navigationController pushViewController:chooseLoginCtr animated:YES];
}


#pragma mark - cloudDelegate

- (void)serverLoginSuccess:(CSCloudServer *)server{
   self.navigationItem.leftBarButtonItem = nil;
    [_indicatorView stopAnimating];
    ListViewController * lisView1 = [[ListViewController alloc]initWithStyle:UITableViewStylePlain] ;
    lisView1.cloudServer = [server retain];
    lisView1.cloudServer.delegate = lisView1;
    lisView1.currentFolder = nil;
    [self.navigationController pushViewController:lisView1 animated:YES];
    [lisView1.cloudServer getRootListAndFolder];
    [lisView1 release];
}

- (void)serverLoginFaile:(CSCloudServer *)server withError:(NSError *)error{
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)serverLogoutSuccess:(CSCloudServer *)server{
    [_infoArray removeObject:server];
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath] withRowAnimation: UITableViewRowAnimationFade];
}

- (void)serverLogoutFaile:(CSCloudServer *)server withError:(NSError *)error{
    
}

- (void)serverUploadFileSuccess:(CSCloudServer *)server{
    [_indicatorView stopAnimating];
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"上传成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alt show];
    [alt release];
    MyLog(@"%@  uploadSuccess",server.serverName);
}
- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error{
    
    [_indicatorView stopAnimating];
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alt show];
    MyLog(@"%@  uploadFile",server.serverName);
}
- (void)logInSuccess:(CSCloudServer *)server{
    [self performSelector:@selector(logIn:) withObject:server afterDelay:1.0f];

}
- (void)logIn:(CSCloudServer *)server{
    ListViewController * lisView1 = [[ListViewController alloc]initWithStyle:UITableViewStylePlain] ;
    lisView1.cloudServer = [server retain];
    lisView1.cloudServer.delegate = lisView1;
    lisView1.currentFolder = nil;
    [self.navigationController pushViewController:lisView1 animated:NO];
    [lisView1.cloudServer getRootListAndFolder];
    [lisView1 release];
}
- (void)logIn:(CSCloudServer *)server withError:(NSError *)error{
    MyLog(@"登入失败");
}
@end
