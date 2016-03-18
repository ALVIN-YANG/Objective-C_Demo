//
//  YLQLrcView.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQLrcView.h"
#import "Masonry.h"
#import "YLQLrcCell.h"
#import "YLQLrcTool.h"
#import "YLQLrcLine.h"
#import "YLQLrcLabel.h"

@interface YLQLrcView()<UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
//歌词的数组
@property (nonatomic ,strong)NSArray *lrcList;
/** 记录当前播放歌词的下标*/
@property (nonatomic ,assign)NSInteger currentIndex;

@property (nonatomic, weak)YLQLrcLabel *lrcLabel;
@end

@implementation YLQLrcView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //创建tableView
        [self setupTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupTableView];
    }
    return self;
}

#pragma mark - 创建tableView
- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self addSubview:tableView];
    self.tableView = tableView;
    
    tableView.dataSource = self;
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    //tableView的约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.mas_height);
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.mas_width);
    }];
    //2.清空tableView的背景颜色
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.bounds.size.height * 0.5, 0, self.tableView.bounds.size.height *0.5, 0);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    YLQLrcCell *cell = [YLQLrcCell lrcCellWithTableView:tableView];
    
    YLQLrcLine *lrcLine = self.lrcList[indexPath.row];
    cell.lrcLabel.text = lrcLine.name;
    //4.改变当前展示在中间的歌词的文字
    if (self.currentIndex == indexPath.row) {
        cell.lrcLabel.font =[UIFont systemFontOfSize:20];
        cell.lrcLabel.progress = 0;
    }else{
        cell.lrcLabel.font = [UIFont systemFontOfSize:14];
        cell.lrcLabel.progress = 0;
    }
    return cell;
}

#pragma mark - 重写歌词set来解析歌词
- (void)setLrcName:(NSString *)lrcName{
    //移动到中间
    [self.tableView setContentOffset:CGPointMake(0, - self.tableView.bounds.size.width * 0.5)];
    //刷新之前的行数
    self.currentIndex = 0;
    //1.保存歌词文件名
    _lrcName = [lrcName copy];
    //2.解析歌词
    self.lrcList = [YLQLrcTool lrcToolWithLrcName:lrcName];
    //3.刷新表格展示歌词
    [self.tableView reloadData];
   
}

#pragma mark - 重写播放器当前的时间来展示歌词的位置
- (void)setCurrentTime:(NSTimeInterval)currentTime{
    //1.保存时间
    _currentTime = currentTime;
    //2.获取歌词的总数
    NSInteger count = self.lrcList.count;
    for (NSInteger i = 0; i<count; i++) {
        //2.1获取i位置的歌词
        YLQLrcLine *currentLrcLine = self.lrcList[i];
        //2.2获取下一句歌词
        NSInteger nextIndex = i + 1;
        YLQLrcLine *nextLrcLine = nil;
        if (nextIndex < count) {
            nextLrcLine = self.lrcList[nextIndex];
        }
        //3.判断(用播放器当前的播放时间来与i位置的歌词的时间进行比对,再与下一句歌词的时间进行比对,如果大于等于i位置歌词的时间,小于下一句歌词的时间,那么展示i位置的歌词)
        if (self.currentIndex != i && currentTime >= currentLrcLine.time && currentTime < nextLrcLine.time) {
            //1.将当前i位置的歌词滚动到中间
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            //1.1获取上一行的indexPath
            NSIndexPath *previousPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            //2.记录当前滚动的歌词
            self.currentIndex = i;
            //3.刷新当前显示的歌词
            [self.tableView reloadRowsAtIndexPaths:@[indexPath, previousPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        // 4.获取当前这句歌词,来获得当前播放的进度
        if (self.currentIndex == i) { // 当前这句歌词
            
            // 1.获取当前歌词播放的进度
            CGFloat progress = (currentTime - currentLrcLine.time) / (nextLrcLine.time - currentLrcLine.time);
            
            // 2.获取当前展示歌词的cell
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            YLQLrcCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            // 3.设置歌词的进度   这样歌词才能渲染
            cell.lrcLabel.progress = progress;
            self.lrcLabel.progress = progress;
        }
    }
    
}
@end
