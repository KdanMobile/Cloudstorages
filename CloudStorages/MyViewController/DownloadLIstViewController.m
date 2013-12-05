//
//  DownloadLIstViewController.m
//  CloudStorages
//
//  Created by zhu on 13-7-18.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//

#import "DownloadLIstViewController.h"
#import <CloudSDK/CSDownloadTask.h>
#import "WebViewController.h"
#import "TaskCell.h"
#define SavePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]
@interface DownloadLIstViewController ()

@end

@implementation DownloadLIstViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc{
 //   [CSDownloadManager sharedManager].delegate = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _downloadArray = [[NSMutableArray alloc]init];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_downloadArray removeAllObjects];
    [_downloadArray addObjectsFromArray:[CSDownloadManager sharedManager].taskArray];
  //  [CSDownloadManager sharedManager].delegate = self;
  
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
    return [_downloadArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TaskCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
    }
    // Configure the cell...
    CSDownloadTask * task = [_downloadArray objectAtIndex:indexPath.row];
    [cell displayWithTask:task];
//    MyLog(@"%lld  %lld",task.fileSize,task.receivedSize);
//    cell.textLabel.text = [[_downloadArray objectAtIndex:indexPath.row] fileName];
//    NSString * state = nil;
//    switch ([[_downloadArray objectAtIndex:indexPath.row]  downloadState]) {
//        case kCSDownloadStateFinished:
//            state = @"finished";
//            break;
//        case kCSDownloadStateFailed:{
//             state = @"faile";break;
//        }
//        case kCSDownloadStateRunning:{
//            state = @"downloading";
//        }break;
//        case kCSDownloadStateStopped:{
//            state = @"stop";
//        }break;
//        default:{
//             state = @"none";
//        }
//           
//            break;
//    }
//    if (task.fileSize != 0) {
//        state = [state stringByAppendingFormat:@" 文件大小%0.0fkb  %0.0f%%", (float)task.fileSize/1000.0,((float)task.receivedSize/task.fileSize) * 100];
//    }
//   
//    cell.detailTextLabel.text = state;
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
   
    _index = indexPath.row;
    TaskCell *cell = (TaskCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell start];
    UIActionSheet *chooseSheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Pause",@"Start download",@"Delete download task", nil] autorelease];
    [chooseSheet showInView:self.view];
    // Navigation logic may go here. Create and push another view controller.
    /*
     ， *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [[_downloadArray objectAtIndex:_index] stopRunning];
        }break;
        case 1:{
            [[_downloadArray objectAtIndex:_index] startRunning];
        }break;
        case 2:{
            [[_downloadArray objectAtIndex:_index] deleteTask];
            [_downloadArray removeAllObjects];
            [_downloadArray addObjectsFromArray:[CSDownloadManager sharedManager].taskArray];
            [self.tableView reloadData];
        }break;
        default:
            break;
    }
}
#pragma mark - my
- (void)edit{
    UIAlertView * alt = [[UIAlertView alloc]initWithTitle:@"Edit" message:@"Select" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Start download",@"Clear completed tasks", nil];
    [alt show];
    [alt release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex){
        case 0:{

        }break;
        case 1:{
            [[CSDownloadManager sharedManager] startDownload];
        }break;
        case 2:{
            [[CSDownloadManager sharedManager] deleteFinishTask];
            [_downloadArray removeAllObjects];
            [_downloadArray addObjectsFromArray:[CSDownloadManager sharedManager].taskArray];
            [self.tableView reloadData];
        }break;
        case 3:{
            
            NSArray *filearr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:SavePath error:nil];
            NSString *filePath = nil;
            if ([filearr count] >2) {
                filePath = [SavePath stringByAppendingPathComponent:[filearr objectAtIndex:1]];
            }else{
                filePath = @"";
            }
            NSURL *url = [NSURL URLWithString:[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            WebViewController *web = [[[WebViewController alloc] init] autorelease];
            web.chooseRead = YES;
            NSMutableURLRequest * urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
            web.request  = urlRequest;
            [self.navigationController pushViewController:web animated:YES];
        }break;
    }
}
#pragma mark - cloudDelegate

- (void)changeDownloadState{
    [_downloadArray removeAllObjects];
    [_downloadArray addObjectsFromArray:[CSDownloadManager sharedManager].taskArray];
    [self.tableView reloadData];
    
}
- (void)taskStateChange:(CSDownloadTask *)task{
    [_downloadArray removeAllObjects];
    [_downloadArray addObjectsFromArray:[CSDownloadManager sharedManager].taskArray];
    [self.tableView reloadData];
}
- (void)taskDownloadProgress:(CSDownloadTask *)task{
    MyLog(@"mFileSize:(%lld) and downloadSiz:(%lld)",task.fileSize,task.receivedSize);
    [_downloadArray removeAllObjects];
    [_downloadArray addObjectsFromArray:[CSDownloadManager sharedManager].taskArray];
    [self.tableView reloadData];
}
@end
