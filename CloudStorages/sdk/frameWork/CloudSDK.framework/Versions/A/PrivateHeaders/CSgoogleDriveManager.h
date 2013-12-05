//
//  CSgoogleDriveManager.h
//  CloudStorages
//
//  Created by zhu on 13-7-22.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"
@class GTLServiceDrive;
@class GTLDriveFileList;
@class CloudFile;
@class GTMOAuth2Authentication;
@class GTLServiceTicket;
@class GTLDrivePermissionList;


@interface CSgoogleDriveManager : CSCloudServer<UIAlertViewDelegate>
{
    
    GTLServiceDrive                 *_driveService;
    GTMOAuth2Authentication         *_auth;
    GTLDriveFileList                *_fileList;
    int                              _num;
    NSMutableDictionary             *_fileExportTypeDic;//用于保存文件可以转换的类型
    BOOL                            _isUpload;
    BOOL                            _getAuth;
    GTLServiceTicket                *_detailsTicket;
    GTLDrivePermissionList          *_permissionList;
   
}
@property (nonatomic, retain, readonly)  GTLServiceDrive *driveService;
@property (nonatomic, assign) int users;
@property (nonatomic, assign) BOOL isUpload;
@property (nonatomic, retain) GTLServiceTicket *detailsTicket;
@property (nonatomic, retain) GTLDrivePermissionList *permissionList;


+ (CSgoogleDriveManager *)sharedManager;
- (void)currentAuthForUserEmail:(NSString*)userEmail;



@end
