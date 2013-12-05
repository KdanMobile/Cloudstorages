//
//  CSskyDriveManager.h
//  CloudStorages
//
//  Created by kdanmobile on 13-8-19.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveSDK/LiveConnectClient.h"
#import "CSCloudServer.h"

@interface CSskyDriveManager : CSCloudServer<LiveAuthDelegate,LiveOperationDelegate,LiveDownloadOperationDelegate,LiveUploadOperationDelegate,CSTaskDelegate>
{
      NSArray       *_scopes;
}
+(CSskyDriveManager *)sharedManager;

@end
