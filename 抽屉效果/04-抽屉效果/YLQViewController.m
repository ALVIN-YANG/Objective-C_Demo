//
//  YLQViewController.m
//  04-抽屉效果
//
//  Created by 杨卢青 on 15/12/7.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "YLQViewController.h"
#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height
@interface YLQViewController ()

@property (nonatomic, weak) UIView *mainV;

@property (nonatomic, weak) UIView *rightV;

@end

@implementation YLQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //搭建界面
    [self setUpView];
    
    //给mainV添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
    
    //给控制器的View添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

//实现手势方法
//实现点按方法
- (void)tap{
    //让主view的尺寸和控制器的一样
    [UIView animateWithDuration:0.25 animations:^{
        self.mainV.frame = self.view.bounds;
    }];
}

#define targetR 275
#define targetL -275
//拖动手势方法
- (void)pan:(UIPanGestureRecognizer *)pan
{
    //获取View在屏幕上的偏移量, 此方法兼容其他手势
    CGPoint transP = [pan translationInView:self.mainV];
    
    //计算主view的fram
    self.mainV.frame = [self frameWithOffSetX:transP.x];
    
    //判断当前MainV的x值是大于0还是小于0,位置相关
    if (self.mainV.frame.origin.x > 0) {
        self.rightV.hidden = YES;
    }else if(self.mainV.frame.origin.x < 0){
        self.rightV.hidden = NO;
    }
    
    //判断手指状态
    //手指松开
    if(pan.state == UIGestureRecognizerStateEnded)
    {
        CGFloat target = 0;
        //当手指松开,要判断MainV的x值是否大于屏幕的一半,不到一半自动定位
        if (self.mainV.frame.origin.x > screenW * 0.5)
        {
            target = targetR;
        }else if(CGRectGetMaxX(self.mainV.frame) < screenW * 0.5){
            target = targetL;
        }
        CGFloat offSetX = target - self.mainV.frame.origin.x;
        CGRect frame = [self frameWithOffSetX:offSetX];
        [UIView animateWithDuration:0.25 animations:^{
            self.mainV.frame = frame;
        }];
    }
    //复位
    [pan setTranslation:CGPointZero inView:self.mainV];
}


//------------根据偏移量计算mainV的fram方法
#define maxY 100
- (CGRect)frameWithOffSetX:(CGFloat)offSetX
{
    //取出最原始的Frame
    CGRect frame = self.mainV.frame;
    frame.origin.x += offSetX;
    //y值要对结果取绝对值
    frame.origin.y = fabs(frame.origin.x * maxY / screenW);
    //计算frame的高度
    frame.size.height = screenH - 2 * frame.origin.y;
    
    return frame;
}

- (void)setUpView {
    //左边的View,最下面一层
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:leftV];
    //右边的View,中间层
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor greenColor];
    self.rightV = rightV;
    [self.view addSubview:rightV];
    
    //添加主view,最上层
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [ UIColor redColor];
    self.mainV = mainV;
    [self.view addSubview:mainV];
}

@end
