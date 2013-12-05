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
    NSMutableArray                  *_taskArray;//Array of download tasks
}

@property (nonatomic,retain) NSMutableArray * taskArray;
+ (CSDownloadManager *)sharedManager;
/** 保存下载历史列表
 
 */
- (void)saveDownloadTask;
/**
 Delete the selected download task
 @param task Task object to be deleted
 */

- (void)deleteTask:(CSDownloadTask *)task;
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
