//
//  CSCloudServer.h
//  CloudStorages
//
//  Created by zhujunyu on 13-7-31.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

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
    CSOneDriver = 1 <<9,
    CSAll = 0xffff
}CSCloudServerType;

#define CSskyDrive  CSOneDriver
#define CSSkyDriveName  CSOneDriveName

//error domain
#define kCSCloudErrorDomain     @"kCSCloudErrorDomain"
typedef enum CSCloudErorCode
{
    CSCloudErrorUserCancel  =   0          //cancel
}CSCloudErrorCode;

#import <Foundation/Foundation.h>
#import "CSCloudServerConfigurator.h"
#import "CSDownloadTask.h"
#import "UploadTask.h"
@class CloudFile;
@class CSPermission;
@protocol CSCloudServerDelegate;

@interface CSCloudServer : NSObject
{
    NSMutableArray                  *_remoteFolders;//Retrieve folder list from remote directory and return it as an array
    NSMutableArray                  *_remoteFiles;//Retrieve file list from remote directory and return it as an array
    NSMutableArray                  *_folders;//A folder list converted to cloudfFile class and returned as an array
    NSMutableArray                  *_files;//A file list converted to cloudfFile class and returned as an array
    
    NSString                        *_fileExtension;//An extension of single file type
    NSArray                         *_fileExtensionArray;//An extension array of file types
    NSString                        *_serverName;//The display name of target cloud
    BOOL                            _isWebLogin;//Used to verifiy login methods. Yes indicates the cloud authenticates via web login
    BOOL                            _isLogin;
    BOOL                            _hasDownloadProgress;//Is there a download process bar?
    BOOL                            _isAutoUpload;  //auto upload or not?
    /*********The following parameters are not set when this cloud is using web login.
     If web login is not being used, parameters can be set if needed.****************/
    NSString                        *_userName;//Username
    NSString                        *_password;//User password
    NSString                        *_hostName;//Host name( FTP webDav )
    NSString                        *_portID;//Port ( FTP )
    NSString                        *_description;//Description
    NSStringEncoding                _encoding;//Encoding ( FTP )
    BOOL                            _couldModifyLoginInfo;//could modify log in information
    NSString                        *_loginIdentify;
    
    NSMutableArray                  *_uploadTaskList;
}

@property (nonatomic, assign) id<CSCloudServerDelegate> delegate;
@property (nonatomic, copy) NSString *fileExtension;//An extension of single file type
@property (nonatomic, copy) NSArray *fileExtensions;//An extension array of file types
@property (nonatomic, copy) NSString * serverName;//The display name of target cloud
@property (nonatomic, assign) BOOL isWebLogin;//Used to verifiy login methods.
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isAutoUpload;//auto upload or not
@property (nonatomic, assign) CSCloudServerType serverType;
@property (nonatomic, copy) NSString *userName;//Username
@property (nonatomic, copy) NSString *password;//User password
@property (nonatomic, copy) NSString *hostName;//Host name( FTP webDav )
@property (nonatomic, copy) NSString *portID;//Port ( FTP )
@property (nonatomic, assign) BOOL    hasDownloadProgress;//Is there a download process bar
@property (nonatomic, copy) NSString *description;//Description
@property (nonatomic, assign) NSStringEncoding encoding;//Encoding (FTP)
@property (nonatomic, assign)BOOL   couldModifyLoginInfo;//could modify log in information
@property (nonatomic, copy)NSString   *loginIdentify;//specific Identify
/**
 Setting configuration files
 */
+ (void)setCloudConfigurator;
/**
 URL authentication callback
 */
+ (BOOL)openURL:(NSURL *)url;
/**
 Call this function when this app is active
 
 */
+ (void)handleDidBecomeActive;
/**
 Retrieve all logged-in cloud services objects
 
 @return Return an array fo CSCloudServer objects
 */
+ (NSArray *)getAllLoginServer;

/**
 Cloud service object initialization
 @param type Enum type of cloud service objects;
 @see initialize a cloud server box:[CSCloudServer cloudServerForType:CSBox];return an antorelease cloud object
 */
+ (id)cloudServerForType:(CSCloudServerType)type;

