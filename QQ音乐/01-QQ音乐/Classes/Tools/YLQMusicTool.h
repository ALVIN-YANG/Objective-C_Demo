//
//  YLQMusicTool.h
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLQMusic;
@interface YLQMusicTool : NSObject
/**
 *  获取所有歌曲
 */
+ (NSArray *)musics;
/**
 *  获取正在播放的歌曲
 */
+ (YLQMusic *)playingMusic;
/**
 *  设置播放的歌曲
 */
+ (void)setupMusic:(YLQMusic *)music;
/**
 *  获取上一首歌曲
 */
+ (YLQMusic *)previous;
/**
 *  获取下一首歌曲
 */
+ (YLQMusic *)next;
@end
