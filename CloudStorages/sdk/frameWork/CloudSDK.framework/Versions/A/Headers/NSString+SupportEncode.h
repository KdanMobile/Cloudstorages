//
//  NSString+SupportEncode.h
//  CloudStorages
//
//  Created by kdanmobile on 14-2-11.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SupportEncode)
+ (NSArray *)supportEncodeNames;
+ (NSStringEncoding)encodingFromName:(NSString *)encodeName;
+ (NSString *)nameOfEncoding:(NSStringEncoding )encoding;
@end
