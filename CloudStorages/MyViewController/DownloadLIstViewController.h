//
//  DownloadLIstViewController.h
//  CloudStorages
//
//  Created by zhu on 13-7-18.
//  Copyright (c) 2013year kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudSDK/CSDownloadManager.h>

@interface DownloadLIstViewController : UITableViewController<UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray                         *_downloadArray;
    NSInteger                               _index;
    
}

@end
