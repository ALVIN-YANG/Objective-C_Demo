//
//  YLQTableViewController.m
//  02-微博
//
//  Created by 杨卢青 on 15/12/6.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "YLQTableViewController.h"

@interface YLQTableViewController ()

@end

@implementation YLQTableViewController

static NSString *ID = @"CELLID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    //UITableView的头部视图的宽度,位置都是系统来决定的,只有高度室友我们自己来决定
    //除了设置高度,设置其他的都没用
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headerView.backgroundColor = [UIColor redColor];
    
    self.tableView.tableHeaderView = headerView;
    
    //取消当前控制器默认的滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置导航条为透明,传入空图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //消除阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
//每一组头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //这里设置组的头部位置和高度都是没有效果的,它由一个方法来设置头部视图的高度
    //(下一个方法设置高度)
    UIView *sectionHeafer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    sectionHeafer.backgroundColor = [UIColor yellowColor];
    return sectionHeafer;
}

//返回头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

@end
