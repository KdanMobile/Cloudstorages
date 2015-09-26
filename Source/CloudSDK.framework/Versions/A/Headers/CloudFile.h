//
//  CloudFile.h
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"

typedef enum {
    CSFileNone = 0,//No operation
    CSFileDelete,//Delete
    CSFileDownloading,//Download
    CSFileRename //Rename
}CSCloudFileState;//File Status

typedef enum {
    CSCloudFileTypeUnknow,
    CSCloudFileTypeFolder,
    CSCloudFileTypeFile
}CSCloudFileType;

@interface CloudFile : NSObject
@property (nonatomic, copy) NSString    *fileName;//File name
@property (nonatomic, retain) id        fileObject;//File object
@property (nonatomic, readwrite) BOOL   canOnline;//Enable Online Editing
@property (nonatomic, readwrite) CSCloudServerType  serverType;//Cloud types
@property (nonatomic, readwrite) CSCloudFileState   fileState;//FileState
@property (nonatomic, readwrite) CSCloudFileType    fileType;

@end


@interface NSArray (CSCloudFiles)

- (NSArray*)folders;

- (NSArray*)files;

@end
