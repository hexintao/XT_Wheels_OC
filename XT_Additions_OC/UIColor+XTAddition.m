//
//  UIColor+XTAddition.m
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIColor+XTAddition.h"

@implementation UIColor (XTAddition)

+ (instancetype)xt_colorWithHex:(uint32_t)hexColor
{
    uint8_t red = (hexColor & 0xFF0000) >> 16;
    uint8_t green = (hexColor & 0x00FF00) >> 8;
    uint8_t blue = hexColor & 0x0000FF;
    
    return [UIColor xt_colorWithRed:red green:green blue:blue];
}

+ (instancetype)xt_colorWithRandom
{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

+ (instancetype)xt_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

@end
