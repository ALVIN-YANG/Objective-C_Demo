//
//  ViewController.m
//  04-心跳效果
//
//  Created by 杨卢青 on 15/12/12.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *cam = [CABasicAnimation animation];
    cam.keyPath = @"transform.scale";
    cam.toValue = @0;
    
    cam.repeatCount = MAXFLOAT;
    cam.duration = 1;
    //重复,写哪里都行
    cam.autoreverses = YES;
    
    [self.imageV.layer addAnimation:cam forKey:nil];
}

@end
