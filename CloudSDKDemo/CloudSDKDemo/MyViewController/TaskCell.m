//
//  TaskCell.m
//  CloudStorages
//
//  Created by zhujunyu on 13-10-14.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell
@synthesize nameLable,stateLable,prossLable;
@synthesize cellTask;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 30)];
        self.prossLable = [[ UILabel alloc] initWithFrame:CGRectMake(110, 5, 100, 30)];
        self.prossLable.font = [UIFont systemFontOfSize:12];
        self.stateLable = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 90, 30)];
        self.stateLable.backgroundColor = self.prossLable.backgroundColor =  self.nameLable.backgroundColor = [UIColor clearColor];
         [self.contentView addSubview:self.nameLable ];
        [self.contentView addSubview:self.prossLable];
        [self.contentView addSubview:self.stateLable];
        self.prossLable.adjustsFontSizeToFitWidth = self.stateLable.adjustsFontSizeToFitWidth = YES;
        cellTask = [[CSDownloadTask alloc] init];
    }
    return self;
}
- (void)dealloc{
    self.cellTask.delegate = nil;
    [super dealloc];
}
- (void)start{
    [self.cellTask startRunning];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)displayWithTask:(CSDownloadTask *)task{
    self.cellTask = task;
    self.cellTask.delegate  = self;
    self.nameLable.text = task.fileName;
    NSString *state = nil;
    switch (task.downloadState) {
        case kCSDownloadStateFinished:
            state = @"finished";
            break;
        case kCSDownloadStateFailed:{
            state = @"faile";break;
        }
        case kCSDownloadStateRunning:{
            state = @"downloading";
        }break;
        case kCSDownloadStateStopped:{
            state = @"stop";
        }break;
        default:{
            state = @"none";
        }
            
            break;
    }
    self.stateLable.text = state;
    if (task.fileSize != 0) {
        self.prossLable.text = [NSString stringWithFormat:@" 文件大小%0.0fkb  %0.0f%%", (float)task.fileSize/1000.0,((float)task.receivedSize/task.fileSize) * 100];
    }else{
        self.prossLable.text = @"0";
    }

}
- (void)taskStateChange{
     NSString *state = nil;
    switch (self.cellTask.downloadState) {
        case kCSDownloadStateFinished:
            state = @"finished";
            break;
        case kCSDownloadStateFailed:{
            state = @"faile";break;
        }
        case kCSDownloadStateRunning:{
            state = @"downloading";
        }break;
        case kCSDownloadStateStopped:{
            state = @"stop";
        }break;
        default:{
            state = @"none";
        }
            
            break;
    }
    self.stateLable.text = state;
}
/**
 任务下载进度的回调
 */
- (void)taskDownloadProgress{
    if (self.cellTask.fileSize != 0) {
        self.prossLable.text = [NSString stringWithFormat: @" 文件大小%0.0fkb  %0.0f%%", (float)self.cellTask.fileSize/1000.0,((float)self.cellTask.receivedSize/self.cellTask.fileSize) * 100];
    }else{
        self.prossLable.text = @"0";
    }
}
/**
 下载任务成功的回调
 */
- (void)taskDownloadSuccess{
    
}
/**
 下载任务失败的回调
 @param error 下载失败的错误信息
 */
- (void)taskDownloadFailewithError:(NSError *)error{
    
}
@end
