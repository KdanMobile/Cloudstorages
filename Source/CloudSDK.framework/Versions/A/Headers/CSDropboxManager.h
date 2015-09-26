//
//  CSDropboxManager.h
//  Dropbox
//
//  Created by hys on 13-7-20.
//  Copyright (c) 2013年 HouYuShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>
#import "CSCloudServer.h"

extern NSString *const CSDropboxLoginSuccessNotification;
extern NSString *const CSDropboxLoginCancelNotification;

@interface CSDropboxManager : CSCloudServer <
DBRestClientDelegate,
DBSessionDelegate,
CSTaskDelegate>{
    NSString                    *_savePath;
    BOOL                         _addTo;
    CloudFile                   *_willDownloadCloudFile;
}
@property (nonatomic, retain) DBRestClient *restClient;

+ (CSDropboxManager *)sharedManager;

@end
