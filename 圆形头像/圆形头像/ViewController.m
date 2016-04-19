//
//  ViewController.m
//  圆形头像
//
//  Created by 杨卢青 on 16/4/8.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Circle.h"
#import "UIImageView+Circle.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *image = [UIImage imageNamed:@"userImage"];
//    _imageview.layer.masksToBounds = YES;
//    _imageview.layer.cornerRadius = _imageview.frame.size.width / 2;
//    _imageview.layer.borderColor = [UIColor purpleColor].CGColor;
//    _imageview.layer.borderWidth = 10;
//    _imageview.image = image;
//
//    self.imageview.image = [UIImage imageNamed:@"grainImage"];
    
    
//    self.imageview.image = [UIImage imageWithCircleImageName:@"userImage" borderImage:@"grainImage" borderWidth:40];
    self.imageview = [UIImageView imageWithCircleImageName:@"userImage" borderImage:@"grainImage" borderWidth:40];
}

- (void)flowerBoard
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
