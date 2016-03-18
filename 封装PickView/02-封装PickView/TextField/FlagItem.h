//
//  FlagItem.h
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlagItem : NSObject

/**name*/
@property (nonatomic, copy) NSString *name;
/**icon*/
@property (nonatomic, copy) NSString *icon;

+(instancetype)flagItemWithDict:(NSDictionary *)dict;

@end
