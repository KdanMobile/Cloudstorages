//
//  DownloadLIstViewController.h
//  CloudStorages
//
//  Created by zhu on 13-7-18.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadLIstViewController : UITableViewController<UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray                         *_downloadArray;
    NSInteger                               _index;
    
}

@end
