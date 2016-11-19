//
//  AppDownloadOperation.h
//  NSOperation异步加载网络图片
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDownloadOperation : NSOperation

+ (instancetype)downloadImageWithURL:(NSURL *)imageURL
             completionBlock:(void (^)(UIImage *completedImage))completionBlock;

// 根据传入图片地址，返回当前沙盒中的图片缓存路径
- (NSString *)diskCachePathWithImageURL:(NSURL *)imageURL;
@end
