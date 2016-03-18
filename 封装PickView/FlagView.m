//
//  FlagView.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "FlagView.h"
#import "FlagItem.h"
@interface FlagView ()
@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@end

@implementation FlagView

+(instancetype)flagView
{
   return [[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil][0];;
}

-(void)setItem:(FlagItem *)item
{
    _item = item;
    self.flagImage.image = [UIImage imageNamed:item.icon];
    self.countryLabel.text = item.name;
}

@end
