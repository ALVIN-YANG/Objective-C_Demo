//
//  FlagItem.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem

+(instancetype)flagItemWithDict:(NSDictionary *)dict
{
    //创建对象
    FlagItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
