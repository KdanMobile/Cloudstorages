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
    NSString                *fileName;//File name
    id                      fileObject;//File object
    CSCloudServerType       serverType;//Cloud types
    BOOL                    canOnline;//Enable Online Editing?
    
}

@property (nonatomic, copy) NSString * fileName;
@property (nonatomic,retain) id fileObject;
@property (nonatomic) BOOL canOnline;
@property (nonatomic) CSCloudServerType  serverType;
@property (nonatomic) CSCloudFileState fileState;
@end
