//
//  ListViewController.m
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//
#define viewFrame  self.view.frame
#import "ListViewController.h"
#import "DownloadLIstViewController.h"
#import "UpAndDownloadViewController.h"
#import <CloudSDK/CSCloudServer.h>
#import "WebViewController.h"
#import "CSCloudServerConfigurator.h"
#import "PermissionViewController.h"
#import <CloudSDK/CloudFile.h>
@interface ListViewController ()

@end

@implementation ListViewController
@synthesize currentFolder;
@synthesize cloudServer =_cloudServer;
@synthesize indicatorView =_indicatorView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        currentFolder = [[CloudFile alloc]init];
        _fileArray = [[NSMutableArray alloc]init];
        _folderArray = [[NSMutableArray alloc]init];
        _indexPath = [[NSIndexPath alloc]init];
        _cloudServer = [[CSCloudServer alloc] init];
    }
    return self;
}
- (void)dealloc{
    _cloudServer.delegate = nil;
 //   [CSDownloadManager sharedManager].delegate = nil;
    [currentFolder          release];
    [_cloudServer           release];
    [_fileArray             release];
    [_folderArray           release];
    [_indexPath             release];
    [_indicatorView         release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _indicatorView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(viewFrame.size.width/2-25, viewFrame.size.height/2-50, 50, 50);
    _indicatorView.hidesWhenStopped = YES;
    _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:_indicatorView];

    UIBarButtonItem * choosedItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(choosedItem)];
    self.navigationItem.rightBarButtonItem = choosedItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_indicatorView stopAnimating];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - upload
