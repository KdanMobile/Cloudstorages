#CloudStorages SDK for iOS 
##What this is
"CloudStorages SDK is a classlib for manageing all sorts of cloud data such as the following ten: Box、DropBox、GoogleDrive、GoogleDocs、FTP、MyDisk、WebDav、EverNote、SugarSync、skyDrive. 
Current version:1.0"
#Operating Environment
- armv7,arm64 supported
- iOS 5.0 and above supported
 
#File Import 

###File Import process

####1.	Import CloudStorages SDK;
####2.Add Dependent Framework 
- － storeKit.framework 	               
- － SystemConfiguration.framework 
- － QuartzCore.framework
- － Security.framework	
- － MobileCoreServices.framework
- － libxml2.dylib 
- － UIKit.framework 
- － Foundation.framework
- － CoreGraphics.framework  
- － CFNetwork.framework
- － libz.dylib

####3. Set up the Cloud AppKey
    Open sdk/sur/CSCloudServerConfigurator.m, set AppKey information of cloud services accordingly.

  - Register for an Box API ClientID and ClientSecret
  - Register for an DropBox API ClientSecret
  - Register for an GoogleDrive API ClientID and ClientSecret
  - Register for an Evernote API ClientID and ClientSecret
  - Register for an sugarSync API AppID、AccessKey and privateAccessKey
  - Register for an skyDrive API ClientID
  

####4. Configurate URL Schema
  - Open X-Info.plist (X means the name of your project) and create URL types in File setting (omit if it exists.); Extend URL types – URL Schemes and create AppKey:db-(DropBoxAppkey) for DropBox authorization and create another AppKey for Evernote authorization under URL Schemes.
  - The ASIHTTPRequest Library used in this SDK does not support ARC modes. If the project is under ARC mode, please set compile flags -fno-obj-arc for all ASIHTTPRequest source files.
  
####5. Modify your AppDelegate
   
  - In file "AppDelegate.m", import the header file＃import <CloudSDK/CSCloudServer.h>   
  - In - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions, add code: [CSCloudServer setCloudConfigurator]; 
  - In - (void)applicationDidBecomeActive:(UIApplication *)application, add code: [CSCloudServer handleDidBecomeActive];
  - In - (BOOL) application:(UIApplication *) application openURL:(NSURL *) url sourceApplication:(NSString *) sourceApplication annotation:(id) annotation, add code:{return [CSCloudServer openURL: url];}
  
##Using the CloudStorages SDK from your code
 **Examples**
 
 1. CSCloudServer *cloudServer = [CSCloudServer cloudServerForType:serverType]; //Cloud service object initialization
 
 2. if (cloudServer.isWebLogin)｛
 [cloudServer loginFromController:self]; // Login the cloud when the cloud land mode is weblogin；
 ｝else{
 	cloudServer.useName = useName;
 	cloudServer.password = password;
 	cloudServer.hostname = hostname;
 	cloudServer.port = port;  
    [cloudServer loginFromController:nil]; // Land cloud is a custom window; land mode parameters is nil;
 }
 3. [cloudServer logout];  //Log out
 4. [cloudServer getRootListAndFolder];//Access root directory
 5. [cloudServer getListAndFolderByFoler:folder];//Access folder directory path
 6. [cloudServer downloadFile:fileObject 				         toPath:savePath];//Download file
 7. [cloudServer uploadFilePath:localFilePath 					toFolder:destinationFolder];//Upload a single file
    [cloudServer uploadFiles:localFilePathArr					toFolder:destinationFolder];//Upload multiple files
 8. [cloudServer createNewFolder:folderName					inFolder:destinationFolder];//Create new folder
 9. [cloudServer deleteFile:fileObject];//Delete the file
 10. [cloudServer renameFile:fileObject  withName:newName];//Rename
 11. [cloudServer addToDownloadList:file withSavePath:path];//Add to download list 
 12. [cloudServer getPermissionList:file]; //Check administrators who have file permission 
 13. [cloudServer insertPermission:userName wihtRole:@"reader" toFile:file]; //Add visitors with file permission 
 14. [cloudServer deletePermission:file atPermissionID:permission]; //Remove this user's file permission. Note: you can't remove the file owner.
 
 **Attention**
 
- Initialize a cloud object to continue other relative operations  before these operations;
- Link the latest update to the Third-party libraries ASHTTPRequest TBXML in sugar sync.

  Connect:
 
     Email: cloudstorages@kdanmobile.com

Copyright (c)  2013,  [Kdan Mobile](http://www.kdanmobile.com)