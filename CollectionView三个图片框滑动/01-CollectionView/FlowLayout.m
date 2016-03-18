//
//  FlowLayout.m
//  01-CollectionView
//
//  Created by 杨卢青 on 16/1/15.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "FlowLayout.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@implementation FlowLayout

// 给定一个区域,就返回这个区域内所有cell布局
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 1.获取显示区域,bounds
    CGRect visiableRect = self.collectionView.bounds;
    
    // 2.获取显示区域内的cell的布局
    NSArray *attributes = [super layoutAttributesForElementsInRect:visiableRect];
    
    // 3.遍历cell布局
    CGFloat offsetX = self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        // 3.1 计算下距离中心点距离
        CGFloat delta = fabs(attr.center.x - offsetX - ScreenW * 0.5);
        // 1 ~ 0.75
        CGFloat scale = 1 - delta / (ScreenW * 0.5) * 0.25;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attributes;
}

// Invalidate:刷新
// 是否允许在拖动的时候刷新布局
// 谨慎使用,YES:只要一滚动就会布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

// 确定最终显示位置
// 什么时候调用:手动拖动UICollectionView,当手指离开的时候,就会调用
// 作用:返回UICollectionView最终的偏移量
// proposedContentOffset:最终的偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 定位:判断下哪个cell里中心点越近,就定位到中间
    // 1.获取最终显示的区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, MAXFLOAT);
    
    // 2.获取最终显示cell的布局
    NSArray *attributes = [super layoutAttributesForElementsInRect:targetRect];
    
    // 3.遍历所有cell的布局,判断下哪个离中心点最近
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        // 3.1 计算下距离中心点距离
        CGFloat delta = attr.center.x - proposedContentOffset.x - ScreenW * 0.5;
        // 3.2 计算最小间距
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    
    proposedContentOffset.x += minDelta;
    
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    
    
    return proposedContentOffset;
}

@end
