//
//  UploadTask.h
//  CloudStorages
//
//  Created by kdanmobile on 14-3-20.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudFile.h"
@class CloudFile;

@interface UploadTask : NSObject
{
    CloudFile           *_cloudFile;
    NSString            *_localPath;
    NSString            *_cloudPath;
}
@property(nonatomic,retain)CloudFile            *cloudFile;
@property(nonatomic,copy)NSString               *localPath;
@property(nonatomic,copy)NSString               *cloudPath;
@end
