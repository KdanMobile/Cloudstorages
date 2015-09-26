//
//  PermissionViewController.h
//  CloudStorages
//
//  Created by kdanmobile on 13-11-28.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CloudFile;

@interface PermissionViewController : UITableViewController<CSCloudServerDelegate,UIAlertViewDelegate>{
    NSMutableArray                *permissionArray;
    CSCloudServer               *_server;
    CloudFile                   *_permissionFile;
    NSIndexPath                 *_indexPath;
}
@property(nonatomic, retain) CSCloudServer  *server;
@property(nonatomic, retain) CloudFile      *permissionFile;

@end
