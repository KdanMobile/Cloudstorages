//
//  CSboxManager.h
//  CloudStorages
//
//  Created by zhu on 13-7-16.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "CSCloudServer.h"

@class BoxAuthorizationNavigationController;

@interface CSboxManager : CSCloudServer<CSTaskDelegate>
{
    BoxAuthorizationNavigationController  *_theAuthNavigation;
    NSMutableArray                        *_allItemArray;   
}
+ (CSboxManager *)sharedManager;
@end

