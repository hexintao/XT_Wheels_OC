//
//  UILabel+XTAddition.h
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XTAddition)
/**
 *  快速创建一个UILabel
 *
 *  @param text  显示的文字
 *  @param size  显示文字的大小
 *  @param color 显示文字的颜色
 *
 *  @return 根据传入的参数生成的UILabel对象
 */
+ (instancetype)xt_labelWithText:(NSString *)text fontSize:(CGFloat)size textColor:(UIColor *)color;
@end
