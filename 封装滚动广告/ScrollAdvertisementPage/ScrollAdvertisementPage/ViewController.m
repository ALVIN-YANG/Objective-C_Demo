//
//  ViewController.m
//  ScrollAdvertisementPage
//
//  Created by 杨卢青 on 16/2/23.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import "YLQScrollPage.h"


@interface ViewController ()<YLQScrollPageDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //scrollView
    YLQScrollPage *scrollView = [[YLQScrollPage alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    scrollView.images = @[
                          [UIImage imageNamed:@"image0"],
                          [UIImage imageNamed:@"image1"],
                          [UIImage imageNamed:@"image2"],
                          [UIImage imageNamed:@"image3"]
                          ];
    scrollView.delegate = self;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor redColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    [self.view addSubview:scrollView];
    
   
}

#pragma mark - <YLQScrollPageDelegate>
- (void)infiniteScrollView:(YLQScrollPage *)scrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%zd个图片", index);
}
@end
