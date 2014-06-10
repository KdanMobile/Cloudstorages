//
//  CloudFile.h
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"
typedef enum{
    CSFileNone = 0,//No operation
    CSFileDelete,//Delete
    CSFileDownloading,//Download
    CSFileRenam //Rename
}CSCloudFileState;//File Status


@interface CloudFile : NSObject
{
    NSString                *fileName;
    id                      fileObject;
    CSCloudServerType       serverType;
    BOOL                    canOnline;
  
}

@property (nonatomic, copy) NSString * fileName;//File name
@property (nonatomic,retain) id fileObject;//File object
@property (nonatomic) BOOL canOnline;//Enable Online Editing
@property (nonatomic) CSCloudServerType  serverType;//Cloud types
@property (nonatomic) CSCloudFileState fileState;//FileState
@end
