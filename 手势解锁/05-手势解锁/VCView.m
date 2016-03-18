//
//  VCView.m
//  05-手势解锁
//
//  Created by 杨卢青 on 15/12/11.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "VCView.h"

@implementation VCView

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    [image drawInRect:rect];
}
@end
