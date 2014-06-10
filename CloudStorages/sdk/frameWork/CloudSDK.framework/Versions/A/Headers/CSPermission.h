//
//  CSPermission.h
//  CloudStorages
//
//  Created by kdanmobile on 13-11-28.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSPermission : NSObject{
    NSString   *permissionName;
    NSString   *permissionRole;
    id         permissionObject;
}

@property (nonatomic, copy) NSString  *permissionName;//Adminisrtator's name
@property (nonatomic, copy) NSString  *permissionRole;//Role to this file
@property (nonatomic, retain) id      permissionObject;//File permission object

@end
