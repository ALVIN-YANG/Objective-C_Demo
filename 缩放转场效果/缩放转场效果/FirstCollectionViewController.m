//
//  FirstCollectionViewController.m
//  缩放转场效果
//
//  Created by 杨卢青 on 16/5/29.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "FirstCollectionViewController.h"
#import "CollectionViewCell.h"
#import "SecondViewController.h"
#import "MagicMoveTransition.h"

@interface FirstCollectionViewController ()<UINavigationControllerDelegate>

@end

@implementation FirstCollectionViewController

static NSString * const reuseIdentifier = @"CollectionCell";

#pragma mark - life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

//Segue传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    SecondViewController *secondVC = segue.destinationViewController;
}

#pragma mark - UINavigationControllerDelegate
//定义转场样式
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[SecondViewController class]]) {
        MagicMoveTransition *transition = [[MagicMoveTransition alloc] init];
        return transition;
    }
    else {
        return nil;
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}
@end
