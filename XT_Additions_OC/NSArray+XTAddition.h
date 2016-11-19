//
//  NSArray+XTAddition.h
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (XTAddition)
/**
 *  简易的字典转模型。不适用与嵌套的类型!
 *
 *  @param plistName     需要转模型的plist数据文件名称（省略.plist后缀名字）
 *  @param modeClassName 数据模型类的名称
 *
 *  @return 包含数据模型的不可变数组
 */
+ (instancetype)xt_arrayWithPlistName:(NSString *)plistName modeClassName:(NSString *)modeClassName;
@end
