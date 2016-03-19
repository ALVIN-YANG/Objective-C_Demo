//
//  YLQPersionDetailViewController.m
//  02-微博
//
//  Created by 杨卢青 on 15/12/6.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "YLQPersionDetailViewController.h"
#import "UIImage+Image.h"

#define YLQHeaderH 200
#define YLQTarBarH 44
#define YLQMinH 64

@interface YLQPersionDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
//头部背景VIew的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//导航控制器title
@property (nonatomic, weak) UILabel *titleL;
//tableView的初始偏移量
@property (nonatomic, assign) CGFloat oriOffsetY;

@end

@implementation YLQPersionDetailViewController

//cell标识
static NSString *ID = @"CELLID";
- (void)viewDidLoad {
    [super viewDidLoad];
    //纯代码创建cell, UITableView class
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //ios7之后,只要是导航控制器下的所有UIScrollView顶部都会添加额外的滚动区域.
    //设置当前控制器不要调整ScrollView的contentInsets
    //取消自动添加的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.alpha = 0;
    //设置导航条隐藏, 因为导航条有子控件view
    //用setBackgroundImage传入一张空图片就可以
    //模式必须是UIBarMetricsDefault(公共默认)
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //隐藏完后,还有根线,是导航条的阴影,直接清空
    //setShadowImage
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //----------------------------------------
    //设置tableView的代理和数据源
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //设置tableView初始偏移量,偏移量都是负值(大图片加小头条)
    self.oriOffsetY = - (YLQHeaderH + YLQTarBarH);
    //只要设置额外的滚动区域,就会把内容往下挤
    self.tableView.contentInset = UIEdgeInsetsMake(YLQHeaderH+YLQTarBarH, 0, 0, 0);
    //设置导航条title, 由于导航条的空间不能直接设置为透明
    //所以用colorWithWhite方法来设置字体的 透明度
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor colorWithWhite:0 alpha:0];
    titleL.text = @"AmChocolate";
    //大小自适应(必须设置,因为导航条里的控件若不设置大小不会被显示)
    [titleL sizeToFit];
    self.titleL = titleL;
    self.navigationItem.titleView = titleL;
    
}


//tableView继承自ScrollView,当ScrollView滚动时就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //原来的位置 减去(逻辑就是加上滚动值)  偏移量    就是现在的偏移量
    //scrollView.contentOffset.y也是负值,不动时offSetY是0
    CGFloat offSetY = scrollView.contentOffset.y - self.oriOffsetY;
    //位置
    //由于偏移量是正值时  高度要缩小 , 成反比 , 所以要拿原来的值减去偏移量
    //原本逻辑上的view高度与偏移量成正比,但系统的偏移量是负值,所以成反比
    CGFloat h = YLQHeaderH - offSetY;
    //因要保留动画效果,所以不能直接使用长度约束, 而且不能缩到导航条里面
    if (h < 64) {
        h = 64;
    }
    //设置view高度约束值
    self.headerHeightConts.constant = h;
    //-------------------------处理导航条透明度------------------------------
    //当前的透明度,越向上透明度越大(越向上,偏移量数值越大,是正值,不动的时候是0)
    CGFloat alpha = offSetY / (YLQHeaderH - YLQTarBarH);
    //让透明度保持一,否则系统就把它变成半透明
    if (alpha > 1) {
        alpha = 0.99;
    }
    //设置标题和导航条的透明度
    self.titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
        //给导航条创建颜色
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:alpha];
    //设置导航条背景图片,依旧是公共默认模式
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = @"adsf";
    
    return cell;
}

@end
