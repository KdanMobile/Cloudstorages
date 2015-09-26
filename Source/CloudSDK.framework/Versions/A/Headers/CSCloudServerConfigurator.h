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
//Box
@property (nonatomic, copy) NSString *boxClientID;
@property (nonatomic, copy) NSString *boxClientSecret;
//DropBox
@property (nonatomic, copy) NSString *dropboxCosumerKey;
@property (nonatomic, copy) NSString *dropboxCosumerSecret;
//Google Driver
@property (nonatomic, copy) NSString *googleDriverClientID;
@property (nonatomic, copy) NSString *googleDriverClientSecret;
@property (nonatomic, copy) NSString *googleDriverKeyChainItemName;
//Evernote
@property (nonatomic, copy) NSString *evernoteAccessKey;
@property (nonatomic, copy) NSString *evernoteSecret;
//SugarSync
@property (nonatomic, copy) NSString *sugarSyncAppID;
@property (nonatomic, copy) NSString *sugarSyncAccessKey;
@property (nonatomic, copy) NSString *sugarSyncPrivateAccessKey;
//OneDrive
@property (nonatomic, copy) NSString *oneDriveClientID;

//iCloud
@property (nonatomic, copy) NSString *icloudContainerIdentify;

//FileTypes
@property (nonatomic, retain) NSDictionary   *supportFileTypes;//default is 'allFileTypes'.

//path
@property (nonatomic, copy) NSString    *downloadFileSavePath;
@property (nonatomic, copy) NSString    *chooseUploadFilesPath;

+ (CSCloudServerConfigurator*)defaultConfig;

+ (NSDictionary*)allFileTypes;

//+ (NSString *)boxClientID;
//+ (NSString *)boxClientSecret;
//+ (NSString *)dropboxCosumerKey;
//+ (NSString *)dropboxCosumerSecret;
//+ (NSString *)googleDriverClientID;
//+ (NSString *)googleDriverClientSecret;
//+ (NSString *)googleDriverKeyChainItemName;
//+ (NSString *)evernoteAccessKey;
//+ (NSString *)evernoteSecret;
//+ (NSString *)sugarSyncAppID;
//+ (NSString *)sugarSyncAccessKey;
//+ (NSString *)sugarSyncPrivateAccessKey;
//+ (NSString *)skyDriveClientID;
//
//+ (NSDictionary *)fileTypes;
//+ (NSString *)downloadFileSavePath;
//+ (NSString *)chooseUploadFilesPath;

@end
