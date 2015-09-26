//
//  UpAndDownloadViewController.h
//  CloudStorages
//
//  Created by zhujunyu on 13-7-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol uploadChooseDelegate <NSObject>

@optional
- (void)uploadFilePath:(NSString *)fileUrl;
- (void)uploadFilePathArr:(NSArray *)fileArr;

@end
#import <UIKit/UIKit.h>
@interface UpAndDownloadViewController : UITableViewController
{
    NSMutableArray              * _fileArray;
    BOOL                        _arrChoose;
    NSMutableArray              *_chooseArr;
    UIButton                    *_choosBtn;
}
@property (nonatomic, assign)id <uploadChooseDelegate> delegate;
@end
