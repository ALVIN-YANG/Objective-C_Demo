//
//  YLQLrcCell.h
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLQLrcLabel;
@interface YLQLrcCell : UITableViewCell

/**歌词的label*/
@property (nonatomic, weak) YLQLrcLabel *lrcLabel;
+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;
@end
