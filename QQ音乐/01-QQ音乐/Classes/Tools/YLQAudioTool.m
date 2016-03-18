//
//  YLQAudioTool.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQAudioTool.h"

@implementation YLQAudioTool

static NSMutableDictionary *_soundIDs;
static NSMutableDictionary *_players;
//初始化盛放属性
+ (void)initialize{
    _soundIDs = [NSMutableDictionary dictionary];
    _players = [NSMutableDictionary dictionary];
}

//播放音乐
+ (AVAudioPlayer *)playMusicWithMusicName:(NSString *)musicName{
    //1.从数据里面取出播放器
    AVAudioPlayer *player = _players[musicName];
    //2.判断播放器是否存在
    if(player == nil){
        //不存在就创建音乐资源,相当于懒加载
        NSURL *url = [[NSBundle mainBundle]URLForResource:musicName withExtension:nil];
        if (url == nil)return nil;
        
        //2.2创建对应的播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        //2.3准备播放
        [player prepareToPlay];
        //2.4将播放器存入字典在中
        [_players setObject:player forKey:musicName];
    }
    //3.播放
    [player play];
    return player;
}

//暂停
+ (void)pauseMusicWithMusicName:(NSString *)musicName{

    //1.取出播放器
    AVAudioPlayer *player = _players[musicName];
    //2.判断播放器是否存在
    if (player) {
        [player pause];
    }
}

+ (void)stopMusicWithMusicName:(NSString *)musicName{
    //1.从字典中取出播放器
    AVAudioPlayer *player = _players[musicName];
    if (player) {
        [player stop];
        //把此播放器移除?
        [_players removeObjectForKey:musicName];
        player = nil;
    }
}

#pragma mark - 播放音效----
+ (void)playSoundWithSoundName:(NSString *)soundName{
    //1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDs[soundName] unsignedIntValue];
    //2.判断soundID是否为0
    if (soundID == 0) {
        //2.1没有就创建音效资源
        CFURLRef url = (__bridge CFURLRef)([[NSBundle mainBundle]URLForResource:soundName withExtension:nil]);
        //2.2生成SystemSoundID
        AudioServicesCreateSystemSoundID(url, &soundID);
        //2.3将生成的SystemSoundID存入字典
        [_soundIDs setObject:@(soundID) forKey:soundName];
    }
    //3.音效
    AudioServicesPlaySystemSound(soundID);
}

@end
