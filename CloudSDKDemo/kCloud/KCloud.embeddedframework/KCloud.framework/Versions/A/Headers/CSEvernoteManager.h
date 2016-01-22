//
//  CSEvermoteManager.h
//  CloudStorages
//
//  Created by kdanmobile on 13-7-22.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCloudServer.h"

@protocol CSEvernoteDelegate;
@interface CSEvernoteManager : CSCloudServer {
    id                               delegate;
    NSMutableArray                  *_noteArray;
    NSMutableArray                  *_noteAllArray;//存放所有的notes
    NSURLConnection                 * mConnection;
    NSMutableData                   * mReturnDate;
    CloudFile                       * mnoteFile;  // 在缩图函数中，用来保存所选择的Note对象；
}

@property (nonatomic, assign) id<CSEvernoteDelegate> delegate;
@property (nonatomic, retain) NSMutableArray         *noteAllArray;

+ (CSEvernoteManager *)sharedManager;

- (void)hadLoginBefore;
- (void)searchNotesWithWord:(NSString *)word;//根据关键字来搜索Notes（对应Note名字的匹配)
- (void)getAllNotesByTags;//按照tags分类获取Notes
- (void)getAllTags;//获取所有的Tags
- (void)getNotesByTag:(NSArray *)tags;//根据tag来获取对应的Notes
- (void)getAllNotesByNoteBooks;//按照NoteBooks分类获取Notes
- (void)getAllNoteBooks;//获取所有的Notebooks
- (void)getNotesByNotebook:(NSArray *)notebooks;//根据Notebook获取对应的Notes
- (void)getNoteMiniChart:(CloudFile *)noteFile;//根据noteFile获取Note的缩图
- (void)getNoteText:(CloudFile *)noteFile;//获取note里面的部分文字

@end

@protocol CSEvernoteDelegate <CSCloudServerDelegate>//Evernote独有代理方式
@optional
- (void) evernoteGetNoteByTagsfailed:(NSError *)error;
- (void) evernoteGetNoteByTagsSuccess:(NSString *)tagName andNote:(NSArray *)noteArray andbool:(BOOL)hasNext;

- (void) evernoteGetNoteByNoteBooksFailed:(NSError *)error;
- (void) evernoteGetNoteByNoteBooksSuccess:(NSString *)bookName andNote:(NSArray *)noteArray andbool:(BOOL)hasNext;

- (void) evernoteGetNoteBykeySuccess:(NSArray *)matchedNotes andFile:(NSArray *)matchFiles;//后面为nil
- (void) evernoteGetNoteBykeyFailed;

- (void) evernoteGetAllNoteBooksSuccess:(NSArray *)allNotebooks;
- (void) evernoteGetAllNoteBooksfailed:(NSError *)error;

- (void) evernoteGetAllTagsSuccess:(NSArray *)allTags;
- (void) evernoteGetAllTagsFailed:(NSError *)error;


- (void) evernoteGetNoteMiniChartSuccess:(UIImage *)noteMiniChart andWithNote:(CloudFile *)noteFile;

- (void) evernoteGetNoteTextSuccess:(NSString *)text andWithNote:(CloudFile *)noteFile;
- (void) evernoteGetNoteTextFailed:(NSError *)error andWithNote:(CloudFile *)noteFile;

@end
