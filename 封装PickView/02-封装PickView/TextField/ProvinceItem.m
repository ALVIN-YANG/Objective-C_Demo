//
//  ProvinceItem.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ProvinceItem.h"

@implementation ProvinceItem

+(instancetype)provinceWithDict:(NSDictionary *)dict
{
    ProvinceItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
