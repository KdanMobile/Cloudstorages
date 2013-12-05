//
//  CSdropboxManager.h
//  Dropbox
//
//  Created by hys on 13-7-20.
//  Copyright (c) 2013年 HouYuShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>
#import "CSCloudServer.h"
extern NSString *const CSDropboxLoginSuccessNotification;

@interface CSdropboxManager : CSCloudServer <DBRestClientDelegate,DBSessionDelegate,CSTaskDelegate>{
    NSString                    *_savePath;
    BOOL                         _addTo;
}

@property (nonatomic, retain) DBRestClient *restClient;
+ (CSdropboxManager *)sharedManager;


@end
