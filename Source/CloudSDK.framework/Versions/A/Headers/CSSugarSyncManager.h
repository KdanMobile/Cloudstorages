//
//  CSSugarSyncManager.h
//  CloudStorages
//
//  Created by zhujunyu on 13-7-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"
#import "TBXML.h"

@class CloudFile;

@interface CSSugarSyncManager : CSCloudServer<CSTaskDelegate>
{
    TBXML           *_xml;
    NSURL           *_currentFolder;
    CloudFile       *_parentFolder;
    NSString        *_accessToken;
    NSString        *_authToken;
    NSMutableDictionary   *_fourPrimaryFolders;
}
@property (nonatomic,retain) NSString               *authToken;
@property (nonatomic,retain) NSURL                  *currentFolder;
@property (nonatomic,retain) CloudFile              *parentFolder;
@property (nonatomic,retain)NSMutableDictionary     *fourPrimaryFolders; 
@property (nonatomic,retain) NSString               *accessToken;

+ (CSSugarSyncManager *)shareadManager;

@end

@interface SugarItem : NSObject {
@private
    
    //  Common Attributes
    NSString *_displayName;
    NSURL *_ref;
    NSURL *_contents; // if (!_isFolder) _contents = _fileData;
    BOOL _isFolder;
    
    //  Attributes for Files
    NSInteger _size;
    NSString *_lastModified;
    NSString *_mediaType;
    BOOL _presentOnServer;
    
}

@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) NSURL *ref;
@property (nonatomic, retain) NSURL *contents;
@property (nonatomic) NSInteger size;
@property (nonatomic, retain) NSString *lastModified;
@property (nonatomic, retain) NSString *mediaType;
@property (nonatomic) BOOL presentOnServer;
@property (nonatomic) BOOL isFolder;

- (SugarItem*)initWithDisplayName:(NSString*)displayName ref:(NSURL*)ref contents:(NSURL*)contents isFolder:(BOOL)isFolder;
@end
