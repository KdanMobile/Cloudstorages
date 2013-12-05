
//
//  WebDAV.h
//  MobileMe
//
//  Created by Ryan Detzel on 1/12/09.
//  Copyright 2009 Fifth Floor Media. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ConnectionState {
    kConnectionState_listDir,
    kConnectionState_downloadFile,
	kConnectionState_makeDir,
	kConnectionState_uploadFile,
	kConnectionState_uploadData,
};

typedef enum ConnectionState ConnectionState;

@interface WebDAVForMyDisk : NSObject {
	id delegate;
	
	NSString *username;
	NSString *password;
    
    NSString *downloadURL;
	
	NSInteger globalTimeout;
	ConnectionState connectionState;
    NSString *localFileName;//本地要上传的文件名或远程要下载的文件名称
    
	NSURLConnection *connection;
    NSURLConnection *listConnection;
	NSMutableData *incomingData;
	NSURLAuthenticationChallenge *pendingChallenge;
	NSURL *documentURL;
	
	NSMutableString *_xmlChars;
	NSUInteger _uriLength;
	
	NSMutableArray *directoryList;
    
    NSString *_selectServe;  //New variable attention!
}

@property (nonatomic, copy)	NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *localFileName;

@property (nonatomic, copy) NSString *downloadURL;

@property (nonatomic, assign) NSInteger globalTimeout;

@property (nonatomic, retain)   NSURLConnection *listConnection;
@property (nonatomic, retain)	NSURLConnection *connection;
@property (nonatomic, retain)   NSMutableData *incomingData;
@property (nonatomic, retain)   NSURLAuthenticationChallenge *pendingChallenge;

@property (nonatomic, readonly) NSURL *documentURL;


@property (nonatomic,copy) NSString *selectServe;   //New variable attention!


-(id)initWithUsername:(NSString *)u password:(NSString *)p;
-(void)setup:(NSString *)u password:(NSString *)p;
-(id)delegate;
-(void)setDelegate:(id)val;

-(NSString *)buildURL;

-(void)listDir:(NSString *)path;
-(void)downloadFile:(NSString*)filePath;
-(void)throwError:(NSString *)error;

-(void)makeDir:(NSString *)path;

-(void)uploadData:(NSData *)data destination:(NSString *)path;
-(void)uploadFile:(NSString *)local destination:(NSString *)path;

@end
