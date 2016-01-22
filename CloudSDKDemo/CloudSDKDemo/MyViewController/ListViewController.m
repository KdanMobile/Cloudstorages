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
#import "WebViewController.h"
#import "PermissionViewController.h"
#import "ActivityView.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize currentFolder;
@synthesize indicatorView =_indicatorView;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        currentFolder = [[CloudFile alloc]init];
        _fileArray = [[NSMutableArray alloc]init];
        _folderArray = [[NSMutableArray alloc]init];
        _indexPath = [[NSIndexPath alloc]init];
        self.cloudServer = [[[CSCloudServer alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc {
    if (self == _cloudServer.delegate)
        _cloudServer.delegate = nil;
    [currentFolder          release];
    [_cloudServer           release];
    [_fileArray             release];
    [_folderArray           release];
    [_indexPath             release];
    [_indicatorView         release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _indicatorView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(viewFrame.size.width/2-25, viewFrame.size.height/2-50, 50, 50);
    _indicatorView.hidesWhenStopped = YES;
    _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:_indicatorView];

    UIBarButtonItem * choosedItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(choosedItem)];
    self.navigationItem.rightBarButtonItem = choosedItem;
    
    [[ActivityView activityView] setTitle:@"Loading..."];
    
    [[ActivityView activityView] showWithAnimated:YES
                                           inView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    _cloudServer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
//    if (self == _cloudServer.delegate)
//        _cloudServer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - upload
- (void)choosedItem {
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
            [[ActivityView activityView] setTitle:@"Create..."];
            [[ActivityView activityView] showWithAnimated:YES
                                                   inView:self.view];
            [_cloudServer createNewFolder:folderName inFolder:currentFolder];
        }
    }else if(alertView.tag == 505){
        if (buttonIndex == 1) {
            [_indicatorView startAnimating];
            [[ActivityView activityView] setTitle:@"Rename..."];
            [[ActivityView activityView] showWithAnimated:YES
                                                   inView:self.view];
            NSString * folderName = [alertView textFieldAtIndex:0].text;
            UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
            cell.detailTextLabel.text = @"rename";
            if (_indexPath.section == 0)
                [_cloudServer renameFile:[_folderArray objectAtIndex:_index] withName:folderName];
            else
                [_cloudServer renameFile:[_fileArray objectAtIndex:_index] withName:folderName];
        }
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView {
    
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    // Configure the cell...
    CloudFile * file = nil;
    NSBundle * imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"FilesIcons" ofType:@"bundle"]];
   
    NSString *filePath = nil;
    if (indexPath.section == 0) {
        filePath =  [[imageBundle pathForResource:@"icon_CSfolder"
                                          ofType:@"png"] copy];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        file =[(CloudFile *)[_folderArray objectAtIndex:indexPath.row] retain];
    }
    else{
         file = [(CloudFile *)[_fileArray objectAtIndex:indexPath.row] retain];
        filePath =  [[imageBundle pathForResource:[NSString stringWithFormat:@"icon_%@",[self filehasSuffix:file.fileName]]
                                          ofType:@"png"] copy];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    [cell.textLabel setText:file.fileName?:@""];
    [filePath autorelease];
    [file autorelease];
    
    return cell;
}

- (NSString*)filehasSuffix:(NSString*)filename {
    if(filename && [filename length]>0)
    {
        NSString *  icon = [[CSCloudServerConfigurator defaultConfig].supportFileTypes objectForKey:[[filename pathExtension] lowercaseString]];
        if(!icon) icon = @"CSnone";
        return icon;
    }
    else
    {
        return @"CSnone";
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (NSArray *)           tableView:(UITableView *)tableView
     editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *editActions  = [NSMutableArray array];
    
    if (indexPath.section == 0) {
        if ([_cloudServer canDeleteFolder]) {
            UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                              title:@"Delete"
                                                                            handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
            {
                [_indexPath release];
                _indexPath = [indexPath retain];
                [[tableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:YES];
                [_cloudServer deleteFile:[_folderArray objectAtIndex:indexPath.row]];
            }];
            action.backgroundColor = [UIColor redColor];
            [editActions addObject:action];
        }
    }else {
        if ([_cloudServer canDeleteFile]) {
            UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                              title:@"Delete"
                                                                            handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
            {
                [_indexPath release];
                _indexPath = [indexPath retain];
                [[tableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:YES];
                [_cloudServer deleteFile:[_fileArray objectAtIndex:indexPath.row]];
            }];
            action.backgroundColor = [UIColor redColor];
            [editActions addObject:action];
        }
    }
    if ([_cloudServer canRename]) {
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:@"Rename"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
        {
            [[tableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:YES];
            _index = indexPath.row;
            [_indexPath release];
            _indexPath = [indexPath retain];
            
            NSString * fileName = nil;
            if (indexPath.section == 0)
                fileName = [NSString stringWithFormat:@"Original folder name：%@",[[_folderArray objectAtIndex:indexPath.row] fileName]];
            else
                fileName = [NSString stringWithFormat:@"Original file name：%@",[[_fileArray objectAtIndex:indexPath.row] fileName]];
            UIAlertView * alertViewCt = [[UIAlertView alloc] initWithTitle:@"Rename" message:fileName delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
            alertViewCt.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertViewCt.tag = 505;
            [alertViewCt show];
            [alertViewCt  release];
        }];
        action.backgroundColor = [UIColor blueColor];
        [editActions addObject:action];
    }
    
    return editActions;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return [_cloudServer canDeleteFolder];
    }else{
        return [_cloudServer canDeleteFile];
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
        else {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _index = indexPath.row;
    [_indexPath release];
    _indexPath = [indexPath retain];
    
    if (indexPath.section == 0) {
         ListViewController * lisView = [[[ListViewController alloc]initWithStyle:UITableViewStylePlain] autorelease];
        lisView.currentFolder = (CloudFile *)[_folderArray objectAtIndex:indexPath.row] ;
        lisView.cloudServer = self.cloudServer ;
        lisView.cloudServer.delegate = lisView;
        [self.navigationController pushViewController:lisView animated:YES];
        [lisView.cloudServer getListAndFolderByFoler:[_folderArray objectAtIndex:indexPath.row]];
        [lisView.indicatorView startAnimating];
    } else {
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
            [_cloudServer downloadFile:[_fileArray objectAtIndex:_index] toPath:[CSCloudServerConfigurator defaultConfig].downloadFileSavePath];
            [_indicatorView startAnimating];
            [[ActivityView activityView] setTitle:@"Downloading..."];
            [[ActivityView activityView] showWithAnimated:YES
                                                   inView:self.view];
            
        }else if([sheetTitle isEqualToString:@"Rename"]){
            NSString * fileName = [NSString stringWithFormat:@"Original file name：%@",[[_fileArray objectAtIndex:_index] fileName]];
            UIAlertView * alertViewCt = [[UIAlertView alloc] initWithTitle:@"Rename" message:fileName delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
            alertViewCt.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertViewCt.tag = 505;
            [alertViewCt show];
            [alertViewCt  release];
            
        }else if([sheetTitle isEqualToString:@"Add to download list"]){
            CloudFile * file = (CloudFile *)[_fileArray objectAtIndex:_index];
            [_cloudServer addToDownloadList:file withSavePath:[CSCloudServerConfigurator defaultConfig].downloadFileSavePath];
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
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    [_folderArray removeAllObjects];
    [_fileArray  removeAllObjects];
   
    if (fileArr.count)
        [_fileArray addObjectsFromArray:fileArr];
    if (folder.count)
        [_folderArray addObjectsFromArray:folder];
    
    [self.tableView reloadData];
}
- (void)serverGetLisAndFolderFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Failed to access download list" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alt show];
    [alt release];
}

- (void)serverUploadFileSuccess:(CSCloudServer *)server{
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Upload Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    [alt release];
    [server getListAndFolderByFoler:currentFolder];
    MyLog(@"%@  uploadSuccess",server.serverName);
}

- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error {
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Upload failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    MyLog(@"%@  uploadFile",server.serverName);
}

- (void)serverDownloadSuccess:(CSCloudServer *)server{
    MyLog(@"%@  downloadSuccess",server.serverName);
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Download Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alt show];
    [alt release];
}

- (void)serverDownloadFaile:(CSCloudServer *)server withError:(NSError *)error{
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
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    [server getListAndFolderByFoler:currentFolder];
}
- (void)serverRenameFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    MyLog(@"renameError  %@",server.serverName);
}

- (void)serverCreatFolderSuccess:(CSCloudServer *)server{
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    MyLog(@"creatFolderSuccess  %@",server.serverName);
    [server getListAndFolderByFoler:currentFolder];

}
- (void)serverCreatFolderFaile:(CSCloudServer *)server withError:(NSError *)error{
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    MyLog(@"creatFolderError   %@",server.serverName);
    [server getListAndFolderByFoler:currentFolder];
}

- (void)taskDownloadSuccess:(NSString *)name {
    [_indicatorView stopAnimating];
    [[ActivityView activityView] hiddenWithAnimated:YES];
    
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text = nil;
    UIAlertView * alt  = [[UIAlertView alloc] initWithTitle:nil message:@"Download Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
    [[ActivityView activityView] setTitle:@"Uploading..."];
    [[ActivityView activityView] showWithAnimated:YES
                                           inView:self.view];
    
    [_cloudServer uploadFilePath:fileUrl toFolder:currentFolder];
}
- (void)uploadFilePathArr:(NSArray *)fileArr{
    [_indicatorView startAnimating];
    [[ActivityView activityView] setTitle:@"Uploading..."];
    [[ActivityView activityView] showWithAnimated:YES
                                           inView:self.view];
    [_cloudServer uploadFiles:fileArr toFolder:currentFolder];
}
@end
