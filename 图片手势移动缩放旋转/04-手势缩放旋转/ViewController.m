//
//  ViewController.m
//  04-手势缩放旋转
//
//  Created by 杨卢青 on 15/12/9.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGets:)];
    rotation.delegate = self;
    
    //添加手势
    [self.imageView addGestureRecognizer:rotation];
    
    
    [self setUpPinch];
    [self setUpPan];
}

//是否允许同时支持多个手势
//Simulataneously
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)rotationGets:(UIRotationGestureRecognizer *)rotationGets{
    //实现旋转
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotationGets.rotation);
    
    //重定位
    [rotationGets setRotation:0];
}

//缩放手势(捏合手势)

- (void)setUpPinch{
    //创建手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    
    [self.imageView addGestureRecognizer:pinch];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    
    //重定位
    [pinch setScale:1];
}

- (void)setUpPan{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.imageView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    pan.delegate = self;
    
    //获取移动偏移量
    CGPoint transP = [pan translationInView:self.imageView];
    NSLog(@"transP = %@", NSStringFromCGPoint(transP));
    
    //设置形变位置变量transform
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, transP.x, transP.y);
    
    //相对于上一次复位
    [pan setTranslation:CGPointZero inView:self.imageView];
}

@end
