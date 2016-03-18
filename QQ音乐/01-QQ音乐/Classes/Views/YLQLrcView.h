//
//  YLQLrcView.h
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/10.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLQLrcView : UIScrollView

/**当前歌词*/
@property (nonatomic, copy) NSString *lrcName;
/** 当前播放器的播放时间*/
@property (nonatomic ,assign)NSTimeInterval currentTime;
@end
