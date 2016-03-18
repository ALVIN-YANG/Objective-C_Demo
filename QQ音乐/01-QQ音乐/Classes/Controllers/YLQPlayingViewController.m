//
//  YLQPlayingViewController.m
//  01-QQ音乐
//
//  Created by 杨卢青 on 16/1/8.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "YLQPlayingViewController.h"
#import "Masonry.h"
#import "YLQMusicTool.h"
#import "YLQAudioTool.h"
#import "YLQMusic.h"
#import "NSString+TimeExtension.h"
#import "CALayer+PauseAimate.h"
#import "YLQLrcView.h"
#import "YLQLrcLabel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface YLQPlayingViewController ()<UIScrollViewDelegate>
//底部图片
@property (weak, nonatomic) IBOutlet UIImageView *albumVIew;
//进度条
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
//歌手图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//歌手名
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
//歌曲名
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
//主界面歌词label
@property (weak, nonatomic) IBOutlet YLQLrcLabel *lineLabel;
//当前时间
@property (weak, nonatomic) IBOutlet UILabel *curTimeLabel;
//总时间
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
//当前播放器
@property (nonatomic, strong)AVAudioPlayer *currentPlayer;
//进度条定时器
@property (nonatomic, strong)NSTimer *progressTimer;
//播放暂停按钮
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
//歌词的View
@property (weak, nonatomic) IBOutlet YLQLrcView *lrcView;
/** 歌词的定时器 */
@property (nonatomic ,strong)CADisplayLink *lrcTimer;


#define YLQColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@end

@implementation YLQPlayingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //毛玻璃效果
    [self setupBlur];
    //进度条滑块图片
    [self.progressSlider setThumbImage:
        [UIImage imageNamed:@"player_slider_playback_thumb"]
          forState:UIControlStateNormal];
    //播放音乐
    [self playingMusic];
    

    
    //设置歌词View的ContentSize
    self.lrcView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.lrcView.delegate = self;
}
#pragma mark - 播放音乐
- (void)playingMusic{
    //1.取出当前默认的音乐
    YLQMusic *playingMusic = [YLQMusicTool playingMusic];
    //2.更新界面信息
    self.albumVIew.image = [UIImage imageNamed:playingMusic.icon];
    self.iconView.image = [UIImage imageNamed:playingMusic.icon];
    self.singerLabel.text = playingMusic.singer;
    self.songLabel.text = playingMusic.name;
    //3.开始播放音乐
        //3.1播放
    AVAudioPlayer *currentPlayer = [YLQAudioTool playMusicWithMusicName:playingMusic.filename];
    self.currentPlayer = currentPlayer;
    //3.2设置当前时间和播放总时间,
    self.curTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.totalTimeLabel.text = [NSString stringWithTime:currentPlayer.duration];
    //3.3设置播放状态
    self.playPauseBtn.selected = currentPlayer.isPlaying;
    
    //3.4设置歌词
    self.lrcView.lrcName = playingMusic.lrcname;
    //4.添加旋转动画
    [self addIconViewAnimate];
    
    //5.添加定时器
    [self removeProgressTimer];
    [self addProgressTimer];
    [self removeLrcTimer];
    [self addLrcTimer];
    
    //6.设置锁屏界面
    [self setupLockScreenInfo];
}

#pragma mark - 旋转动画
- (void)addIconViewAnimate{
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = @(0);
    rotate.toValue = @(M_PI * 2);
    rotate.repeatCount = NSIntegerMax;
    rotate.duration = 35;
    rotate.removedOnCompletion = NO;
    [self.iconView.layer addAnimation:rotate forKey:nil];
}

