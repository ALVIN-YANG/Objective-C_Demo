//
//  lockView.m
//  05-手势解锁
//
//  Created by 杨卢青 on 15/12/11.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "lockView.h"

@interface lockView()

@property(nonatomic, strong)NSMutableArray *selectedBtn;

//当前点
@property (nonatomic, assign)CGPoint curP;

@end

@implementation lockView

- (NSMutableArray *)selectedBtn
{
    if (!_selectedBtn) {
        _selectedBtn = [NSMutableArray array];
    }
    return _selectedBtn;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    //实现九宫格
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //创建button同时编号
        btn.tag = i;
        
        //让按钮不能接受事件
        btn.userInteractionEnabled = NO;
        
        //设置图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        //把创建好的Button加入到view
        [self addSubview:btn];
    }
}

//获取当前手指所在的点
- (CGPoint)getCurrentPoint:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

/**
 *  判断一个点在不在按钮上,  如果在按钮上,返回当前按钮,否则返回nil
 */
- (UIButton *)btnRectContainsPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

//手指点击时让按钮成选中状态 (第一个加入的按钮,添加到数组)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint curP = [self getCurrentPoint:touches];
    
    //把符合条件的按钮选出
    UIButton *btn = [self btnRectContainsPoint:curP];
    
    if (btn && btn.selected == NO) {
        //被选中,并且之前没被选中
        btn.selected = YES;
        //选中的btn添加到数组
        [self.selectedBtn addObject:btn];
    }
}
//手指移动时,按钮选中,连线到当前的按钮
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint curP = [self getCurrentPoint:touches];
    //判断当前手指所在的点在不在按钮上
    UIButton *btn = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedBtn addObject:btn];
    }
    //加入新的按钮就要重绘
    [self setNeedsDisplay];
    //记录当前移动的点
    self.curP = curP;
}

//手指松开是,按钮取消选中状态,清空所有连线
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //取消所有选中的按钮,查看选中按钮的顺序
    NSMutableString *str = [NSMutableString string];
    for (UIButton *btn in self.selectedBtn) {
        [str appendFormat:@"%ld", btn.tag];
        //遍历所有被选中的按钮,把其设为不被选中
        btn.selected = NO;
    }
    //并且清空所有按钮数组
    [self.selectedBtn removeAllObjects];
    //重绘后就会清空
    [self setNeedsDisplay];
    
    NSLog(@"选中按钮顺序为:%@",str);
}



//布局子控件, 就是设置Button的frame
- (void)layoutSubviews
{
    //一定不要忘了
    [super layoutSubviews];
    
    //画九宫格
    int cloumn = 3;
    CGFloat btnWH = 74;
    CGFloat margin = (self.bounds.size.width - cloumn * btnWH)/(cloumn + 1);
    //当前列
    int curCloumn = 0;
    int curRow = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    //取出所有控件
    for (int i = 0; i < self.subviews.count; i++) {
        curCloumn = i % cloumn;
        curRow = i / cloumn;
        x = margin + curCloumn * (margin +btnWH);
        y = (margin + btnWH) * curRow;
        //设置Button的frame
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    }
}

//绘
- (void)drawRect:(CGRect)rect
{
    //如果都没选中就不画了
    if (self.selectedBtn.count <= 0)
        return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    /**
     *  取出所有选中的按钮连线
     */
    for (int i = 0; i < self.selectedBtn.count; i++) {
        UIButton *btn = self.selectedBtn[i];
        
        //画线,先判断是否是第一个
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else{
            //其他的就继续画线
            [path addLineToPoint:btn.center];
        }
    }
    //还要有最后一个按钮和当前手指的线,move的时候记录的点
    [path addLineToPoint:self.curP];
    
    //设置颜色
    [[UIColor redColor]set];
    
    [path setLineWidth:10];
    
    //设置连接方式, joinStyle  kCGround
    [path setLineJoinStyle:kCGLineJoinRound];
    
    //戳
    [path stroke];
}
@end















