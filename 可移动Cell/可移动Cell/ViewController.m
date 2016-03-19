//
//  ViewController.m
//  可移动Cell
//
//  Created by 杨卢青 on 16/2/28.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import "YLQDriftTableView.h"
#import "YLQItem.h"
#import "YLQCell.h"
#define YLQColor(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define YLQRandomColor YLQColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)

@interface ViewController () <YLQDriftTableViewDelegate, YLQDriftTableViewDataSource>

@property (nonatomic, strong) YLQDriftTableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self p_setupTableView];
}

- (void)p_setupTableView
{
    self.tableView = ({
        self.tableView = [[YLQDriftTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView;
    });
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLQCell *cell = [YLQCell cellWithTableView:tableView];
    cell.item = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

/** 数据源加载 */
- (NSArray *)dataSource
{
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray array];
        NSInteger numOfSecctions = 7;
        for (NSInteger i = 0; i < numOfSecctions; i ++) {
            UIColor *color = YLQRandomColor;
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSInteger j = 0; j < 20; j ++) {
                YLQItem *item = [[YLQItem alloc] init];
                item.color = color;
                item.title = [NSString stringWithFormat:@"第%zd组-第%zd行",i,j];
                [tempArray addObject:item];
            }
            [array addObject:tempArray];
        }
        _dataSource = array;
    }
    return _dataSource;
}

- (NSArray *)originalDataSourceForTableView:(YLQDriftTableView *)tableView
{
    return _dataSource;
}

- (void)tableView:(YLQDriftTableView *)tableView newDataSource:(NSArray *)newDataSource
{
    self.dataSource = newDataSource;
}

@end
