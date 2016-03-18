//
//  ProvinceItem.h
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceItem : NSObject
/**ary*/
@property (nonatomic, strong) NSArray *cities;
/**name*/
@property (nonatomic, copy) NSString *name;

+(instancetype)provinceWithDict:(NSDictionary *)dict;
@end
