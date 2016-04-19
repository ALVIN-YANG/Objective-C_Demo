//
//  UIImageView+Circle.m
//  圆形头像
//
//  Created by 杨卢青 on 16/4/18.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "UIImageView+Circle.h"

@implementation UIImageView (Circle)
+ (instancetype)imageWithCircleImageName:(NSString *)image borderImage:(NSString *)borderImage borderWidth:(CGFloat)border {
    //原始图片
    UIImage *oriImage = [UIImage imageNamed:image];
    //纹理图片
    UIImage *grainImage = [UIImage imageNamed:borderImage];
    CGSize size = CGSizeMake(oriImage.size.width + border * 2, oriImage.size.height + border * 2);
    
    //创建上下文图片
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //先绘制纹理边框的图
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    //剪切可是范围
    CGContextClip(context);
    //绘制边框图片
    [grainImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    
    //设置头像frame
    CGFloat iconX = border;
    CGFloat iconY = border;
    CGFloat iconW = oriImage.size.width;
    CGFloat iconH = oriImage.size.height;
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
    //剪切可视范围
    CGContextClip(context);
    //绘制头像
    [oriImage drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:iconImage];
    return imageView;
}
@end
