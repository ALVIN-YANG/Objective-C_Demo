//
//  YLQLrcTool.h
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLQLrcTool : NSObject
/**
 *  通过歌词名来解析歌词
 */

+ (NSArray *)lrcToolWithLrcName:(NSString *)lrcName;
@end
