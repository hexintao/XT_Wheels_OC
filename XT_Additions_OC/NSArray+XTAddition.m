//
//  NSArray+XTAddition.m
//  支付宝练习
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSArray+XTAddition.h"
#import "NSObject+XTAddition.h"

@implementation NSArray (XTAddition)

+ (instancetype)xt_arrayWithPlistName:(NSString *)plistName modeClassName:(NSString *)modeClassName
{
    // 加载plist文件
    NSURL *plistURL = [[NSBundle mainBundle]URLForResource:plistName withExtension:@"plist"];
    // 读取plist的数据，并保存在数组中
    NSArray *dictArray = [NSArray arrayWithContentsOfURL:plistURL];
    NSMutableArray *tempMutableArray = [NSMutableArray arrayWithCapacity:dictArray.count];
    Class modelClass = NSClassFromString(modeClassName);
    NSAssert(modelClass, @"指定的modeClassName--%@错误！", modeClassName);
    for (NSDictionary *dict in dictArray)
    {
        [tempMutableArray addObject:[modelClass xt_objectWithDictionary:dict]];
    }
    return tempMutableArray.copy;
}

@end
