//
//  CSDownloadManager.h
//  CloudStorages
//
//  Created by zhu on 13-7-18.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

//Download progress
typedef enum {
	kCSDownloadStateNone = 0,//No operation
	kCSDownloadStateRunning ,//Downloading
	kCSDownloadStateStopped ,//Stopped download
	kCSDownloadStateFinished ,//Finishde download
	kCSDownloadStateFailed    //Download failed
} CSDOWNLOAD_STATE;


#import <Foundation/Foundation.h>
@class CSDownloadTask;
@interface CSDownloadManager : NSObject
{
    NSMutableArray                  *_taskArray;
}

@property (nonatomic,retain) NSMutableArray * taskArray;//Array of download tasks

+ (CSDownloadManager *)sharedManager;

/** Save Downloaded List
 */
- (void)saveDownloadTask;

/**
 Delete the selected download task
 @param task Task object to be deleted
 */

- (void)deleteTask:(CSDownloadTask *)task;

/* 移除Task下Target的回调
 */
- (void)removeTarget:(id)target;

/**
 Remove downloaded tasks
 */
- (void)deleteFinishTask;

/**
 Start downloading
 */
- (void)startDownload;

/**
 Change download status
 @param task Task object to be operated
 */
- (void)changeTaskState:(CSDownloadTask *)task;

@end
