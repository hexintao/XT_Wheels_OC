//
//  UILabel+XTAddition.m
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UILabel+XTAddition.h"

@implementation UILabel (XTAddition)
+ (instancetype)xt_labelWithText:(NSString *)text fontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    return label;
}
@end
