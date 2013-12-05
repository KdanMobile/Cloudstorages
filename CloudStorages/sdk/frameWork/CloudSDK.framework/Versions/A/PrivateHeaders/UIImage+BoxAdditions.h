//
//  UIImage+BoxAdditions.h
//  BoxSDK
//
//  Created on 6/3/13.
//  Copyright (c) 2013 Box. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The BoxAdditions category on UIImage provides a method for loading
 * images from the BoxSDK resources bundle.
 */
@interface UIImage (BoxAdditions)

/**
 * Retrieves assets embedded in the ressource bundle.
 *
 * @param string Image name.
 */
+ (UIImage *)imageFromBoxSDKResourcesBundleWithName:(NSString *)string;

@end