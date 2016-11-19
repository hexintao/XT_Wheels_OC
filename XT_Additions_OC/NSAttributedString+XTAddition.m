//
//  NSAttributedString+XTAddition.m
//  支付宝练习
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSAttributedString+XTAddition.h"

@implementation NSAttributedString (XTAddition)
+ (instancetype)xt_attributedStringWithImage:(UIImage *)image imageWidth:(CGFloat)width imageHeight:(CGFloat)height title:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color spacing:(CGFloat)spacing
{
    NSDictionary *titleDict = @{NSFontAttributeName : [UIFont systemFontOfSize:size],
                                NSForegroundColorAttributeName : color};
    NSDictionary *spaceDict = @{NSFontAttributeName : [UIFont systemFontOfSize:spacing]};
    
    NSTextAttachment *imageAttach = [[NSTextAttachment alloc]init];
    imageAttach.image = image;
    imageAttach.bounds = CGRectMake(0, 0, width, height);
    NSAttributedString *imageAttrString = [NSAttributedString attributedStringWithAttachment:imageAttach];
    
    NSAttributedString *titleAttrString = [[NSAttributedString alloc]initWithString:title attributes:titleDict];
    // 为什么要用两个\n? 因为一个\n只代表回车，另起一行，两个\n才能在中间产生一个空行，进而控制行间距
    NSAttributedString *spaceAttrString = [[NSAttributedString alloc]initWithString:@"\n\n" attributes:spaceDict];
    
    NSMutableAttributedString *appendMAttrString = [[NSMutableAttributedString alloc]initWithAttributedString:imageAttrString];
    [appendMAttrString appendAttributedString:spaceAttrString];
    [appendMAttrString appendAttributedString:titleAttrString];
    
    return appendMAttrString.copy;
}
@end
