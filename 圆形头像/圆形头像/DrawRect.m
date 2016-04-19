//
//  DrawRect.m
//  圆形头像
//
//  Created by 杨卢青 on 16/4/18.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "DrawRect.h"

@implementation DrawRect
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //获取rect
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置笔触颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    //设置笔触宽度
    CGContextSetLineWidth(ctx, 2);
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, [UIColor purpleColor].CGColor);
    //设置拐点样式
//    enum CGLineJoin {
//        kCGLineJoinMiter, //尖的, 斜接
//        kCGLineJoinRound, //圆
//        kCGLineJoinBevel  //斜面
//    };
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //Line cap 线的两端的样式
//    enum CGLineCap {
//        kCGLineCapButt,
//        kCGLineJoinRound,
//        kCGLineCapSquare
//    };
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //虚线线条样式
//    CGFloat lengths[] = {10, 10};
    //画线
    CGContextAddArc(ctx, 100, 100, 50, 0, M_PI* 2, 0);
    CGContextStrokePath(ctx);
}
@end
