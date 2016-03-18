//
//  NewsViewController.m
//  01-网易新闻
//
//  Created by 杨卢青 on 16/1/14.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "NewsViewController.h"
#import "TopLineViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "ScoietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"


@interface NewsViewController ()

@end

@implementation NewsViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupAllChildViewController];
}

#pragma mark -添加子控制器
- (void)setupAllChildViewController
{
    // 头条
    TopLineViewController *topLineVc = [[TopLineViewController alloc] init];
    // 保存对应按钮的标题
    topLineVc.title = @"头条";
    [self addChildViewController:topLineVc];
    
    // 热点
    HotViewController *hotVc = [[HotViewController alloc] init];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];
    
    // 视频
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 社会
    ScoietyViewController *scoietyVc = [[ScoietyViewController alloc] init];
    scoietyVc.title = @"社会";
    [self addChildViewController:scoietyVc];
    
    // 订阅
    ReaderViewController *readerVc = [[ReaderViewController alloc] init];
    readerVc.title = @"订阅";
    [self addChildViewController:readerVc];
    
    // 科技
    ScienceViewController *scienceVc = [[ScienceViewController alloc] init];
    scienceVc.title = @"科技";
    [self addChildViewController:scienceVc];
    
}


@end
