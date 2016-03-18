//
//  UIView+AdjustFrame.h
//  QQ_Zone
//
//  Created by apple on 14-12-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 用点语法直接给frame赋值
 */
@interface UIView (Frame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
//是否重合 于 屏幕
- (BOOL)ylq_coincideWithView:(UIView *)view;
@end
