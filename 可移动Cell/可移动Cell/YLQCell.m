//
//  YLQCell.m
//  可移动Cell
//
//  Created by 杨卢青 on 16/2/28.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQCell.h"

#import "YLQItem.h"

@implementation YLQCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"YLQCell";
    YLQCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YLQCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        [cell addSubview:[[UISwitch alloc] initWithFrame:CGRectMake(200, 0, 0, 0)]];
    }
    return cell;
}

- (void)setItem:(YLQItem *)item
{
    _item = item;
    self.textLabel.text = item.title;
    self.backgroundColor = item.color;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

