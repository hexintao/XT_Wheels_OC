//
//  HXTPictureLoopView.h
//  图片轮播
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXTPictureLoopView : UIView

/**
 *  快速创建轮播图方法（默认距离父视图顶部20，高度200，宽度与当前屏幕一样）
 *
 *  @param imageArray 需要进行轮播的图片数组
 *
 *  @return 轮播视图
 */
+ (instancetype)pictureLoopViewWithImage:(NSArray *)imageArray;
/**
 *  创建轮播图
 *
 *  @param frame      轮播视图的大小和位置
 *  @param imageArray 需要进行轮播的图片数组
 *
 *  @return 轮播视图
 */
- (instancetype)initWithFrame:(CGRect)frame image:(NSArray *)imageArray;
/**
 *  循环显示的图片数组
 */
@property (strong,nonatomic) NSArray *pictureImageArray;
@end
