//
//  FTPClient.h
//  OnSong
//
//  Created by Jason Kichline on 3/23/11.
//  Copyright 2011 andCulture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACFTPLocation.h"
#import "ACFTPListRequest.h"
#import "ACFTPGetRequest.h"
#import "ACFTPPutRequest.h"
#import "ACFTPMakeDirectoryRequest.h"
#import "ACFTPDeleteFileRequest.h"

@class ACFTPClient;

@protocol ACFTPClientDelegate

@optional

-(void)client:(ACFTPClient*)client request:(id)request didListEntries:(NSArray*)entries;
-(void)client:(ACFTPClient*)client request:(id)request didUpdateProgress:(float)progress;
-(void)client:(ACFTPClient*)client request:(id)request didDownloadFile:(NSURL*)sourceURL toDestination:(NSString*)destinationPath;
-(void)client:(ACFTPClient*)client request:(id)request didUploadFile:(NSString*)sourcePath toDestination:(NSURL*)destination;
-(void)client:(ACFTPClient*)client request:(id)request didMakeDirectory:(NSURL*)destination;
-(void)client:(ACFTPClient*)client request:(id)request didDeleteFile:(NSURL*)fileURL;

-(void)client:(ACFTPClient*)client request:(id)request didFailWithError:(NSError*)error;
-(void)client:(ACFTPClient*)client request:(id)request didUpdateStatus:(NSString*)status;
-(void)client:(ACFTPClient*)client requestDidCancel:(id)request;

@end


@interface ACFTPClient : NSObject <ACFTPListRequestDelegate, ACFTPGetRequestDelegate, ACFTPPutRequestDelegate, ACFTPMakeDirectoryRequestDelegate, ACFTPDeleteFileRequestDelegate> {
	NSMutableArray* requests;
	ACFTPLocation* location;
	id<ACFTPClientDelegate> delegate;
}

@property (nonatomic, retain) ACFTPLocation* location;
@property (nonatomic, retain) id<ACFTPClientDelegate> delegate;
@property (nonatomic, retain) NSString *fileNameInDownloadTask;//这里因为下载的部分要添加到Download list中显示，但有DownloadTask会重命名重复的名字，记录该名字用于在Download list中更新该文件下载时的状态，如文件名1.pdf -- 1.pdf; 1.pdf -- 1(1).pdf最终只能根据后面这个的名字1(1).pdf去更新下载的状态是downloading,finished还是failed,因为有可能同时同一文件被点击下载多次，原本FTP是串行下载(界面也是串行的)，现改成并行，用这种办法解决

-(id)initWithHost:(id)host username:(NSString*)username password:(NSString*)password;
-(id)initWithLocation:(ACFTPLocation*)location;

+(ACFTPClient*)clientWithHost:(id)host username:(NSString*)username password:(NSString*)password;
+(ACFTPClient*)clientWithLocation:(ACFTPLocation*)location;

-(void)list:(NSString*)path;
-(void)get:(NSString*)sourcePath toDestination:(NSString*)destinationPath;
-(void)put:(NSString*)sourcePath toDestination:(NSString*)destinationPath;
-(void)makeDirectory:(NSString*)named inParentDirectory:(NSString*)parentDirectory;
-(void)deleteFile:(NSString*)filePath;

- (void)stopRequst;
@end
