//
//  TabBarViewController.m
//  点击状态栏当前ScrollView到顶部
//
//  Created by 杨卢青 on 16/2/27.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *FirstVC = [[FirstViewController alloc] init];
    FirstVC.view.frame = self.view.bounds;
    FirstVC.title = @"First";
    FirstVC.view.backgroundColor = [UIColor cyanColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:FirstVC];
    [self addChildViewController:nav1];
    
    SecondTableViewController *SecondVC = [[SecondTableViewController alloc] init];
    SecondVC.view.frame = self.view.bounds;
    SecondVC.title = @"Second";
    SecondVC.view.backgroundColor = [UIColor orangeColor];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:SecondVC];
    [self addChildViewController:nav2];
    
    ThirdTableViewController *ThirdVC = [[ThirdTableViewController alloc] init];
    ThirdVC.view.frame = self.view.frame;
    ThirdVC.title = @"Third";
    ThirdVC.view.backgroundColor = [UIColor greenColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:ThirdVC];
    [self addChildViewController:nav3];
}



@end