- (void)choosedItem{
    NSMutableArray *chooseArr = [[[NSMutableArray alloc] initWithObjects:@"Select files to upload",@"Download list", nil] autorelease];
    if ([_cloudServer respondsToSelector:@selector(createNewFolder:inFolder:) ]) {
        if (!(_cloudServer.serverType == CSEvernote && currentFolder != nil)) {
            [chooseArr addObject:@"Create folder"];
        }
       
    }
    [chooseArr addObject:@"cancel"];
    UIActionSheet * chooseSheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
    for (NSString * title in chooseArr) {
        [chooseSheet addButtonWithTitle:title];
    }
    chooseSheet.tag = 110;
    [chooseSheet showInView:self.view];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (alertView.tag == 404 ) {
        if (buttonIndex == 1) {
            NSString * folderName = [alertView textFieldAtIndex:0].text;
            [_indicatorView startAnimating];
            [_cloudServer createNewFolder:folderName inFolder:currentFolder];
        }
    }else if(alertView.tag == 505){
        if (buttonIndex == 1) {
            [_indicatorView startAnimating];
            NSString * folderName = [alertView textFieldAtIndex:0].text;
            UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
            cell.detailTextLabel.text = @"rename";
            [_cloudServer renameFile:[_fileArray objectAtIndex:_index] withName:folderName];
        }
    }
}
- (void)alertViewCancel:(UIAlertView *)alertView{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section == 0) {
        return [_folderArray count];
    }else{
        return [_fileArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                             ];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    // Configure the cell...
    CloudFile * file = nil;
    NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"FilesIcons" ofType:@"bundle"]];
   
    NSString *filePath = nil;
    if (indexPath.section == 0) {
        filePath =  [imageBundle pathForResource:@"icon_CSfolder"  ofType:@"png"];
         cell. accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        file =(CloudFile *)[_folderArray objectAtIndex:indexPath.row];
    }
    else{
         file = (CloudFile *)[_fileArray objectAtIndex:indexPath.row];
        filePath =  [imageBundle pathForResource:[NSString stringWithFormat:@"icon_%@",[self filehasSuffix:file.fileName]] ofType:@"png"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    cell.textLabel.text = file.fileName;
    return cell;
}
-(NSString*)filehasSuffix:(NSString*)filename{
    if(filename && [filename length]>0)
    {
        NSString *  icon = [[CSCloudServerConfigurator fileTypes] objectForKey:[[filename pathExtension] lowercaseString]];
        if(!icon) icon = @"CSnone";
        return icon;
    }
    else
    {
        return @"CSnone";
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if(_cloudServer.serverType == CSEvernote){
        if(indexPath.section == 0){
            return YES;
        }else{
            return NO;
        }
    }else if(_cloudServer.serverType == CSFTP){
        if(indexPath.section == 0){
            return NO;
        }else{
            return YES;
        }
    }else if (_cloudServer.serverType == CSMyDisk || _cloudServer.serverType == CSWebDav || _cloudServer.serverType == CSSugarSync){
        return NO;
    }else{
        return YES;
    }

}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([_cloudServer respondsToSelector:@selector(deleteFile:)]) {
            _cloudServer.delegate = self;
            [_indexPath release];
            _indexPath = [indexPath retain];
            UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
            cell.detailTextLabel.text = @"delete";
            if (indexPath.section == 0) {
                [_cloudServer deleteFile:[_folderArray objectAtIndex:indexPath.row]];
                
            }
            else {
                [_cloudServer deleteFile:[_fileArray objectAtIndex:indexPath.row]];
            }

        }
        else{
            UIAlertView * noDelte = [[[UIAlertView alloc] initWithTitle:nil message:@"Uable to delete" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] autorelease];
            noDelte.tag = 606;
            [noDelte show];
        }
              // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    _index = indexPath.row;
    [_indexPath release];
    _indexPath = [indexPath retain];
    
    if (indexPath.section == 0) {
         ListViewController * lisView = [[[ListViewController alloc]initWithStyle:UITableViewStyleGrouped] autorelease];
        lisView.currentFolder = (CloudFile *)[_folderArray objectAtIndex:indexPath.row] ;
        lisView.cloudServer = self.cloudServer ;
        lisView.cloudServer.delegate = lisView;
        [self.navigationController pushViewController:lisView animated:YES];
        [lisView.cloudServer getListAndFolderByFoler:[_folderArray objectAtIndex:indexPath.row]];
        [lisView.indicatorView startAnimating];
    }
else{
    NSMutableArray *sheetTitleArr = [[[NSMutableArray alloc] init] autorelease];
    [sheetTitleArr addObject:@"Download"];
    if ([_cloudServer respondsToSelector:@selector(renameFile:withName:)]) {
        [sheetTitleArr addObject:@"Rename"];
    }
    if ([_cloudServer respondsToSelector:@selector(addToDownloadList:withSavePath:)]) {
        [sheetTitleArr addObject:@"Add to download list"];
    }
    CloudFile *file = [_fileArray objectAtIndex:indexPath.row];
    if (file.canOnline) {
        [sheetTitleArr addObject:@"Edit online"];
    }
    if([_cloudServer respondsToSelector:@selector(getPermissionList:)]){
        [sheetTitleArr addObject:@"Permission management"];
    }
    [sheetTitleArr addObject:@"cancel"];
    
    UIActionSheet * sheet = [[[UIActionSheet alloc]initWithTitle:@"Download" delegate:self  cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
    for (NSString * title in sheetTitleArr) {
        [sheet addButtonWithTitle:title];
    }
    sheet.tag = 120;
    [sheet showInView:self.view];
    
}

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _cloudServer.delegate = self;
    if (buttonIndex > actionSheet.numberOfButtons || buttonIndex <0) {
        return;
    }
    NSString * sheetTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (actionSheet.tag == 120) {
        if ([sheetTitle isEqualToString:@"Download"]) {
            UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
            cell.detailTextLabel.text = @"downloading";
     //       [CSDownloadManager sharedManager].delegate = self;
            [_cloudServer downloadFile:[_fileArray objectAtIndex:_index] toPath:[CSCloudServerConfigurator downloadFileSavePath]];
            [_indicatorView startAnimating];
            
        }else if([sheetTitle isEqualToString:@"Rename"]){
            NSString * fileName = [NSString stringWithFormat:@"Original file name：%@",[[_fileArray objectAtIndex:_index] fileName]];
            UIAlertView * alertViewCt = [[UIAlertView alloc] initWithTitle:@"Rename" message:fileName delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
            alertViewCt.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertViewCt.tag = 505;
            [alertViewCt show];
            [alertViewCt  release];
            
        }else if([sheetTitle isEqualToString:@"Add to download list"]){
            CloudFile * file = (CloudFile *)[_fileArray objectAtIndex:_index];
            [_cloudServer addToDownloadList:file withSavePath:[CSCloudServerConfigurator downloadFileSavePath]];
        }else if([sheetTitle isEqualToString:@"Edit online"]){
            WebViewController *onlineCtr = [[[WebViewController alloc] init] autorelease];
            onlineCtr.request = [_cloudServer getOnlineEditorURL:[_fileArray objectAtIndex:_index]];
            [self.navigationController pushViewController:onlineCtr animated:YES];
        }else if([sheetTitle isEqualToString:@"Permission management"]){
            CloudFile * file = (CloudFile *)[_fileArray objectAtIndex:_index];
            PermissionViewController *permissionView = [[[PermissionViewController alloc]initWithStyle:UITableViewStyleGrouped]autorelease];
            permissionView.title = file.fileName;
            permissionView.permissionFile = file;
            permissionView.server = _cloudServer;
            permissionView.server.delegate = permissionView;
            [self.navigationController pushViewController:permissionView animated:YES];
            
        }

        else{
            return;
        }

    }
    else{//:@"选择文件上传",@"下载列表",
        if ([sheetTitle isEqualToString:@"Select files to upload"]) {
            UpAndDownloadViewController * ctr = [[UpAndDownloadViewController alloc]initWithStyle:UITableViewStyleGrouped];
            ctr.delegate = self;
            [self.navigationController pushViewController:ctr animated:YES];
            [ctr release];
        }else if([sheetTitle isEqualToString:@"Download list"]){
            DownloadLIstViewController * listCtr = [[DownloadLIstViewController alloc]init];
            [self.navigationController pushViewController:listCtr animated:YES];
            [listCtr release];
            
        }else if([sheetTitle isEqualToString:@"Create folder"]){
          
            UIAlertView * alertViewCt = [[UIAlertView alloc] initWithTitle:nil message:@"Rename" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
            alertViewCt.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertViewCt.tag = 404;
            [alertViewCt show];
            [alertViewCt  release];
        }
    }
     
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}


#pragma mark - new Delegate
- (void)serverGetListAndFolderSuccess:(CSCloudServer *)server folder:(NSArray *)folder andFile:(NSArray *)fileArr{
    [_indicatorView stopAnimating];
    [_folderArray removeAllObjects];
    [_fileArray  removeAllObjects];
    [_fileArray addObjectsFromArray:fileArr];
    [_folderArray addObjectsFromArray:folder];
    [self.tableView reloadData];
}
- (void)serverGetLisAndFolderFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Failed to access download list" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alt show];
    [alt release];
}

- (void)serverUploadFileSuccess:(CSCloudServer *)server{
    [_indicatorView stopAnimating];
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Upload Successful" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    [alt release];
    [server getListAndFolderByFoler:currentFolder];
    MyLog(@"%@  uploadSuccess",server.serverName);
}
- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error{
    
    [_indicatorView stopAnimating];
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Upload failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    MyLog(@"%@  uploadFile",server.serverName);
}

- (void)serverDownloadSuccess:(CSCloudServer *)server{
    MyLog(@"%@  downloadSuccess",server.serverName);
     [_indicatorView stopAnimating];
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Download successful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    [alt release];
}
- (void)serverDownloadFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Download failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alt show];
}


- (void)serverDeleteFileSuccess:(CSCloudServer *)server{
    if (_indexPath == nil) {
        return;
    }
    if (_indexPath.section == 0) {
        [_folderArray removeObjectAtIndex:_indexPath.row];
    }
    else{
        [_fileArray removeObjectAtIndex:_indexPath.row];
    }
    [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath] withRowAnimation: UITableViewRowAnimationFade];
}
- (void)serverDeleteFileFaile:(CSCloudServer *)server withError:(NSError *)error{
    MyLog(@"deleteFileError %@",server.serverName);
}

- (void)serverAddToDownloadListSuccess:(CSCloudServer *)server{
    
}
- (void)serverAddToDownloadFaile:(CSCloudServer *)server withError:(NSError *)error{
    
}

- (void)serverRenameSuccess:(CSCloudServer *)server{
    MyLog(@"renameSuccess   %@",server.serverName);
    [_indicatorView stopAnimating];
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    [server getListAndFolderByFoler:currentFolder];
}
- (void)serverRenameFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    MyLog(@"renameError  %@",server.serverName);
}

- (void)serverCreatFolderSuccess:(CSCloudServer *)server{
    [_indicatorView stopAnimating];
    MyLog(@"creatFolderSuccess  %@",server.serverName);
    [server getListAndFolderByFoler:currentFolder];

}
- (void)serverCreatFolderFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    MyLog(@"creatFolderError   %@",server.serverName);
    [server getListAndFolderByFoler:currentFolder];
}
- (void)taskDownloadSuccess:(NSString *)name{
   
    [_indicatorView stopAnimating];
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Download successful" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    [alt release];
    
}
- (void)taskDownloadFaile:(NSString *)name withError:(NSError *)error{
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Download failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];

}

#pragma mark- chooseFileDelegate 
- (void)uploadFilePath:(NSString *)fileUrl{
    [_indicatorView startAnimating];
    [_cloudServer uploadFilePath:fileUrl toFolder:currentFolder];
}
- (void)uploadFilePathArr:(NSArray *)fileArr{
    [_indicatorView startAnimating];
    [_cloudServer uploadFiles:fileArr toFolder:currentFolder];
}
@end