#pragma mark - 定时器方法
- (void)removeProgressTimer{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
- (void)addProgressTimer{
    //1.更新进度条信息
    [self updateProgressInfo];
    //2.添加定时器
    self.progressTimer = [NSTimer
                          scheduledTimerWithTimeInterval:1.0 target:self                  selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer
                              forMode:NSRunLoopCommonModes];
}
//更新进度条信息方法
- (void)updateProgressInfo{
    //1.更新当前播放的时间
    self.curTimeLabel.text = [NSString stringWithTime:self.currentPlayer.currentTime];
    //2.更新滑块位置
    self.progressSlider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
}

#pragma mark - 歌词定时器
- (void)addLrcTimer{
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcInfo)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeLrcTimer{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

#pragma mark - 更新歌词显示
- (void)updateLrcInfo{
    self.lrcView.currentTime = self.currentPlayer.currentTime;
}

#pragma mark - 拖动slider方法
- (IBAction)sliderTap:(UITapGestureRecognizer *)sender {
    //1.获取点击到的点
    CGPoint point = [sender locationInView:sender.view];
    //2.通过点击获取点击到的比例
    CGFloat ratio = point.x / self.progressSlider.bounds.size.width;
    //3.更新播放时间
    self.currentPlayer.currentTime = ratio * self.currentPlayer.duration;
    //4.更新progress
    [self updateProgressInfo];
}
- (IBAction)progressStar {
    //移除定时器
    [self removeProgressTimer];
}

- (IBAction)progressEnd {
    //更新播放时间
    self.currentPlayer.currentTime = self.progressSlider.value * self.currentPlayer.duration;
    //添加定时器
    [self addProgressTimer];
}

- (IBAction)progressValueChanged {
    //更新显示的时间
    self.curTimeLabel.text = [NSString stringWithTime:self.progressSlider.value * self.currentPlayer.duration];
}



#pragma mark - 毛玻璃效果
- (void)setupBlur{
    //初始化UItoolBar
    UIToolbar *tool = [[UIToolbar alloc] init];
    [self.albumVIew addSubview:tool];
    tool.barStyle = UIBarStyleBlack;
    
    //添加ToolBar约束, 用Masonry框架
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.albumVIew);
    }];
}

#pragma mark - viewWillLayOut
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //设置图片圆角
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 8.0;
    self.iconView.layer.borderColor = YLQColor(36, 36, 36).CGColor;
    
}

#pragma mark - 播放事件
- (IBAction)playOrPause:(id)sender{
    self.playPauseBtn.selected = !self.playPauseBtn.selected;
    if (self.currentPlayer.isPlaying) {
        //1.如果正在播放,那么暂停播放
        [self.currentPlayer pause];
        //2.移除定时器
        [self removeProgressTimer];
        //3.暂停动画
        [self.iconView.layer pauseAnimate];
    }else{
        //开始播放
        [self.currentPlayer play];
        //添加定时器
        [self addProgressTimer];
        //恢复动画
        [self.iconView.layer resumeAnimate];
    }
}
- (IBAction)next:(id)sender {
    //取出下一首歌曲
    YLQMusic *nextMusic = [YLQMusicTool next];
    //播放下一首
    [self playMusic:nextMusic];
}
- (IBAction)previous:(id)sender{
    YLQMusic *previousMusic = [YLQMusicTool previous];
    [self playMusic:previousMusic];
}

//播放歌曲方法
- (void)playMusic:(YLQMusic *)music{
    YLQMusic *playingMusic = [YLQMusicTool playingMusic];
    [YLQAudioTool stopMusicWithMusicName:playingMusic.filename];
    //设置为默认播放的歌曲
    [YLQMusicTool setupMusic:music];
    [self playingMusic];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1.获取滑动偏移量
    CGPoint point = scrollView.contentOffset;
    //2.通过偏移量来获取滑动的比例
    CGFloat ratio = (1 - point.x / scrollView.bounds.size.width);
    //3.设置图片,主界面歌词的alpha
    self.iconView.alpha = ratio;
    self.lineLabel.alpha = ratio;
}

#pragma mark - 状态栏文字颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 锁屏界面
- (void)setupLockScreenInfo{

    // 0.获取当前正在播放的音乐
    YLQMusic *playingMusic = [YLQMusicTool playingMusic];
    
    // 1.获取锁屏中心
    MPNowPlayingInfoCenter *playingInfoCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    // 2.设置展示的信息
    NSMutableDictionary *playingInfoDict = [NSMutableDictionary dictionary];
    // 2.1展示歌曲名
    [playingInfoDict setObject:playingMusic.name forKey:MPMediaItemPropertyAlbumTitle];
    // 2.2展示歌手名
    [playingInfoDict setObject:playingMusic.singer forKey:MPMediaItemPropertyArtist];
    // 2.3展示封面
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:playingMusic.icon]];
    [playingInfoDict setObject:artWork forKey:MPMediaItemPropertyArtwork];
    // 2.4设置播放的总时间
    [playingInfoDict setObject:@(self.currentPlayer.duration) forKey:MPMediaItemPropertyPlaybackDuration];
    // 2.5设置当前播放的时间
    [playingInfoDict setObject:@(self.currentPlayer.currentTime) forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    playingInfoCenter.nowPlayingInfo = playingInfoDict;
    
    // 3.让应用程序开启远程事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}
@end
