//
//  ListViewController.h
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpAndDownloadViewController.h"

@interface ListViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate,uploadChooseDelegate,CSCloudServerDelegate>
{
    NSMutableArray              *_folderArray;
    NSMutableArray              *_fileArray;
    UIActivityIndicatorView     *_indicatorView;
    CloudFile                   *currentFolder;
    NSInteger                    _index;
    NSIndexPath                 *_indexPath;
}
@property (nonatomic, retain) CloudFile *currentFolder;
@property (nonatomic, retain) CSCloudServer *cloudServer;
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;
@end
