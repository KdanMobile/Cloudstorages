//
//  CSgoogleDocsManager.h
//  CloudStorages
//
//  Created by zhu on 13-7-27.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CSCloudServer.h"
@class CloudFile;
@class GDataServiceGoogleDocs;
@class GDataEntryBase;
@interface CSgoogleDocsManager : CSCloudServer<UIActionSheetDelegate,CSTaskDelegate>
{
   
    NSString                            *_authToken;    
    GDataServiceGoogleDocs              *docsService;
    GDataEntryBase                      *_downloadObject;
    NSString                            *_downloadType;
    NSString                            *_savePath;
    CloudFile                           *_upLoadFolder;
    BOOL                                 _login;
    BOOL                                 _addTo;
}
@property (nonatomic, retain) GDataServiceGoogleDocs *docsService;

+ (CSgoogleDocsManager *)shareadManager;

@end
