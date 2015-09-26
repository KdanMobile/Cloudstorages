//
//  GCDTimer.h
//  CloudStorages
//
//  Created by kdanmobile on 8/24/15.
//  Copyright (c) 2015 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ListenBlock)(NSInteger timeProcess,   NSInteger   blockID);
@interface GCDTimer : NSObject
@property(nonatomic, assign)NSTimeInterval          interval;
- (NSInteger)addListenBlock:(ListenBlock )listenBlock;
- (void)cancelBlock:(NSInteger )blockID;
@end
