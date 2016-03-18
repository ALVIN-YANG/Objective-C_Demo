//
//  AppDelegate.m
//  点击状态栏当前ScrollView到顶部
//
//  Created by 杨卢青 on 16/2/26.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "YLQTopWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建UIWindow
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置根控制器
    TabBarViewController *tabVC = [[TabBarViewController alloc] init];
    _window.rootViewController = tabVC;
    //显示窗口
    [_window makeKeyAndVisible];
    
    //显示顶层window
    [YLQTopWindow showWithStatusBarClickWithBlock:^{
        [self searchAllScrollViewsInView:application.keyWindow];
    }];
    return YES;
}
#pragma mark - searchAllScrollViewsInView
- (void)searchAllScrollViewsInView:(UIView *)view{
    //如果不在keyWindow范围内 (不与window重叠),直接返回
    if(![view ylq_coincideWithView:nil]) return;
    //遍历所有子控件
    for (UIView *subview in view.subviews) {
        [self searchAllScrollViewsInView:subview];
    }
    //如果不是scrollView, 直接返回
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    //滚动最后scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    //    CGPoint offset = scrollView.contentOffset;
    //    offset.y = - scrollView.contentInset.top;
    //    [scrollView setContentOffset:offset animated:YES];
    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
