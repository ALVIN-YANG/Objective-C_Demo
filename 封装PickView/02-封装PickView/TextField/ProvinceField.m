//
//  ProvinceField.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ProvinceField.h"
#import "ProvinceItem.h"

@interface ProvinceField()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *provinceDateArray;
/**
 *  省份角标
 */
@property (nonatomic, assign) NSInteger curProdex;

@property (nonatomic, weak)UIPickerView *pick;

@end

@implementation ProvinceField

-(NSArray *)provinceDateArray
{
    if (!_provinceDateArray) {
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil]];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in tempArray) {
            ProvinceItem *item = [ProvinceItem provinceWithDict:dict];
            [temp addObject:item];
        }
        _provinceDateArray = temp;
    }
    return _provinceDateArray;
}


-(void)setUp
{
    UIPickerView *pick = [[UIPickerView alloc] init];
    //除了datepick都要设置代理
    pick.delegate = self;
    pick.dataSource = self;
    
    self.pick = pick;
    
    self.inputView = pick;
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

- (void)initWithText
{
    [self pickerView:self.pick didSelectRow:0 inComponent:0];
}


#pragma mark - 代理协议方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceDateArray.count;
    }else{
        //当前角标省份的item
        ProvinceItem *item = self.provinceDateArray[self.curProdex];
        return item.cities.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        ProvinceItem *item = self.provinceDateArray[row];
        return item.name;
    }else{
        //取出省份
        ProvinceItem *item = self.provinceDateArray[self.curProdex];
        //当前是城市列
        return item.cities[row];
    }
}


//当选中某一列某一行时调用该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //如果该列是省份
    if (component == 0) {
        //记录当前省份角标
        self.curProdex = row;
        //刷新列表
        [pickerView reloadAllComponents];
        //让省份第一个城市为选中状态
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    //把当前省份和城市记录在textfield
    //获取选中省
    ProvinceItem *provinceItem = self.provinceDateArray[self.curProdex];
    NSString *province = provinceItem.name;
    
    NSInteger selectedRow = [pickerView selectedRowInComponent:1];
    
    NSString *city = provinceItem.cities[selectedRow];
    self.text = [NSString stringWithFormat:@"%@-%@", province, city];
}


@end
