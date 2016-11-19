//
//  AppImageCacheManager.h
//  NSOperation异步加载网络图片
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppImageCacheManager : NSObject
+ (instancetype)sharedManagerWithInitialize;
+ (instancetype)sharedManagerWithOnceToken;

- (void)loadImageWithURL:(NSURL *)imageURL completed:(void (^)(UIImage *completedImage))completedBlock;
@end
