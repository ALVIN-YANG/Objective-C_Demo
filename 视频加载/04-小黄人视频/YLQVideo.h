//
//  YLQVideo.h
//  04-小黄人视频
//
//  Created by 杨卢青 on 15/12/27.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLQVideo : NSObject

/**name*/
@property (nonatomic, strong) NSString *name;
/**image*/
@property (nonatomic, strong) NSString *image;
/**url*/
@property (nonatomic, strong) NSString *url;
/**time*/
@property (nonatomic, strong) NSNumber *length;
/**id*/
@property (nonatomic, strong) NSNumber *ID;

@end
