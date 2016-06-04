//
//  FirstCollectionViewController.h
//  缩放转场效果
//
//  Created by 杨卢青 on 16/5/29.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGRect finalCellRect;
@end
