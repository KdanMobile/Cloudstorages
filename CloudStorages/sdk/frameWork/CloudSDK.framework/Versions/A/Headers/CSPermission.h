//
//  CSPermission.h
//  CloudStorages
//
//  Created by kdanmobile on 13-11-28.
//  Copyright (c) 2013 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSPermission : NSObject{
    NSString   *permissionName;  //Adminisrtator's name
    NSString   *permissionRole;  //Role to this file.
    id         permissionObject;//File permission object.
}

@property (nonatomic, copy) NSString  *permissionName;
@property (nonatomic, copy) NSString  *permissionRole;
@property (nonatomic, retain) id      permissionObject;

@end
