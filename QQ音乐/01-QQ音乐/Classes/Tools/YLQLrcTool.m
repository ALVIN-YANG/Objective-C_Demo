//
//  YLQLrcTool.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQLrcTool.h"
#import "YLQLrcLine.h"
@implementation YLQLrcTool

+ (NSArray *)lrcToolWithLrcName:(NSString *)lrcName{
    //1.获取歌词资源路径
    NSString *path = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    //2.获取所有歌词的字符串
    NSString *lrcString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //3.将歌词转化为数组
    NSArray *lrcArray = [lrcString componentsSeparatedByString:@"\n"];
    //4.遍历数组,将数组中的字符串转换为模型
    NSMutableArray *lrcArrayM = [NSMutableArray array];
    for (NSString *lrcLineString in lrcArray) {
        //4.1过滤不需要的字符串
        if ([lrcLineString hasPrefix:@"[ti"] ||
            [lrcLineString hasPrefix:@"[ar"] ||
            [lrcLineString hasPrefix:@"[al"] ||
            ![lrcLineString hasPrefix:@"["]) {
            continue;
        }
        //4.2解析歌词
        YLQLrcLine *lrcLine = [YLQLrcLine lrcLineWithLrcLineString:lrcLineString];
        [lrcArrayM addObject:lrcLine];
    }
    return lrcArrayM;
}
@end
