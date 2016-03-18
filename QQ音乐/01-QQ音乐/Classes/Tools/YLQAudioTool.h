//
//  YLQAudioTool.h
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface YLQAudioTool : NSObject
/**
 *  播放音乐
 */
+ (AVAudioPlayer *)playMusicWithMusicName:(NSString *)musicName;
/**
*  暂停音乐
*/
+ (void)pauseMusicWithMusicName:(NSString *)musicName;
/**
*  停止音乐
*/
+ (void)stopMusicWithMusicName:(NSString *)musicName;
/**
*  播放音效
*/
+ (void)playSoundWithSoundName:(NSString *)soundName;
@end
