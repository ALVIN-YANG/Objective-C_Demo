//
//  YLQDragTableView.h
//  可移动Cell
//
//  Created by 杨卢青 on 16/2/28.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLQDriftTableView;

@protocol YLQDriftTableViewDataSource <UITableViewDataSource>
@required
/**
 *  获取外部的数据源
 */
- (NSArray *)originalDataSourceForTableView:(YLQDriftTableView *)tableView;
@end

@protocol YLQDriftTableViewDelegate <UITableViewDelegate>
@required
/**
 *  将重新排序的数据源传到外部
 */
- (void)tableView:(YLQDriftTableView *)tableView newDataSource:(NSArray *)newDataSource;
@optional
- (void)tableView:(YLQDriftTableView *)tableView cellReadyToMoveAtIndexPath:(NSIndexPath *)indexPath;
- (void)cellIsMovingInTableView:(YLQDriftTableView *)tableView;
- (void)cellDidEndMovingInTableView:(YLQDriftTableView *)tableView;
@end

@interface YLQDriftTableView : UITableView

@property (nonatomic, weak) id <YLQDriftTableViewDataSource> dataSource;
@property (nonatomic, weak) id <YLQDriftTableViewDelegate> delegate;
@end
