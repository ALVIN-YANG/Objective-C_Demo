//
//  ViewController.m
//  02-时钟
//
//  Created by 杨卢青 on 15/12/12.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

/**
 时钟思路:
    三个针, 三个layer
 在viewDidLoad里添加指针, 计时器
 
    添加针: 创建layer,设置rect,设置position->center,设置锚点,0.5,1,
            设置颜色,  由于会在其他方法中调用,所以要把layer复制给属性
            把layer加入到view的sublayer
    写计时器方法
        获取当前日历,把calendar 里的components时分秒拿出来,给一个NSDateComponent对象, 由此对象就可以取出 cmp.时分秒
            根据时分秒计算出此时三个layer旋转的度数,
    `       更新三个layer的transform属性,CATransform3DMakeRotation

 */
//直接把数值转化成弧度
#define angle2Rad(angle)  ((angle) / 180.0 * M_PI)
//每秒
#define perSecA 6
//每分
#define perMinuteA 6
//每分,时针
#define  perMinuteHourA 0.5
//
#define perHourA 30



#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;
//CALayer就相当于UIView
@property (nonatomic, weak)CALayer *secondL;
@property (nonatomic, weak)CALayer *minuteL;
@property (nonatomic, weak)CALayer *hourL;

@end

@implementation ViewController
//注意,所有的控件或者图层都是绕着锚点进行旋转的
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加时针
    [self setUpHourLayer];
    [self setUpMinuteLayer];
    [self setUpSecLayer];
    
    //创建定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    //如果不写这一句, 一秒钟之后才会显示正确时间
    [self timeChange];
}

//添加秒针
- (void)setUpSecLayer
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 1, 80);
    layer.backgroundColor = [UIColor redColor].CGColor;
    //设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
    self.secondL = layer;
    //把此创建的layer, 加入到父控件的layer中,是点layer哦
    [self.clockView.layer addSublayer:layer];
}

//添加分针
- (void)setUpMinuteLayer{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 4, 80);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
    self.minuteL = layer;
    [self.clockView.layer addSublayer:layer];
}

//添加时针
- (void)setUpHourLayer
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 5, 60);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
    self.hourL = layer;
    [self.clockView.layer addSublayer:layer];
}

//每一次的时间改变,都会调用此方法
- (void)timeChange
{
    //获取当前的描述
    //创建日历类
        //当前的日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //把日历转换成一个日期组件
    //日期组件(年,月,日,时,分,秒)
    //component:日期组件的组成,枚举,里面有年月日时分秒
    //fromDate:初始的日期
    
    //里面若有左右移符号,说明合一进行 并运算
    //同时支持秒数,和分钟,  加一个 |
    //不要写错了方法 components  一定要加's'
        //获得cmp
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    //获取秒就是保存在日期组件里,提供了很多get方法
    NSInteger second = cmp.second;
    //分钟
    NSInteger minute = cmp.minute;
    //小时
    NSInteger hour = cmp.hour;
    
    //秒针旋转的度数
    CGFloat secAngle = angle2Rad(second * perSecA);
    
    //分钟旋转的度数
    CGFloat minuteAngle = angle2Rad(minute * perMinuteA);
    
    //时针旋转的度数
    CGFloat hourAngel = angle2Rad(hour * perHourA + minute * perMinuteHourA);
    
    //旋转秒针
    self.secondL.transform = CATransform3DMakeRotation(secAngle, 0, 0, 1);
    //旋转分针
    self.minuteL.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1);
    //旋转时针
    self.hourL.transform = CATransform3DMakeRotation(hourAngel, 0, 0, 1);
}




@end