/**
 Log in
 @param fromController "Parent View Controller is used to login to the page
 If WebLogin==NO, then Nil Must assign value to parameters during cloud authentication"
 @see   Successfull：- (void)serverLoginSuccess:(CSCloudServer *)server
 Failed：- (void)serverLoginFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)loginFromController:(UIViewController *)fromController;

/**
 Log out
 
 @see  Successfull：- (void)serverLogoutSuccess:(CSCloudServer *)server
 Failed：- (void)serverLogoutFaile:(CSCloudServer *)server withError:  (NSError *)error
 */
- (void)logout;
/**
 Access root directory
 @see   Successfull：- (void)serverGetListAndFolderSuccess:(CSCloudServer *)server folder:(NSArray *)folder andFile:(NSArray *)fileArr
 Failed：- (void)serverGetLisAndFolderFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)getRootListAndFolder;
/**
 Access folder directory path
 @param sourceFolder tables to acess of the specified folder object
 @see   Successfull：- (void)serverGetListAndFolderSuccess:(CSCloudServer *)server folder:(NSArray *)folder andFile:(NSArray *)fileArr
 Failed：- (void)serverGetLisAndFolderFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)getListAndFolderByFoler:(CloudFile *)sourceFolder;
/**
 download files to specific path
 @param file The file object that you can download it
 @param savePath Saved file path
 @see Successfull：- (void)serverDownloadSuccess:(CSCloudServer *)server
 Failed：- (void)serverDownloadFaile:(CSCloudServer *)server withError:(NSError *)error
 */

- (void)downloadFile:(CloudFile *)file toPath:(NSString *)savePath;
/**
 Add to download list
 @param file objects add to download list
 @param path Saved file path
 */
- (void)addToDownloadList:(CloudFile *)file withSavePath:(NSString *)path;
/**
 Upload a single file
 @param filePath The local path of file to be uploaded
 @param desFolder Upolad to remote folder
 @see Successfull：- (void)serverUploadFileSuccess:(CSCloudServer *)server
 Failed：- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)uploadFilePath:(NSString *)filePath toFolder:(CloudFile *)desFolder;
/**
 Upload multiple files
 @param filePathArray Array of file to be uploaded
 @param desFolder desFolder Upolad to remote folder
 @see Successfull：- (void)serverUploadFileSuccess:(CSCloudServer *)server
 Failed：- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)uploadFiles:(NSArray *)filePathArray toFolder:(CloudFile *)desFolder;
/**
 Delete the file
 @param file File object to be deleted
 @see Successfull：- (void)serverDeleteFileSuccess:(CSCloudServer *)server
 Failed：- (void)serverDeleteFileFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)deleteFile:(CloudFile *)file;

/**
 Create new folder
 @param folderName Folder name needs to be created
 @param desFolder Parent directory of created folder
 @see Successfull：- (void)serverCreatFolderSuccess:(CSCloudServer *)server
 Failed：- (void)serverCreatFolderFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)createNewFolder:(NSString *)folderName inFolder:(CloudFile *)desFolder;
/**
 Rename
 @param file File object that needs to be renamed
 @param newName New file name (path extension not required)
 @see   Successfull：- (void)serverRenameSuccess:(CSCloudServer *)server
 Failed：- (void)serverRenameFaile:(CSCloudServer *)server withError:(NSError *)error
 */
- (void)renameFile:(CloudFile *)file withName:(NSString *)newName ;
/**
 Get the googleDrive's file URL that can be edited online
 @param file File object that can be edited online
 @return Return to the URL of the online editable file
 */
- (NSMutableURLRequest *)getOnlineEditorURL:(CloudFile *)file;
/**
 Check administrators who have file permission
 @param file Files to check your permission
 @see Successful -(void)getFilePermissionListSuccessful:(CSCloudServer *)server withList:(NSArray *)listName;
 Failed     -(void)getFilePermissionListFailed:(CSCloudServer *)server withError:(NSError *)error;
 */
- (void)getPermissionList:(CloudFile *)file;
/**
 Remove this user's file permission. Note: you can't remove the file owner.
 @param file Files to operate
 @param permission Administrators with permission to be removed
 @see Successful -(void)deletePermissionSuccessful:(CSCloudServer *)server withFile:(CloudFile *)file;
 Failed     -(void)deletePermissionFailed:(CSCloudServer *)server withFile:(CloudFile *)file withError:(NSError *)error;
 */
