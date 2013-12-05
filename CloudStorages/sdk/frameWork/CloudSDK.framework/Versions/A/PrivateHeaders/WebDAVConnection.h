//
//  WebDAV.h
//  MobileMe
//
//  Created by Ryan Detzel on 1/12/09.
//  Copyright 2009 Fifth Floor Media. All rights reserved.
//

#import <Foundation/Foundation.h>

enum WebDavConnectionState {
    WebDavkConnectionState_listDir = 0,
    WebDavkConnectionState_downloadFile,
	WebDavkConnectionState_makeDir,
	WebDavkConnectionState_uploadFile,
	WebDavkConnectionState_uploadData,
};

typedef enum WebDavConnectionState WebDavConnectionState;

@interface WebDAVConnection : NSObject <NSXMLParserDelegate> {
	id delegate;
	
    NSString *address;
	NSString *username;
	NSString *password;
    
    NSString *downloadURL;
	
	NSInteger globalTimeout;
	WebDavConnectionState connectionState;
    
	NSURLConnection *connection;
	NSMutableData *incomingData;
	NSURLAuthenticationChallenge *pendingChallenge;
	NSURL *documentURL;
	
	NSMutableString *_xmlChars;
	NSUInteger _uriLength;
	
	NSMutableArray *directoryList;
    
}
@property (nonatomic, copy)	NSString *address;
@property (nonatomic, copy)	NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *downloadURL;

@property (nonatomic, assign) NSInteger globalTimeout;
@property (nonatomic, retain)   NSURLConnection *listConnection;
@property (nonatomic, retain)	NSURLConnection *connection;
@property (nonatomic, retain)   NSMutableData *incomingData;
@property (nonatomic, retain)   NSURLAuthenticationChallenge *pendingChallenge;

@property (nonatomic, readonly) NSURL *documentURL;


-(id)initWithURLAddress:(NSString *)address Username:(NSString *)u password:(NSString *)p;
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
