//
//  FlowLayout_2.m
//  01-CollectionView
//
//  Created by 杨卢青 on 16/1/16.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "FlowLayout_2.h"

@implementation FlowLayout_2
- (void)prepareLayout
{   //一定要写 super  作用:计算所有的cell布局,条件:cell布局固定
    //一开始布局就会调用,UICollectionView刷新的时候也会调用
    [super prepareLayout];
}

// 给定一个区域,就返回这个区域内所有cell布局
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // 1.获取显示区域,bounds
    CGRect visiableRect = self.collectionView.bounds;
    // 2.获取显示区域内的cell的布局
    NSArray *attributes = [super layoutAttributesForElementsInRect:visiableRect];
    //改变各种属性
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
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //改变最终偏移量以达到效果
    return proposedContentOffset;
}


@end
