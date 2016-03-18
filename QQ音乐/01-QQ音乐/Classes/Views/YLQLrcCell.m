//
//  YLQLrcCell.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQLrcCell.h"
#import "YLQLrcLabel.h"
#import "Masonry.h"

@implementation YLQLrcCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"cell";
    YLQLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLQLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        //1.创建歌词的label
        YLQLrcLabel *lrcLabel = [[YLQLrcLabel alloc] init];
        [self.contentView addSubview:lrcLabel];
        self.lrcLabel = lrcLabel;
        
        // 2.给label添加约束
        [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        
        // 3.设置label 颜色文字大小等
        lrcLabel.textColor = [UIColor whiteColor];
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        lrcLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end
