//
//  YLQLrcLabel.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQLrcLabel.h"

@implementation YLQLrcLabel

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 1.设置颜色
    [[UIColor redColor] set];
    
    // 2.设置当前进度
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    // 3.开始绘制
    //  UIRectFill(fillRect);
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
    
}
@end
