//
//  DateField.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "DateField.h"

@interface DateField()
@property (nonatomic, weak)UIDatePicker *pick;
@end

@implementation DateField

-(void)initWithText
{
    [self dateChange:self.pick];
}

-(void)awakeFromNib
{
    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    //创建picker
    UIDatePicker *pick = [[UIDatePicker alloc] init];
    //设置datepick的模式
    pick.datePickerMode = UIDatePickerModeDate;
    //创建date编码模式
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //设置本地编码模式
    pick.locale = locale;
    //因为datepick没有代理,所以用事件监听, 改变值时执行dateChange方法
    [pick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.pick = pick;
    //设置pick为输入方法
    self.inputView = pick;
}

//把当前日期赋值给textfield
-(void)dateChange:(UIDatePicker *)datePick
{
    
    //把日期转换成字符串 创建格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置格式
    fmt.dateFormat = @"yyyy-MM-dd";
    //格式化日期
    NSString *dateString = [fmt stringFromDate:datePick.date];
    
    self.text = dateString;
}

@end
