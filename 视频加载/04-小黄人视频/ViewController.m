//
//  ViewController.m
//  04-小黄人视频
//
//  Created by 杨卢青 on 15/12/27.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YLQVideo.h"

#define baseStr @"http://120.25.226.186:32812"
@interface ViewController ()
//视频信息
@property(nonatomic, strong)NSArray *videos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //替换关键字id
    [YLQVideo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                @"ID":@"id"
                };
    }];
    //解析路径传来的信息,  /video?type=JSON
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/video?type=JSON"]];
    //发送请求GET|异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //设置videos数据源
        NSArray *array = dict[@"videos"];
        self.videos = [YLQVideo mj_objectArrayWithKeyValuesArray:array];
        
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //拿到本cell数据
    YLQVideo *cellData = self.videos[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"播放时间:@%@", cellData.length];
    cell.textLabel.text = cellData.name;
    
//    NSString *imageStr = [baseStr stringByAppendingPathComponent:videoMode.image];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"Snip20151226_296"]];
//    
//    NSLog(@"%@",videoMode.ID);
//    //3.返回cell
//    return cell;
    NSString *imageStr = [baseStr stringByAppendingPathComponent:cellData.image];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"%@", cellData.ID);
    }];
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //先拿到该cell对应的数据
//    XMGVideo *videoMode = self.videos[indexPath.row];
//    NSURL *url = [NSURL URLWithString:[baseStr stringByAppendingPathComponent:videoMode.url]];
//    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
//    [self presentViewController:vc animated:YES completion:nil];
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //拿到cell对应的数据
    YLQVideo *cellData = self.videos[indexPath.row];
    NSURL *url = [NSURL URLWithString:[baseStr stringByAppendingPathComponent:cellData.url]];
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
