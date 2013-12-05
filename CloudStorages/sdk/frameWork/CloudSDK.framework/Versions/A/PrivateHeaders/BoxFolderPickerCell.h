//
//  BoxFolderPickerCell.h
//  BoxSDK
//
//  Created on 5/30/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoxFolderPickerHelper;
@class BoxItem;

@interface BoxFolderPickerCell : UITableViewCell

@property (nonatomic, readwrite, strong) BoxFolderPickerHelper *helper;
@property (nonatomic, readwrite, strong) BoxItem *item;
@property (nonatomic, readwrite, strong) NSString *cachePath;
@property (nonatomic, readwrite, assign) BOOL showThumbnails;
@property (nonatomic, readwrite, assign) BOOL enabled;

@end
