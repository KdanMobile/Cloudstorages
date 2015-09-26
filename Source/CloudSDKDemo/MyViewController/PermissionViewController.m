//
//  PermissionViewController.m
//  CloudStorages
//
//  Created by kdanmobile on 13-11-28.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import "PermissionViewController.h"

@interface PermissionViewController ()

@end

@implementation PermissionViewController
@synthesize server = _server;
@synthesize permissionFile = _permissionFile;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        permissionArray = [[NSMutableArray alloc]init];
        _server = [[CSCloudServer alloc]init];
        _permissionFile = [[CloudFile alloc]init];
        _indexPath = [[NSIndexPath alloc]init];
    }
    return self;
}

- (void)dealloc {
    [_server release];
    [_permissionFile release];
    [permissionArray release];
    [_indexPath release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_server getPermissionList:_permissionFile];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPermission)];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [permissionArray count];
    }else{
        return 1;
    }
   
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if(indexPath.section == 0){
        if([[[permissionArray objectAtIndex:indexPath.row] permissionRole] isEqualToString:@"owner"]){
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [_indexPath release];
             _indexPath = [indexPath retain];
                [_server deletePermission:_permissionFile atPermissionID:[permissionArray objectAtIndex:indexPath.row]];
          //  [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
        }
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        static NSString *identifier = @"权限者";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        }
        
        if ([permissionArray count] > 0) {
            cell.textLabel.text = [[permissionArray objectAtIndex:indexPath.row] permissionName];
            cell.detailTextLabel.text = [[permissionArray objectAtIndex:indexPath.row] permissionRole];

        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        static NSString *identifier = @"文件信息";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        }
        
        cell.textLabel.text = _permissionFile.fileName;
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
    // Configure the cell...
    
    
}

-(void)addPermission{
    UIAlertView *addAlert = [[UIAlertView alloc]initWithTitle:nil
                                                      message:@"Names,email addresses,or groups"
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:@"Cancel", nil] ;
    addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    addAlert.tag = 11;
    addAlert.delegate = self;
    [addAlert show];
    [addAlert release];
}

#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
            
            NSString *userName = [[alertView textFieldAtIndex:0] text];
            
            if (![userName length]) {
                return;
            }
            
            [_server insertPermission:userName wihtRole:@"reader" toFile:_permissionFile];
        }
    }
}

#pragma mark 获取权限者代理
-(void)getFilePermissionListSuccessful:(CSCloudServer *)server withList:(NSArray *)listName{
    [permissionArray removeAllObjects];
  
    [permissionArray addObjectsFromArray:listName];
    [self.tableView reloadData];
    
}

-(void)getFilePermissionListFailed:(CSCloudServer *)server withError:(NSError *)error{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"操作失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alter show];
    [alter release];
}

#pragma mark 添加权限者代理
-(void)insertPermissionSuccessful:(CSCloudServer *)server withFile:(CloudFile *)file withPermission:(CSPermission *)permission{
    [_server getPermissionList:file];
}
-(void)insertPermissionFailed:(CSCloudServer *)server withFile:(CloudFile *)file withError:(NSError *)error{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"操作失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alter show];
    [alter release];
}
#pragma mark 删除权限者代理
-(void)deletePermissionSuccessful:(CSCloudServer *)server withFile:(CloudFile *)file withPermission:(CSPermission *)permission{
    if (_indexPath.section == 0) {
        [permissionArray removeObjectAtIndex:_indexPath.row];
    }
    [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath] withRowAnimation: UITableViewRowAnimationFade];
}

-(void)deletePermissionFailed:(CSCloudServer *)server withFile:(CloudFile *)file withPermission:(CSPermission *)permission withError:(NSError *)error{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"操作失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alter show];
    [alter release];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