- (void)deletePermission:(CloudFile *)file atPermissionID:(CSPermission *)permission;
/**
 Add visitors with file permission
 @param username Add administrator's name with permission
 @param role Role（reader,writer)
 @param file Files added permission
 @see  Successful -(void)insertPermissionSuccessful:(CSCloudServer *)server withFile:(CloudFile *)file;
 Failed      -(void)insertPermissionFailed:(CSCloudServer *)server withFile:(CloudFile *)file withError:(NSError *)error;
 */
- (void)insertPermission:(NSString*)userName wihtRole:(NSString*)role toFile:(CloudFile *)file;
/**
 These two functions are private methods used to save and delete the cloud server
 */
- (void)saveData;//Save server information
- (void)deleteData;//Delete server information
@end
@protocol CSCloudServerDelegate <NSObject>

@optional
/**
 Login callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverLoginSuccess:(CSCloudServer *)server;
- (void)serverLoginFaile:(CSCloudServer *)server withError:(NSError *)error;
/**
 Logout callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverLogoutSuccess:(CSCloudServer *)server;
- (void)serverLogoutFaile:(CSCloudServer *)server withError:(NSError *)error;
/**
 Obtain file directory callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverGetListAndFolderSuccess:(CSCloudServer *)server folder:(NSArray *)folder andFile:(NSArray *)fileArr;
- (void)serverGetLisAndFolderFaile:(CSCloudServer *)server withError:(NSError *)error;
/**
 Upload files callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverUploadFileSuccess:(CSCloudServer *)server;
- (void)serverUploadFaile:(CSCloudServer *)server withError:(NSError *)error;

- (void)server:(CSCloudServer *)server uploadFile:(NSString *)localFilePath toCloudPath:(CloudFile *)cloudPath success:(BOOL)success withError:(NSError *)error;

/**
 File download callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverDownloadSuccess:(CSCloudServer *)server;
- (void)serverDownloadFaile:(CSCloudServer *)server withError:(NSError *)error;
/**
 Only support Evernote and FTP
 */
- (void)server:(CSCloudServer *)server downloadFile:(NSString *)fileName toPath:(NSString *)toPath  success:(BOOL)success;

/**
 File deletion callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverDeleteFileSuccess:(CSCloudServer *)server;
- (void)serverDeleteFileFaile:(CSCloudServer *)server withError:(NSError *)error;

/**
 Add file to download list callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverAddToDownloadListSuccess:(CSCloudServer *)server;
- (void)serverAddToDownloadFaile:(CSCloudServer *)server withError:(NSError *)error;
/**
 Rename callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverRenameSuccess:(CSCloudServer *)server;
- (void)serverRenameFaile:(CSCloudServer *)server withError:(NSError *)error;
/**
 Folder creation callback function.
 If successful, return server information;
 If failed, return server information and error message
 */
- (void)serverCreatFolderSuccess:(CSCloudServer *)server;
- (void)serverCreatFolderFaile:(CSCloudServer *)server withError:(NSError *)error;

/**
 Callback function of checking administrators with file permission. Return to server and administrators' information array if success, else return to server and wrong information
 */
-(void)getFilePermissionListSuccessful:(CSCloudServer *)server withList:(NSArray *)listName;
-(void)getFilePermissionListFailed:(CSCloudServer *)server withError:(NSError *)error;
/**
 Callback function of removing administrators' file permission. Return to server , file objects and permission objects; else return to server, file objects, permission objects and wrong information
 */
-(void)deletePermissionSuccessful:(CSCloudServer *)server withFile:(CloudFile *)file withPermission:(CSPermission *)permission;
-(void)deletePermissionFailed:(CSCloudServer *)server withFile:(CloudFile *)file withPermission:(CSPermission *)permission withError:(NSError *)error;
/**
 Callback function of adding visitors with file permission. Return to server, file objects and administrators objects; else return to server, file objects and wrong information
 */
-(void)insertPermissionSuccessful:(CSCloudServer *)server withFile:(CloudFile *)file withPermission:(CSPermission *)permission;
-(void)insertPermissionFailed:(CSCloudServer *)server withFile:(CloudFile *)file withError:(NSError *)error;


@end
