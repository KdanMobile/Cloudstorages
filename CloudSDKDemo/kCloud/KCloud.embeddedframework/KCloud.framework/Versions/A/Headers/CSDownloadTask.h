//
//  CSDownloadTask.h
//  CloudStorages
//
//  Created by zhu on 13-7-18.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"
#import "CSDownloadManager.h"
#import "CloudFile.h"
@class CSCloudServer;
@class CloudFile;

@interface NSObject(CSCloudServerDownloadResponse)

- (void)taskDownloadStateChanged:(CSDownloadTask *)task;

- (void)taskDownloadProcessChanged:(CSDownloadTask *)task;

@end

@protocol CSTaskDelegate <NSObject>

@optional
/**
 Callback for Downloading Process
 */
- (void)taskStateChange;
/**
 task download procedure callback
 */
- (void)taskDownloadProgress;
/**
 Callback for Download Succussful
 */
- (void)taskDownloadSuccess;
/**
 Callback for Download Fail
 @param error Error message of download failure
 */
- (void)taskDownloadFailewithError:(NSError *)error;
@end

@interface CSDownloadTask : NSObject
{
}

@property (nonatomic, assign) id <CSTaskDelegate> delegate;
@property (nonatomic, retain, readonly) NSString *address;
@property (nonatomic, retain, readonly) NSString *fileName;
@property (nonatomic, assign) SInt64 receivedSize;
@property (nonatomic, assign) SInt64 fileSize;
@property (nonatomic, readonly) CSCloudServerType serverType;
@property (nonatomic, retain, readonly) NSString *token;
@property (nonatomic, retain)NSDate     *tokenExpireDate;//token过期时间
@property (nonatomic, retain, readonly) NSString *savePath;
@property (nonatomic) CSDOWNLOAD_STATE downloadState;
@property (nonatomic, retain) NSMutableData *loadData;
@property (nonatomic, retain)CloudFile       *cloudFile;
@property (nonatomic, assign)CSCloudServer   *server;
/**
 Download task initialization
 @param address Download link
 @param type Downloaded cloud types
 @param filename Download file name
 @param path Directory path of saved file
 */
- (id)initWithAddress:(NSString *)address
      withDowloadType:(CSCloudServerType )type
          andFilename:(NSString *)filename
         withSavePath:(NSString *)path;

/**
 Download task initialization
 @param address Download link
 @param type Downloaded cloud types
 @param filename Download file name
 @param path Directory path of saved file
 @param token Unique identifier for partial cloud server login
 */
- (id)initWithAddress:(NSString *)address
      withDowloadType:(CSCloudServerType)type
          andFilename:(NSString *)filename
         withSavePath:(NSString *)path
             andToken:(NSString *)token;

/**
 Download task initialization
 @param address Download link
 @param type Downloaded cloud types
 @param filename Download file name
 @param path Directory path of saved file
 @param token Unique identifier for partial cloud server login
 */
- (id)initWithAddress:(NSString *)address
      withDowloadType:(CSCloudServerType)type
          andFilename:(NSString *)filename
         withSavePath:(NSString *)path
             andToken:(NSString *)token
       andCloudServer:(CSCloudServer *)server
         andCloudFile:(CloudFile *)cloudFile;
/**
 Determine whether they are the same task
 @param task Task needing evaluation
 @return If they are the same task, return YES, if not return NO
 */
- (BOOL)isEqualToTask:(CSDownloadTask *)task;
/**
 Start download
 */
- (void)startRunning;
/**
 Stop download
 */
- (void)stopRunning;
/**
 Delete download task
 */
- (void)deleteTask;

@end
