//
//  ViewController.m
//  01-网易新闻
//
//  Created by 杨卢青 on 16/1/14.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"

#define YLQColor(r , g ,b) [UIColor colorWithRed:(r)  green:(g)  blue:(b) alpha:1]
#define YLQScreenW [UIScreen mainScreen].bounds.size.width
#define YLQScreenH [UIScreen mainScreen].bounds.size.height

/*
    1.搭建界面 2.处理界面细节 3.处理界面业务逻辑(点击事件)
 */

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
/** 上一次按钮 */
@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic, strong) NSMutableArray *titleButtons;


@property (nonatomic, assign) BOOL isInitial;

@end

@implementation ViewController

- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

// 3.怎么知道有多少标题?由多少个子控制器决定
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.搭建标题滚动视图
    [self setupTitleScrollView];
    
    // 2.搭建内容滚动视图
    [self setupContentScrollView];
   
    
    // 取消添加额外滚动区域
    // 在scrollView,忽然发现内容放下走,就是顶部额外滚动区域做
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 5.监听滚动完成
    self.contentScrollView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 4.设置标题
    if (!_isInitial) {
        
        [self setupAllTitle];
        
        _isInitial = YES;
    }
    
}

#pragma mark - 搭建标题滚动视图
- (void)setupTitleScrollView
{
    // 创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat y = self.navigationController.navigationBarHidden? 20 : 64;
    CGFloat h = 44;
    CGFloat w = YLQScreenW;
    scrollView.frame = CGRectMake(0, y, w, h);
    [self.view addSubview:scrollView];
    _titleScrollView = scrollView;
}

#pragma mark - 搭建内容滚动视图
- (void)setupContentScrollView
{
    // 创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat y = CGRectGetMaxY(_titleScrollView.frame);
    CGFloat h = YLQScreenH - y;
    CGFloat w = YLQScreenW;
    scrollView.frame = CGRectMake(0, y, w, h);
    [self.view addSubview:scrollView];
    _contentScrollView = scrollView;

}


#pragma mark -设置标题
- (void)setupAllTitle
{
    // 添加所有标题
    NSUInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = self.titleScrollView.bounds.size.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        x = i * w;
        UIViewController *vc = self.childViewControllers[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0) { // 默认点击第0个按钮
            [self titleClick:btn];
        }
        
        // 添加到标题按钮数组
        [self.titleButtons addObject:btn];
        
    }
    
    // 设置标题滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * YLQScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    /*
        问题:1.按钮文字为黑色 2.标题滚动视图可以滚动
     */
}

#pragma mark -点击标题就会调用
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    // 1.选中按钮
    [self selectBtn:button];
    
    // 2.需要把对应子控制器的view添加上去
    [self setupOneViewControllerView:i];
    
    // 3.设置内容滚动视图偏移量
    // 计算偏移量
    CGFloat offsetX = i * YLQScreenW;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
}

#pragma mark -选中按钮
- (void)selectBtn:(UIButton *)selectBtn
{
    // 设置按钮颜色
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    // 让标题居中
    [self setupTitleButtonCenter:selectBtn];
    
    // 标题缩放
    _selectButton.transform = CGAffineTransformIdentity;
    selectBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    _selectButton = selectBtn;
}

// 让标题居中
- (void)setupTitleButtonCenter:(UIButton *)button
{
    // 修改偏移量
    CGFloat offsetX = button.center.x - YLQScreenW * 0.5;
    
    // 处理最小滚动偏移量
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 处理最大滚动偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - YLQScreenW;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

// 添加一个子控制器的view
- (void)setupOneViewControllerView:(NSInteger)i
{
    // 2.0 获取子控制器x
    CGFloat x = i * YLQScreenW;

    // 2.1 获取子控制器
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) return;
    vc.view.frame = CGRectMake(x, 0, YLQScreenW, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    
}
#pragma mark -UIScrollViewDelegate
// 减速完成就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取角标
    NSInteger i = scrollView.contentOffset.x / YLQScreenW;
    
    // 获取对应标题按钮
    UIButton *selButton = self.titleButtons[i];
    
    // 选中标题
    [self selectBtn:selButton];
    
    // 添加对应子控制器的view
    [self setupOneViewControllerView:i];
}

// 只要滚动 就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 让按钮形变
    NSInteger leftI = scrollView.contentOffset.x / YLQScreenW;
    
    NSInteger rightI = leftI + 1;
    
    // 1.获取需要形变的按钮
    
    // left
    // 获取左边按钮
    UIButton *leftButton = self.titleButtons[leftI];
    
    // right
    NSUInteger count = self.childViewControllers.count;
    UIButton *rigthButton;
    // 获取右边按钮
    if (rightI < count) {
        rigthButton = self.titleButtons[rightI];
    }
    
    // 计算右边按钮偏移量
    CGFloat rightScale = scrollView.contentOffset.x / YLQScreenW;
    
    // 只想要 0~1
    rightScale = rightScale - leftI;
    
    
    CGFloat leftScale = 1 - rightScale;
    
    // 形变按钮
    // scale 0 ~ 1 => 1 ~ 1.3
    leftButton.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3 + 1);
    rigthButton.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3 + 1);
    
    // 颜色渐变 黑色 -> 红色
    [rigthButton setTitleColor:YLQColor(rightScale, 0, 0) forState:UIControlStateNormal];
    [leftButton setTitleColor:YLQColor(leftScale, 0, 0) forState:UIControlStateNormal];
}

/*
      R G B
 黑色  0 0 0
 红色  1 0 0
 白色  1 1 1
 */

@end
