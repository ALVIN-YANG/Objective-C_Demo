//
//  FlagField.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "FlagField.h"
#import "FlagItem.h"
#import "FlagView.h"
@interface FlagField()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *flagArray;

@end

@implementation FlagField

//懒加载
- (NSArray *)flagArray
{
    if (!_flagArray) {
        NSArray *dicAry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil]];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in dicAry) {
            FlagItem *item = [FlagItem flagItemWithDict:dict];
            [temp addObject:item];
        }
        _flagArray = temp;
    }
    return _flagArray;
}

#pragma mark - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib
{
    [self setUp];
}

//初始化
-(void)setUp
{
    UIPickerView *pick = [[UIPickerView alloc] init];
    
    pick.dataSource = self;
    pick.delegate = self;

    //设置pick为输入方法,自定义键盘不用设置尺寸
    self.inputView = pick;
}

//调用
- (void)initWithText
{
    [self pickerView:nil didSelectRow:0 inComponent:0];
}

#pragma mark - 代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flagArray.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 90;
}

//返回每一行的view
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    FlagView *flagView = [FlagView flagView];
    flagView.item = self.flagArray[row];
    return flagView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    FlagItem *flagItem = self.flagArray[row];
    //获取
    self.text = flagItem.name;
}
@end
