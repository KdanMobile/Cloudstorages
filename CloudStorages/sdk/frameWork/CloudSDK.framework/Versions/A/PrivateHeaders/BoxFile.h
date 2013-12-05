//
//  BoxFile.h
//  BoxSDK
//
//  Created on 3/14/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import "BoxItem.h"

/**
 * BoxFile represents files on Box.
 */
@interface BoxFile : BoxItem

/**
 * The SHA1 of the file's content.
 */
@property (nonatomic, readonly) NSString *SHA1;

@end
