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
    [self addChildViewController:[[SubFirstTableViewController alloc] init]];
    [self addChildViewController:[[SubSecondTableViewController alloc] init]];
    [self addChildViewController:[[SubThirdTableViewController alloc] init]];
    
    //添加控制器View到ScrollView
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
    //取消自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - setupScrollView
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollView;
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
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btns[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.frame = CGRectMake(btnX, 0, btnW, self.titleView.bounds.size.height);
        btn.tag = i;
        [btn addTarget:self action:@selector(titleViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
    }
}

- (void)titleViewButtonClick:(UIButton *)btn{
    if (self.preSelectedButton == btn) {
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
        CGFloat offSetX = btn.tag * self.view.bounds.size.width;
        [self.scrollView setContentOffset:CGPointMake(offSetX, 0)];
    }];
}
@end
