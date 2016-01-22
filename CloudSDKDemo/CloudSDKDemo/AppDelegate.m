//
//  AppDelegate.m
//  CloudSDKDemo
//
//  Created by dongyongzhu on 15/9/8.
//  Copyright (c) 2015年 Kdan Mobile. All rights reserved.
//

#import "AppDelegate.h"
#import <KCloud/KCloud.h>
#import "MyMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Config CloudStorage
    CSCloudServerConfigurator *config = [CSCloudServerConfigurator defaultConfig];
    //Box
    config.boxClientID          = @"zib5lgovikza4jlrrp64jj66nce5emna";
    config.boxClientSecret      = @"RWjHpoStGxCiijOxyupbEnSA6SzDrWSo";
    //DropBox
    config.dropboxCosumerKey    = @"no2ju306lkesmpg";
    config.dropboxCosumerSecret = @"e7txknyenfds1b8";
    //Google Driver
    config.googleDriverClientID = @"899818209298.apps.googleusercontent.com";
    config.googleDriverClientSecret = @"n2r7dEP4ZKis4e_Fe65dcuDY";
    config.googleDriverKeyChainItemName = @"iOSDriveSample: Google Drive";
    //Evernote
    config.evernoteAccessKey    = @"eleeditor";
    config.evernoteSecret       = @"8940c93e6ff639e8";
    //SugarSync
    config.sugarSyncAppID       = @"/sc/2720968/327_412818324";
    config.sugarSyncAccessKey   = @"MjcyMDk2ODEzNjQ5NjA5NDUzOTc";
    config.sugarSyncPrivateAccessKey = @"ODM1MWU1MDI2NDdkNGVmYmE3ZGZjMDk0ZmRkOTk3OGE";
    //OneDrive
    config.oneDriveClientID     = @"0000000040103766";
    //Support file types
    config.supportFileTypes     = [CSCloudServerConfigurator allFileTypes];
    //path
    config.downloadFileSavePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    config.chooseUploadFilesPath= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //模拟发送OpenURL 事件
#if DEBUG || 1
    [CSCloudServer openURL:[NSURL URLWithString:@"http://www.kdanmobile.com"]];
#endif
    
    //Init App
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    _viewController = [[MyMainViewController alloc]init];
    _theNavigationController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    [self.window setRootViewController:_theNavigationController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [CSCloudServer openURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[CSDownloadManager sharedManager] saveDownloadTask];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
