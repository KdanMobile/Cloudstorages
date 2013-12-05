//
//  CSCloudServerConfigurator.h
//  CloudStorages
//
//  Created by zhujunyu on 13-9-10.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

//云端名称

#ifdef DEBUG
#define MyLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#else
#define MyLog(format, ...)
#endif



#import <Foundation/Foundation.h>

@interface CSCloudServerConfigurator : NSObject
+ (NSString *)boxClientID;
+ (NSString *)boxClientSecret;
+ (NSString *)dropboxCosumerKey;
+ (NSString *)dropboxCosumerSecret;
+ (NSString *)googleDriverClientID;
+ (NSString *)googleDriverClientSecret;
+ (NSString *)evernoteAccessKey;
+ (NSString *)evernoteSecret;
+ (NSString *)sugarSyncAppID;
+ (NSString *)sugarSyncAccessKey;
+ (NSString *)sugarSyncPrivateAccessKey;
+ (NSString *)skyDriveClientID;

+ (NSDictionary *)fileTypes;
+ (NSString *)downloadFileSavePath;
+ (NSString *)chooseUploadFilesPath;
@end
