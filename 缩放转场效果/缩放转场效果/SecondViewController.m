//
//  SecondViewController.m
//  缩放转场效果
//
//  Created by 杨卢青 on 16/5/29.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstCollectionViewController.h"
#import "MagicMoveInverseTransition.h"

@interface SecondViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@end

@implementation SecondViewController

#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    self.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecgnizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecgnizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecgnizer];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark - Helper
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    //计算手指滑的距离 (滑了多远, 与起始位置无关), 屏幕比例
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    //把比例限制在0~1之间
    progress = MIN(1.0, MAX(0.0, progress));
    
    //当手势刚刚开始, 创建一个UIPercentDrivenInteractiveTransition对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
    //当手势慢慢划入时, 我们把划入进度告诉  UIPercentDrivenInteractiveTransition对象
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
    //当手势结束, 我们根据用户的手势进度来 判断过度 是 应该 完成 还是 取消
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }
        else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[FirstCollectionViewController class]]) {
        MagicMoveInverseTransition *interseTransition = [[MagicMoveInverseTransition alloc] init];
        return interseTransition;
    }
    else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
        return self.percentDrivenTransition;
    }
    else {
        return nil;
    }
}
@end
