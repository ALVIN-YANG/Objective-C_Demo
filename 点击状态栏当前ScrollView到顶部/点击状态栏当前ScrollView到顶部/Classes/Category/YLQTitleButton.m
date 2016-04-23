//
//  YLQTitleButton.m
//  点击状态栏当前ScrollView到顶部
//
//  Created by 杨卢青 on 16/4/23.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQTitleButton.h"

@implementation YLQTitleButton
//初始化时设置导航button的属性
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

//取消高亮
- (void)setHighlighted:(BOOL)highlighted{}
@end
