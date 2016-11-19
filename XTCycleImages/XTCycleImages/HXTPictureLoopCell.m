//
//  HXTPictureLoopCell.m
//  图片轮播
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HXTPictureLoopCell.h"

@interface HXTPictureLoopCell ()
{
    UIImageView *_backgroundImageView;
    UILabel     *_indexLabel;
}
@end
@implementation HXTPictureLoopCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    // 创建并添加背景图片
    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    UILabel *indexLabel = [[UILabel alloc]init];
    indexLabel.font = [UIFont systemFontOfSize:30];
    indexLabel.backgroundColor = [UIColor lightGrayColor];
    _indexLabel = indexLabel;
    _backgroundImageView = backgroundImageView;
    [self.contentView addSubview:backgroundImageView];
//    [self.contentView addSubview:indexLabel];
    
    // 禁用autoResizing
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    indexLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 添加约束
    NSLayoutConstraint *backgroundImageTop = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *backgroundImageLeft = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *backgroundImageRight = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *backgroundImageBottom = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    /*
    NSLayoutConstraint *indexLabelCenterX = [NSLayoutConstraint constraintWithItem:indexLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *indexLabelBottom = [NSLayoutConstraint constraintWithItem:indexLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
     */
    
    [self.contentView addConstraints:@[backgroundImageTop,backgroundImageLeft,backgroundImageRight,backgroundImageBottom]];
}

- (void)setPictureImage:(UIImage *)pictureImage
{
    _pictureImage = pictureImage;
//    CGFloat imageWidth = pictureImage.size.width;
//    CGFloat iamgeHeight = pictureImage.size.height;
    _backgroundImageView.image = pictureImage;
}


@end
