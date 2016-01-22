//
//  CSOneDriveManager.h
//  CloudStorages
//
//  Created by kdanmobile on 13-8-19.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "OneDriveSDK.h"
#import <OneDrive/OneDrive.h>

#import "CSCloudServer.h"

typedef void(^FetchChildrenComplention)(NSArray *childrens, NSError *error);
typedef void(^CloudServerRequestComplention) (id info, NSError *error);

@interface CSOneDriveManager : CSCloudServer <CSTaskDelegate>

+ (CSOneDriveManager *)sharedManager;

/** fetch to root folder and files info
 */
- (void)fetchRootItemsWithComplention:(FetchChildrenComplention)complention;

/** fetch to specified folder info
 */
- (void)fetchChildrenItemsForItem:(CloudFile*)item
                      complention:(FetchChildrenComplention)complention;

/** upload to specified folder
 */
- (void)uploadFile:(NSString *)filePath
          toFolder:(CloudFile *)desFolder
       complention:(CloudServerRequestComplention)complention;

@end
