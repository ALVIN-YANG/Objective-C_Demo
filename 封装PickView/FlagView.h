//
//  FlagView.h
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlagItem;
@interface FlagView : UIView
/**
 *  模型
 */
@property (nonatomic, strong) FlagItem *item;
/**
 *  快速创建方法
 */
+(instancetype)flagView;
@end
