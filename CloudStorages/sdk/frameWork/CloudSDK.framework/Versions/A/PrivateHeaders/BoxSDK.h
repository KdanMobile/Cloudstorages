//
//  BoxSDK.h
//  BoxSDK
//
//  Created on 2/19/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants and logging
#import "BoxSDKConstants.h"
#import "BoxLog.h"
#import "BoxSDKErrors.h"

// OAuth2
#import "BoxAuthorizationViewController.h"
#import "BoxOAuth2Session.h"
#import "BoxSerialOAuth2Session.h"
#import "BoxParallelOAuth2Session.h"

// API Operation queues
#import "BoxAPIQueueManager.h"
#import "BoxSerialAPIQueueManager.h"
#import "BoxParallelAPIQueueManager.h"

// API Operations
#import "BoxAPIOperation.h"
#import "BoxAPIOAuth2ToJSONOperation.h"
#import "BoxAPIAuthenticatedOperation.h"
#import "BoxAPIJSONOperation.h"
#import "BoxAPIMultipartToJSONOperation.h"
#import "BoxAPIDataOperation.h"

// Request building
#import "BoxAPIRequestBuilder.h"
#import "BoxFilesRequestBuilder.h"
#import "BoxFoldersRequestBuilder.h"
#import "BoxSharedObjectBuilder.h"

// API Resource Managers
#import "BoxAPIResourceManager.h"
#import "BoxFilesResourceManager.h"
#import "BoxFoldersResourceManager.h"

// API models
#import "BoxModel.h"
#import "BoxCollection.h"
#import "BoxItem.h"
#import "BoxFile.h"
#import "BoxFolder.h"
#import "BoxUser.h"
#import "BoxWebLink.h"

// Folder Picker
#import "BoxFolderPickerHelper.h"
#import "BoxFolderPickerTableViewController.h"
#import "BoxFolderPickerViewController.h"
#import "BoxFolderPickerNavigationController.h"


extern NSString *const BoxAPIBaseURL;

/**
 * The BoxSDK class is a class that exposes a [Box V2 API Rest Client](http://developers.box.com/docs/).
 *
 * Access to this class and all other components of the BoxSDK can be granted by including `"BoxSDK.h"`
 * in your source code.
 *
 * This class provides a class method sharedSDK which provides a preconfigured SDK client,
 * including a BoxOAuth2Session and a BoxAPIQueueManager.
 *
 * This class also exposes several BoxAPIResourceManager instances. These include:
 *
 * - BoxFilesResourceManager
 * - BoxFoldersResourceManager
 *
 * This class may be instantiated directly. It is up to the caller to connect the BoxOAuth2Session and
 * BoxAPIQueueManager to the BoxAPIResourceManager instances in this case.
 *
 * @warning If you wish to support multiple BoxOAuth2Session instances (multi-account support),
 * the recommended approach is to instantiate multiple instances of BoxSDK. Each BoxSDK instance's
 * OAuth2Session and queueManager hold references to each other to enable automatic token refresh.
 */
@interface BoxSDK : NSObject

/** @name SDK client objects */

/** The base URL for all API operations including OAuth2. */
@property (nonatomic, readwrite, strong) NSString *APIBaseURL;

/**
 * The BoxSDK's OAuth2 session. This session is shared with the queueManager,
 * filesManager, and foldersManager.
 */
@property (nonatomic, readwrite, strong) BoxOAuth2Session *OAuth2Session;

/**
 * The BoxSDK's queue manager. All API calls are scheduled by this queue manager.
 * The queueManager is shared with the OAuth2Session (for making authorization and refresh
 * calls) and the filesManager and foldersManager (for making API calls).
 */
@property (nonatomic, readwrite, strong) BoxAPIQueueManager *queueManager;

/** @name API resource managers */

/**
 * The filesManager grants the ability to make API calls related to files on Box.
 * These API calls include getting file information, uploading new files, uploading
 * new file versions, and downloading files.
 */
@property (nonatomic, readwrite, strong) BoxFilesResourceManager *filesManager;

/**
 * The foldersManager grants the ability to make API calls related to folders on Box.
 * These API calls include getting file information, listing the contents of a folder,
 * and managing the trash.
 */
@property (nonatomic, readwrite, strong) BoxFoldersResourceManager *foldersManager;

#pragma mark - Globally accessible API singleton instance
/** @name Shared SDK client */

/**
 * Returns the BoxSDK's default SDK client
 *
 * This method is guaranteed to only instantiate one sharedSDK over the lifetime of an app.
 * 
 * This client must be configured with your client ID and client secret (see the
 * [Box OAuth2 documentation](http://developers.box.com/oauth/)). One possibility is to
 * configure the SDK in your application's App Delegate like so:
 * 
 * <pre><code>// somewhere in your application delegate's - (BOOL)application:didFinishLaunchingWithOptions:
 * [BoxSDK sharedSDK].OAuth2Session.clientID = @"your_client_ID";
 * [BoxSDK sharedSDK].OAuth2Session.clientSecret = @"your_client_secret";</pre></code>
 *
 * *Note*: sharedSDK returns a BoxSDK configured with a BoxSerialOAuth2Session and a BoxSerialAPIQueueManager.
 * @return a preconfigured SDK client
 */
+ (BoxSDK *)sharedSDK;

#pragma mark - Setters
/** @name Setters */

/**
 * Sets the SDK client API base URL and sets the URL on OAuth2Session and instances of BoxAPIResourceManager
 *
 * @param APIBaseURL An NSString containing the API base URL. The
 *   [Box API V2 documentation](http://developers.box.com/docs/#api-basics) states that this url is
 *   https://api.box.com. This String should not include the API Version
 */
- (void)setAPIBaseURL:(NSString *)APIBaseURL;


#pragma mark - Folder Picker
/** @name Folder Picker */

/**
 * Initializes a folderPicker according to the caching options provided as parameters
 *
 * @param rootFolderID The root folder where to start browsing.
 * @param thumbnailsEnabled Enables/disables thumbnail management.
 *   If set to NO, only file icons will be displayed
 * @param cachedThumbnailsPath The absolute path for storing cached thumbnails.
 *   If set to nil, the folder picker will not cache thumbnails, only download them on the fly.
 * @param fileSelectionEnabled Whether the user will be able to select a file or not while
 *   browsing his account. If not set to nil, the folder picker will cache the thumbnails at
 *   this path. Not used if thumbnailsEnabled set to NO.
 * @return A BoxFolderPickerViewController.
 */
- (BoxFolderPickerViewController *)folderPickerWithRootFolderID:(NSString *)rootFolderID 
                                               thumbnailsEnabled:(BOOL)thumbnailsEnabled 
                                           cachedThumbnailsPath:(NSString *)cachedThumbnailsPath
                                           fileSelectionEnabled:(BOOL)fileSelectionEnabled;

#pragma mark - Ressources Bundle
/** @name Ressources Bundle */

/**
 * The bundle containing SDK resource assets and icons.
 */
+ (NSBundle *)resourcesBundle;

@end
