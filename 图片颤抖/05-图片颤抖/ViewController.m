//
//  ViewController.m
//  05-图片颤抖
//
//  Created by 杨卢青 on 15/12/12.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ViewController.h"

#define angle2radio(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *aliImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CAKeyframeAnimation *ckm = [CAKeyframeAnimation animation];
    
    ckm.keyPath = @"transform.rotation";
    //向一边颤抖的角度
//    CGFloat angel = (-5)/ 180.0   * M_PI;
    ckm.values = @[@(angle2radio(-5)), @(angle2radio(5)), @(angle2radio(-5))];
    ckm.duration = 1;
    ckm.repeatCount = MAXFLOAT;
    
    
    //    CAKeyframeAnimation CABaseAnimaiton都是继承同一个父类.都是CAAnimation.所有他们都keyPath
//    ckm.keyPath = @"position";
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
//    [path addLineToPoint:CGPointMake(200, 500)];
//    
//    ckm.path = path.CGPath;
//    
//    ckm.duration = 2;
//    ckm.repeatCount = MAXFLOAT;
//    ckm.autoreverses = YES;
    
    [self.aliImage.layer addAnimation:ckm forKey:nil];
    
}

@end
