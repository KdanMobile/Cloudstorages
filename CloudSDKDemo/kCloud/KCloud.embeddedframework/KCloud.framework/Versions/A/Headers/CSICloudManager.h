//
//  CSICloudManager.h
//  CloudStorages
//
//  Created by liwei on 2015.8
//  Copyright (c) 2015年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"

@class CloudFile;

typedef NS_ENUM(NSInteger, ICAErrorCode) {
    ICAErrorCodeFileAccessFailed            = 100,
    ICAErrorCodeFileCoordinatorTimedOut     = 101,
    ICAErrorCodeAuthenticationFailure       = 102,
    ICAErrorCodeConnectionError             = 103
};
@interface CSICloudManager : CSCloudServer<CSTaskDelegate>
{
    CloudFile                   *_willDownloadCloudFile;
}

+ (CSICloudManager *)sharedManager;
@end
