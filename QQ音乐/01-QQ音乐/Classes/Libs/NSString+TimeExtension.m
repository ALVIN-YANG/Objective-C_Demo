//
//  NSString+TimeExtension.m
//  05-QQMusic
//
//  Created by xmg on 16/1/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "NSString+TimeExtension.h"

@implementation NSString (TimeExtension)

+ (NSString *)stringWithTime:(NSTimeInterval)time {
    
    // 1.获取分钟
    NSInteger min = time / 60;
    
    // 2.获取秒
    NSInteger sec = (NSInteger)time % 60;
    
    // 3.拼接字符串返回
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
}

@end
