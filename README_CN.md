#CloudStorages SDK for iOS
#简介
CouldStorages SDK是一个用于管理不同云端数据的类库。目前总共包含十个云端数据，分别是：Box、DropBox、GoogleDrive、GoogleDocs、FTP、MyDisk、WebDav、EverNote、SugarSync、skyDrive。当前版本1.0。
#运行环境
- 支持架构 armv7 arm64
- 支持 iOS 5.0 及以上
 
#文件导入 

###文件加入步骤

####1. 添加CloudStoragesSDK文件夹到项目中;
####2. 添加Xcode系统依赖框架 
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

####3. 设置所有云端的AppKey
    打开sdk/sur/CSCloudServerConfigurator.m文件，根据需求设置各个云端的AppKey相关信息

  - Box设置ClientID和ClientSecret
  - DropBox设置ClientSecret
  - GoogleDrive申请ClientID和ClientSecret
  - EverNote申请AccessKey和Secret
  - sugarSync申请AppID和AccessKey、privateAccessKey
  - skyDrive申请ClientID
  

####4. 配置URL Schemes
  - 打开AppName-Info.plist（AppName代表你的工程名字），在配置文件中新增一项URL types（如果存在可以不创建），展开URL types – URL Schemes，在URL Schemes下新增两项分别为 db-yourDropboxAppkey  和 en-yourEverNoteAccessKey
  - 本sdk使用到了ASIHTTPReqest库它不支持ARC模式的文件，所以如果是在ARC模式下需将它所有文件	的arc 禁止（–fno-objc-arc）
  
####5. AppDelegate.m文件配置

  - 在AppDelegate.m文件中，导入头文件＃import <CloudSDK/CSCloudServer.h>
  - 在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions函数中，添加代码：
  ［CSCloudServer setCloudConfigurator］;
  - 在- (void)applicationDidBecomeActive:(UIApplication *)application函数中添加代码：
  ［CSCloudServer handleDidBecomeActive］;
  - 在- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
return [CSCloudServer openURL:url];
}

#使用指南

ColudStorages SDK功能主要是实现对云端里面文件的上传、下载等统一管理。
###CloudStorages SDK基本用法
 **使用示例**
 
 1. CSCloudServer *cloudServer = [CSCloudServer cloudServerForType:serverType]; //初始化云端对象

 2.  if (cloudServer.isWebLogin)
[cloudServer loginFromController:self];//登陆云端，当云端登陆方式为网页登陆时；
 else{
 	cloudServer.useName = useName;
 	cloudServer.password = password;
 	cloudServer.  （再加上哪些需要哪些参数吧） 登陆还是说清楚点好其他的等他自己去看别的资料 你看别个的skd的都是 登陆一般都写的比较详细点 
  [cloudServer loginFromController:nil]; // 登陆云端为自定义窗口登陆方式参数为nil
 }
 3. [cloudServer logout];  //退出云端
 4. [cloudServer getRootListAndFolder];//获取目录列表
 5. [cloudServer getListAndFolderByFoler:folder];//获取文件夹列表
 6. [cloudServer downloadFile:fileObject 				         toPath:savePath];//下载文件
 7. [cloudServer uploadFilePath:localFilePath 					toFolder:destinationFolder];//上传单个文件
    [cloudServer uploadFiles:localFilePathArr					toFolder:destinationFolder];//上传多个文件
 8. [cloudServer createNewFolder:folderName					inFolder:destinationFolder];//新建文件夹
 9. [cloudServer deleteFile:fileObject];//删除文件
 10. [cloudServer renameFile:fileObject  withName:newName];//文件重命名
 11. ［cloudServer addToDownloadList:file withSavePath:path］; //添加到下载列表
 12. [cloudServer getPermissionList:file]; //查看文件权限拥有者
 13. [cloudServer insertPermission:userName wihtRole:@"reader" toFile:file]; //添加文件权限访问者
 14. [cloudServer deletePermission:file atPermissionID:permission]; //删除某个用户对文件的访问权限
 
 **注意事项**
 
- 在进行这些操作前，首先要初始化一个云端对象，利用云端对象来进行其他的相关操作。
- sugar sync 中引用到常用第三方库 ASHTTPRequest TBXML ，如有最新的请使用最新版本第三方库；

     联系我们： 
     
     QQ群：210232170  
     邮箱：cloudstorages@kdanmobile.com

Copyright (c)  2013,  [Kdan Mobile](http://www.kdanmobile.com)