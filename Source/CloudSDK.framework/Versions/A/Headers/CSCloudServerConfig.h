//
//  CSCloudServerConfig.h
//  CloudStorages
//
//  Created by dongyongzhu on 15/8/10.
//  Copyright (c) 2015年 kdanmobile. All rights reserved.
//

#ifndef CloudStorages_CSCloudServerConfig_h
#define CloudStorages_CSCloudServerConfig_h

//all cloud enumeration
#define CSBoxName                   @"Box"
#define CSDropboxName               @"Dropbox"
#define CSGoogledriveName           @"GoogleDrive"
#define CSGoogelDocsName            @"GoogleDocs"
#define CSWebDavName                @"WebDav"
#define CSMydiskName                @"MyDisk"
#define CSSugarSyncName             @"SugarSync"
#define CSFtpName                   @"FTP"
#define CSEvernoteName              @"Evernote"
#define CSOneDriveName              @"OneDrive"
#define CSICloudName                @"iCloud"

typedef enum {
    CSNone = 0,
    CSDropbox = 1 <<0,
    CSGoogleDrive = 1 << 1,
    CSEvernote = 1 << 2,
    CSFTP = 1 << 3,
    CSWebDav = 1 << 4,
    CSMyDisk = 1 << 5,
    CSGoogleDocs = 1 << 6,
    CSSugarSync = 1 << 7,
    CSBox = 1 << 8,
    CSOneDrive = 1 <<9,
    CSICloud = 1 << 10,
    CSAll = 0xffff
}CSCloudServerType;


//error domain
#define kCSCloudErrorDomain     @"kCSCloudErrorDomain"
typedef enum CSCloudErorCode
{
    CSCloudErrorUserCancel  =   0          //cancel
}CSCloudErrorCode;


#endif
