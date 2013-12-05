//
//  CSCloudServerConfigurator.m
//  CloudStorages
//
//  Created by zhujunyu on 13-9-10.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

//输出符定义
#import "CSCloudServerConfigurator.h"




#define CSfileTypes [[NSDictionary alloc] initWithObjectsAndKeys: @"CSdoc", @"doc", @"CSdoc", @"docx", @"CSxls", @"xls", @"CSxls", @"xlsx", @"CSpic", @"png", @"CSpic", @"jpg", @"CSpic", @"jpeg", @"CSpic", @"bmp", @"CSpic", @"gif", @"CSpic", @"tiff", @"CSrar", @"rar", @"CSzip", @"zip", @"CSrar", @"7z", @"CStxt", @"txt", @"CSpdf", @"pdf", @"CSppt", @"ppt", @"CSppt", @"pptx", @"CSKeynote", @"key", @"CSnumbers", @"numbers", @"CSpages", @"pages", @"CSaudio", @"wma", @"CSaudio", @"m4a", @"CSaudio", @"mp3", @"CSvideo", @"mov", @"CSvideo", @"mp4", @"CSvideo", @"wmv",@"CSvideo", @"avi",@"CScbr", @"cbr",@"CScbr", @"cbz",@"CSweb", @"htm",@"CSweb", @"html",@"CSepub", @"epub",@"CSnone", @"none", nil]





@implementation CSCloudServerConfigurator

+ (NSString *)boxClientID{
    return @"vdxobv1jtbin3golalsov3skmvrnnu5x";
}
+ (NSString *)boxClientSecret{
    return @"DCeH9lfS6Mcb2odtjG29gdBFqVJDG7WO";
}
+ (NSString *)dropboxCosumerKey{
    return @"no2ju306lkesmpg";
}
+ (NSString *)dropboxCosumerSecret{
    return @"e7txknyenfds1b8";
}
+ (NSString *)googleDriverClientID{
    return @"899818209298.apps.googleusercontent.com";
}
+ (NSString *)googleDriverClientSecret{
    return @"n2r7dEP4ZKis4e_Fe65dcuDY";
}
+ (NSString *)evernoteAccessKey{
    return  @"eleeditor";
}
+ (NSString *)evernoteSecret{
    return @"8940c93e6ff639e8";
}
+ (NSString *)sugarSyncAppID{
    return @"/sc/2720968/327_412818324"
;
}
+ (NSString *)sugarSyncAccessKey{
    return @"MjcyMDk2ODEzNjQ5NjA5NDUzOTc";
}
+ (NSString *)sugarSyncPrivateAccessKey{
    return @"ODM1MWU1MDI2NDdkNGVmYmE3ZGZjMDk0ZmRkOTk3OGE";
}
+ (NSString *)skyDriveClientID{
    return  @"0000000040103766";
}

+ (NSDictionary *)fileTypes{
    return CSfileTypes;
}
+ (NSString *)downloadFileSavePath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
+ (NSString *)chooseUploadFilesPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
@end
