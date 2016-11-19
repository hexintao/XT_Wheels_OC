//
//  UIColor+XTAddition.h
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XTAddition)
/**
 *  根据16进制形式创建UIColor，示例0x1ED282。
 *
 *  @param hexColor 32位16进制无符号整数，ox开头
 *
 *  @return UIColor类型的颜色
 */
+ (instancetype)xt_colorWithHex:(uint32_t)hexColor;

/**
 *  随机产生一种颜色
 *
 *  @return 随机的一种UIColor颜色
 */
+ (instancetype)xt_colorWithRandom;

/**
 *  使用R-G-B的形式创建不透明的颜色
 *
 *  @param red   红色的数值
 *  @param green 绿色的数值
 *  @param blue  蓝色的数值
 *
 *  @return 根据所给数值产生的UIColor颜色
 */
+ (instancetype)xt_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;
@end
