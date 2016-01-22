//
//  CSFTPManager.h
//  CloudStorages
//
//  Created by kdanmobile on 13-7-17.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACFTPClient.h"
#import "CSDownloadTask.h"
#import "CSCloudServer.h"

@interface CSFTPManager : CSCloudServer <ACFTPClientDelegate>
{
    NSString                *_currentPath;
    NSArray                 *_entriesArr;
    ACFTPLocation           *_ftpLocation;
    ACFTPClient             *_ftpClient;
    NSDictionary            *_fileList;
  //  CSDownloadTask          *_task;
    id                      _tempObject;
    BOOL                    _login;
    NSMutableArray          *_willDownloadCloudFiles;
}

@property (nonatomic, retain) NSDictionary *fileList;
@property(nonatomic,retain)   ACFTPClient  *ftpClient;
@property(nonatomic,retain)   ACFTPLocation  *ftpLocation;
@property (nonatomic, retain) NSString    *currentPath;
@property (nonatomic, retain) NSArray     *entriesArr;

+(CSFTPManager *)sharedManager;

@end
