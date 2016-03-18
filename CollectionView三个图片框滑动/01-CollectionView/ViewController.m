//
//  ViewController.m
//  01-CollectionView
//
//  Created by 杨卢青 on 16/1/15.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "FlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource>

@end

#define ScreenW     [UIScreen mainScreen].bounds.size.width
#define ScreenH     [UIScreen mainScreen].bounds.size.height
static NSString * const ID = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
}

#pragma mark - setUpCellectionView
- (void)setUpCollectionView{
    //布局, 初始化
    FlowLayout *layOut = [[FlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(180, 180);
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, 200) collectionViewLayout:layOut];
    // 设置额外滚动区域
    CGFloat inset = (ScreenW - 180) * 0.5;
    layOut.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    collectionView.backgroundColor = [UIColor cyanColor];
    collectionView.center = self.view.center;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
}

#pragma mark - CollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSString *image = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:image];
    return cell;
}
@end
