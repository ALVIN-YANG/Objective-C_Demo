//
//  FirstViewController.m
//  点击状态栏当前ScrollView到顶部
//
//  Created by 杨卢青 on 16/2/27.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "FirstViewController.h"
#import "SubFirstTableViewController.h"
#import "SubSecondTableViewController.h"
#import "SubThirdTableViewController.h"

#import "YLQTitleButton.h"

@interface FirstViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIButton *preSelectedButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupChildViewController];
    
    [self setupTitle];
}

#pragma mark - setupChildViewController
- (void)setupChildViewController{
    //把控制器添加为跟控制器的子控制器, 子控制器的View加到ScrollView, 设置scrollView的contentSize高度为0, 禁止了上下滚动, 这样就不会产生冲突
    [self addChildViewController:[[SubFirstTableViewController alloc] init]];
    [self addChildViewController:[[SubSecondTableViewController alloc] init]];
    [self addChildViewController:[[SubThirdTableViewController alloc] init]];
    
    //添加控制器View到ScrollView
    //这些VC的tableView设置了contentInset
    NSUInteger count = self.childViewControllers.count;
    for (NSUInteger i = 0; i <count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.x = i * self.scrollView.width;
        vc.view.y = 0;
        vc.view.width = self.scrollView.width;
        vc.view.height = self.scrollView.height;
        [self.scrollView addSubview:vc.view];
    }
    //设置ScrollView
    [self.scrollView setContentSize:CGSizeMake(count * self.scrollView.width, 0)];    //上下不滑动就设置为0
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator =NO;
    //取消自动调整内边距, 如果不取消, 导航控制器子控制器的view会自动向下移动64
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - setupScrollView
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

#pragma mark - setupTitle
- (void)setupTitle{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 35)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    [self setupTitleButton];
}

- (void)setupTitleButton{
    NSArray *btns = @[@"SubFirst", @"SubSeconed", @"SubThird"];
    NSInteger count = btns.count;
    CGFloat btnW, btnX;
    for (NSInteger i = 0; i < count; i++) {
        btnW = self.titleView.bounds.size.width / count;
        btnX = btnW * i;
        YLQTitleButton *btn = [[YLQTitleButton alloc] init];
        btn.frame = CGRectMake(btnX, 0, btnW, self.titleView.bounds.size.height);
        btn.tag = i;
        [btn addTarget:self action:@selector(titleViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btns[i] forState:UIControlStateNormal];
        [self.titleView addSubview:btn];
    }
    //默认选中第一个
    YLQTitleButton *firstButton = self.titleView.subviews.firstObject;
    firstButton.selected = YES;
    self.preSelectedButton = firstButton;
    [firstButton.titleLabel sizeToFit];
}

- (void)titleViewButtonClick:(UIButton *)btn{
    if (self.preSelectedButton == btn) {
        //在此处可以监听重复点击
        return;
    }
    [self dealTitleButtonClick:btn];
}

- (void)dealTitleButtonClick:(UIButton *)btn{
    self.preSelectedButton.selected = NO;
    btn.selected = YES;
    self.preSelectedButton = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        //下划线
        //scrollView
        [btn.titleLabel sizeToFit];
        
        CGFloat offSetX = btn.tag * self.view.bounds.size.width;
        [self.scrollView setContentOffset:CGPointMake(offSetX, 0)];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 按钮索引
    NSInteger index = scrollView.contentOffset.x / scrollView.size.width;
    
    // 找到按钮
    YLQTitleButton *titleButton = self.titleView.subviews[index];
    //    XMGTitleButton *titleButton = [self.titlesView viewWithTag:index];
    
    // 点击按钮
    [self dealTitleButtonClick:titleButton];
    
}


@end
