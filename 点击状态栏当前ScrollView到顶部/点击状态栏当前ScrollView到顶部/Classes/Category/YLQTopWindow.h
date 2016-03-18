//
//  YLQTopWindow.h
//  点击状态栏当前ScrollView到顶部
//
//  Created by 杨卢青 on 16/2/27.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLQTopWindow : UIWindow

+ (void)showWithStatusBarClickWithBlock:(void (^)())block;

+ (void)setStatusBarHidden:(BOOL)hidden;
+ (void)setStatusBarStyle:(UIStatusBarStyle)style;
@end
