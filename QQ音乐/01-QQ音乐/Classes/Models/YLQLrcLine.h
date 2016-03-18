//
//  YLQLrcLine.h
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLQLrcLine : NSObject

/**歌词*/
@property (nonatomic, copy) NSString *name;
/**歌词时间*/
@property (nonatomic, assign) NSTimeInterval time;

+ (instancetype)lrcLineWithLrcLineString:(NSString *)lrcLineString;

- (instancetype)initWithLrcLineString:(NSString *)lrcLineString;
@end
