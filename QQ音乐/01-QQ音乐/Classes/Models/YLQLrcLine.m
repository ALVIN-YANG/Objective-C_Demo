//
//  YLQLrcLine.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQLrcLine.h"

@implementation YLQLrcLine

+ (instancetype)lrcLineWithLrcLineString:(NSString *)lrcLineString{
    return [[self alloc] initWithLrcLineString:lrcLineString];
}

- (instancetype)initWithLrcLineString:(NSString *)lrcLineString
{
    if (self = [super init]) {
        //通过]将字符串分割成数组
        NSArray *lrcArray = [lrcLineString componentsSeparatedByString:@"]"];
        //1.解析歌词
        self.name = lrcArray[1];
        //2.解析时间
        NSString *timeString = lrcArray[0];
        //[00:33:33   从第1个开始截
        self.time = [self timeWithTimeString:[timeString substringFromIndex:1]];
    }
    return self;
}

- (NSTimeInterval)timeWithTimeString:(NSString *)timeString{
    NSInteger min = [[timeString componentsSeparatedByString:@":"][0]integerValue];
    NSInteger sec = [[timeString substringWithRange:NSMakeRange(3, 2)] integerValue];
    NSInteger haomiao = [[timeString componentsSeparatedByString:@"."][1] integerValue];
    return min * 60 + sec + haomiao * 0.01;
}
@end
