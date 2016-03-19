//
//  YLQCell.h
//  可移动Cell
//
//  Created by 杨卢青 on 16/2/28.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLQItem;
@interface YLQCell : UITableViewCell
@property (nonatomic, strong) YLQItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
