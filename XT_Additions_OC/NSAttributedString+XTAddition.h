//
//  NSAttributedString+XTAddition.h
//  支付宝练习
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (XTAddition)

/**
 *  快速创建一个图文混排的属性文本，默认图片在文字的前边
 *
 *  @param image   要显示的图片
 *  @param width   图片宽度
 *  @param height  图片高度
 *  @param title   要显示的文字
 *  @param size    文字大小
 *  @param color   文字颜色
 *  @param spacing 图片和文字之间的间距
 *
 *  @return 根据格式创建的属性文本
 */
+ (instancetype)xt_attributedStringWithImage:(UIImage *)image
                                  imageWidth:(CGFloat)width
                                 imageHeight:(CGFloat)height
                                       title:(NSString *)title
                                    fontSize:(CGFloat)size
                                       color:(UIColor *)color
                                     spacing:(CGFloat)spacing;

@end
