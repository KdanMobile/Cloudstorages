//
//  TaskCell.h
//  CloudStorages
//
//  Created by zhujunyu on 13-10-14.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskCell : UITableViewCell<CSTaskDelegate>

@property (nonatomic, retain) UILabel *nameLable;
@property (nonatomic, retain) UILabel *stateLable;
@property (nonatomic, retain) UILabel *prossLable;
@property (nonatomic, retain) CSDownloadTask *cellTask;
- (void)displayWithTask:(CSDownloadTask *)task;
- (void)start;
@end
