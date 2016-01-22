//
//  MyMainViewController.h
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CSCloudServerDelegate>
{
    UITableView                 *_tableView;
    NSMutableArray              *_infoArray;
    NSMutableArray              *_fileArray;
    NSInteger                   _index;
    UIActivityIndicatorView     *_indicatorView;
    BOOL                        _isAdd;
    NSIndexPath                 *_indexPath;
}
@end
