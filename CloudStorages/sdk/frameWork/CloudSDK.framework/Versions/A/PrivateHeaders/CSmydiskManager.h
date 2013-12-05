//
//  CSmydiskManager.h
//  CloudStorages
//
//  Created by zhujunyu on 13-7-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"

@class WebDAVForMyDisk;
@class CloudFile;

@interface CSmydiskManager : CSCloudServer<CSTaskDelegate>
{
    BOOL                                isAddtoDownList;
    BOOL                                _login;
    NSString                            *_prevPath;
    NSString                            *_tempPath;
    WebDAVForMyDisk                     *_myDisk;
}

@property (nonatomic,retain) WebDAVForMyDisk   *myDisk;
@property (nonatomic,retain) NSString          *prevPath;
+ (CSmydiskManager *)shareadManager;
@end
