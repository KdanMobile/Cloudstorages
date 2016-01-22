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
@property (nonatomic, copy) NSString            *fileName;//文件名称
@property (nonatomic, copy) NSDate              *createTime;//创建时间
@property (nonatomic, readwrite) unsigned long long  fileSize;//文件尺寸
@property (nonatomic, copy) NSDate              *updateTime;//更新时间
@property (nonatomic, copy) NSString            *lastModifyingUserName;//作者
@property (nonatomic, copy) NSDate              *sharedWithMeTime;//分享时间

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


#pragma mark - Order
typedef enum {
    CloudSortTypeCreateTime, //按创建时间排序
    CloudSortTypeModifyTime, //按修改时间排序
    CloudSortTypeAuthor,     //按作者名称排序
    CloudSortTypeFileName,   //按文件名称排序
    CloudSortTypeFileSize,   //文件大小
}CloudSortType;

@interface NSArray (Sort)

- (NSArray*)sortByType:(CloudSortType)type;

@end
