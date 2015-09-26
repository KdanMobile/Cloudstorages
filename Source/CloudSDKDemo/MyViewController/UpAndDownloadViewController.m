//
//  UpAndDownloadViewController.m
//  CloudStorages
//
//  Created by zhujunyu on 13-7-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import "UpAndDownloadViewController.h"

@interface UpAndDownloadViewController ()

@end

@implementation UpAndDownloadViewController

@synthesize delegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _fileArray = [[NSMutableArray alloc]init];
        _chooseArr = [[NSMutableArray alloc] init];
        
               // Custom initialization
    }
    return self;
}
- (void)dealloc{
    [_fileArray release];
    [_chooseArr release];
    delegate = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigaterBarItemInit];
    self.title = @"单个上传";
    _arrChoose = NO;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//程序文件夹主目录
    NSString *documentsDirectory = [paths objectAtIndex:0];//Document目录
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    [_fileArray addObjectsFromArray:arr];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)navigaterBarItemInit{
    
    UIView *rightView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 73*2, 44)] autorelease];
    rightView.backgroundColor = [UIColor clearColor];
    _choosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _choosBtn.frame= CGRectMake(0, 0, 73, 44);
    [_choosBtn addTarget:self action:@selector(uploadArr) forControlEvents:UIControlEventTouchUpInside];
    [_choosBtn setBackgroundImage:[UIImage  imageNamed:@"cloud_choose.png"] forState:UIControlStateNormal];
    [_choosBtn setTitle:@"选择多个" forState:UIControlStateNormal];
    _choosBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _choosBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [rightView addSubview:_choosBtn];
    
    UIButton *btn2 = [[[UIButton alloc] initWithFrame:CGRectMake(73, 0, 73, 44)] autorelease];
    [btn2 addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"开始上传" forState:UIControlStateNormal];
    btn2.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn2 setBackgroundImage:[UIImage  imageNamed:@"cloud_choose.png"] forState:UIControlStateNormal];
    [rightView addSubview:btn2];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithCustomView:rightView] autorelease];
    self.navigationItem.rightBarButtonItem = leftItem;
}

- (void)uploadArr{
    if (_arrChoose) {
         [_choosBtn setTitle:@"选择多个" forState:UIControlStateNormal];
        _arrChoose = NO;
       self.title = @"单个上传";
    }
    else{
        _arrChoose = YES;
         [_choosBtn setTitle:@"选择单个" forState:UIControlStateNormal];
        self.title = @"多个上传";
    }
    
}
- (void)upload{
    NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
    for (NSIndexPath *indexPaths in _chooseArr) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//程序文件夹主目录
        NSString *documentsDirectory = [paths objectAtIndex:0];//Document目录
        NSString * filePath = [documentsDirectory stringByAppendingPathComponent:[_fileArray objectAtIndex:indexPaths.row]];
        [arr addObject:filePath];
    }
    if ([self.delegate respondsToSelector:@selector(uploadFilePathArr:)]) {
        [self.delegate uploadFilePathArr:arr];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
    return [_fileArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    if ([_chooseArr containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
   cell.textLabel.text = [_fileArray objectAtIndex:indexPath.row] ;
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
    if (_arrChoose) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ( cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            [_chooseArr removeObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            [_chooseArr addObject:indexPath];
              cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
      
    }
    else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//程序文件夹主目录
        NSString *documentsDirectory = [paths objectAtIndex:0];//Document目录
        NSString * filePath = [documentsDirectory stringByAppendingPathComponent:[_fileArray objectAtIndex:indexPath.row]];
        
        if ([self.delegate respondsToSelector:@selector(uploadFilePath:)]) {
            [self.delegate uploadFilePath:filePath];
        }
        [self.navigationController popViewControllerAnimated:YES];

    }
       // Navigation logic may go here. Create and push another view controller.
    /*
     ; *detailViewController = [[ alloc] initWithNibName:@";" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
