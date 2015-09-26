//
//  CSWebDevManager.h
//  CloudStorages
//
//  Created by zhujunyu on 13-7-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"
@class WebDAVConnection;
@class CloudFile;

@interface CSWebDevManager : CSCloudServer<CSTaskDelegate>
{
    BOOL                     _login;
    BOOL                    isAddToDownList;
    NSString                *_savePath;
    NSString                *_refreshPath;
    NSString                *_root;
    CloudFile               *_willDownloadCloudFile;
}
@property (nonatomic, retain) WebDAVConnection *webDavClient;

+ (CSWebDevManager *)shareadManager;

@end
