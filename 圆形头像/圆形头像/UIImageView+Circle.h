//
//  UIImageView+Circle.h
//  圆形头像
//
//  Created by 杨卢青 on 16/4/18.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Circle)
+ (instancetype)imageWithCircleImageName:(NSString *)image borderImage:(NSString *)borderImage borderWidth:(CGFloat)border;
@end
