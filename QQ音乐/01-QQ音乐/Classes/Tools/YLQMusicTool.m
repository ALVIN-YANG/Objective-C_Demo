//
//  YLQMusicTool.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQMusicTool.h"
#import "MJExtension.h"
#import "YLQMusic.h"

@implementation YLQMusicTool

static NSArray *_musics;
static YLQMusic *_playingMusic;
//初始化音乐
+ (void)initialize{
    _musics = [YLQMusic objectArrayWithFilename:@"Musics.plist"];
    _playingMusic = _musics[1];
}

+ (NSArray *)musics{
    return _musics;
}

+ (YLQMusic *)playingMusic{
    return _playingMusic;
}

+ (void)setupMusic:(YLQMusic *)music{
    _playingMusic = music;
}

+ (YLQMusic *)previous{
    //1.获取当前歌曲的下标
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    //2.获取上一首歌曲的下标
    NSInteger previousIndex = currentIndex - 1;
    YLQMusic *previousMusic = nil;
    if (previousIndex<0) {
        previousIndex = _musics.count - 1;
    }
    previousMusic = _musics[previousIndex];
    
    return previousMusic;
}

+ (YLQMusic *)next{
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    NSInteger nextIndex = currentIndex + 1;
    YLQMusic *nextMusic = nil;
    if (nextIndex>_musics.count - 1) {
        nextIndex = 0;
    }
    nextMusic = _musics[nextIndex];
    return nextMusic;
}
@end
