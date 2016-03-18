//
//  ImageCollectionViewCell.m
//  01-CollectionView
//
//  Created by 杨卢青 on 16/1/15.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ImageCollectionViewCell

- (void)awakeFromNib {

}
- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

@end
