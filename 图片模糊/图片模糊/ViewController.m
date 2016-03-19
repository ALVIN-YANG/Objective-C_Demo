//
//  ViewController.m
//  图片模糊
//
//  Created by 杨卢青 on 16/3/12.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>
#import "UIImage+ImageEffects.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//方法一:GPUImage框架, 耗时
//    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
//    blurFilter.blurRadiusInPixels = 13.0;
//    UIImage * image = [UIImage imageNamed:@"bg"];
//    UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
//    self.imageView.image = blurredImage;
    self.imageView.image = [[UIImage imageNamed:@"image"] blurImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
