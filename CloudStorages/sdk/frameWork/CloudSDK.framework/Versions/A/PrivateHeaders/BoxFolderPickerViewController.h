//
//  BoxFolderPickerViewController.h
//  FolderPickerSampleApp
//
//  Created on 5/1/13.
//  Copyright (c) 2013 Box Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BoxFolderPickerTableViewController.h"
#import "BoxAuthorizationViewController.h"
#import "BoxSDK.h"

@class BoxFolder;
@class BoxFile;

/**
 * The BoxFolderPickerDelegate protocol allows your application to interact with a
 * BoxFolderPickerViewController and respond to the user selecting an item from
 * their Box account.
 *
 * The folder picker returns BoxModel objects to your delegate, which you can then
 * use to make API calls with the SDK.
 */
@protocol BoxFolderPickerDelegate <NSObject>

/**
 * The user has selected a file.
 * @param controller The BoxFolderPickerViewController used.
 * @param item The item picked by the user. 
 */
- (void)folderPickerController:(BoxFolderPickerViewController *)controller didSelectBoxItem:(BoxItem *)item;

/**
 * The user wants do dismiss the folderPicker
 *
 * @param controller The controller that was cancelled.
 */
- (void)folderPickerControllerDidCancel:(BoxFolderPickerViewController *)controller;

@end

/**
 * BoxFolderPickerViewController is a UI widget that allows quick and easy integration with Box.
 * Displaying a BoxFolderPickerViewController provides a file browser and enables users to select
 * a file or folder from their Box account.
 *
 * The BoxFolderPickerViewController handles OAuth2 authentication by itself if you do not wish
 * to authenticate users independently.
 *
 * The BoxFolderPickerViewController makes extensive use of thumbnail support in the Box V2 API.
 * Additionally, it can display assets from the BoxSDKResources bundle and if you wish to use
 * the folder picker, you should include this bundle in your app.
 *
 * Selection events are handled by the BoxFolderPickerDelegate delegate protocol.
 */
@interface BoxFolderPickerViewController : UIViewController <BoxFolderPickerTableViewControllerDelegate, BoxAuthorizationViewControllerDelegate>

@property (nonatomic, readwrite, weak) id<BoxFolderPickerDelegate> delegate;


/**
 * Allows you to customize the number of items that will be downloaded in a row.
 * Default value in 100.
 */
@property (nonatomic, readwrite, assign) NSUInteger numberOfItemsPerPage;

/**
 * Initializes a folderPicker according to the caching options provided as parameters. This
 * folder picker is bound to one instance of the BoxSDK and thus, one BoxOAuth2Session.
 *
 * @param sdk The SDK which the folder picker uses to perform API calls.
 * @param rootFolderID The root folder where to start browsing.
 * @param thumbnailsEnabled Enables/disables thumbnail management. If set to NO, only file icons will be displayed.
 * @param cachedThumbnailsPath The absolute path where the user wants to store the cached thumbnails.
 *   If set to nil, the folder picker will not cache the thumbnails, only download them on the fly.
 * @param fileSelectionEnabled Whether the user will be able to select a file or not while browsing his account.
 *   If not set to nil, the folder picker will cache the thumbnails at this path
 *   Not used if thumbnailsEnabled set to NO.
 * @return A BoxFolderPickerViewController.
 */
- (id)initWithSDK:(BoxSDK *)sdk rootFolderID:(NSString *)rootFolderID thumbnailsEnabled:(BOOL)thumbnailsEnabled cachedThumbnailsPath:(NSString *)cachedThumbnailsPath fileSelectionEnabled:(BOOL)fileSelectionEnabled;

/**
 * Purges the cache folder specified in the cachedThumbnailsPath parameter of the
 * initWithFolderID:enableThumbnails:cachedThumbnailsPath: method.
 */
- (void)purgeCache;

@end
