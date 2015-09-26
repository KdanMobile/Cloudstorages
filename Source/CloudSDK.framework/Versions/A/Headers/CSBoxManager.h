//
//  CSBoxManager.h
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "CSCloudServer.h"

@class BOXContentClient;
@protocol BOXAPIAccessTokenDelegate;

@interface CSBoxManager : CSCloudServer<CSTaskDelegate>
{
    NSMutableArray                        *_allItemArray;
    BOXContentClient                      *_boxClient;
}

+ (CSBoxManager *)sharedManager;

@end

