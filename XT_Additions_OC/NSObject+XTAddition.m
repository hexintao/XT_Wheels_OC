//
//  NSObject+XTAddition.m
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSObject+XTAddition.h"

@implementation NSObject (XTAddition)

+ (instancetype)xt_objectWithDictionary:(NSDictionary *)dict
{
    id xt_object = [[self alloc]init];
    [xt_object setValuesForKeysWithDictionary:dict];
    return xt_object;
}

@end
