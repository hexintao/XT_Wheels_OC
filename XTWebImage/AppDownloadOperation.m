//
//  AppDownloadOperation.m
//  NSOperation异步加载网络图片
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDownloadOperation.h"

@interface AppDownloadOperation ()
/// 图片链接
@property (strong,nonatomic) NSURL *imageURL;
@property (copy,nonatomic) void (^completedBlock)(UIImage *);
@end
@implementation AppDownloadOperation

+ (instancetype)downloadImageWithURL:(NSURL *)imageURL completionBlock:(void (^)(UIImage *completedImage))completionBlock
{
    AppDownloadOperation *downloadOperation = [[self alloc]init];
    downloadOperation.imageURL = imageURL;
    downloadOperation.completedBlock = completionBlock;
    return downloadOperation;
}

- (void)main
{
    NSLog(@"开始下载网络图片 %@", [NSThread currentThread]);
    
    [NSThread sleepForTimeInterval:10.0];
    
    // 下载二进制数据
    NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
    
    // 转换成image
    UIImage *completedImage = [UIImage imageWithData:imageData];
    
    NSLog(@"下载图片完成");
    
    if (completedImage && self.completedBlock) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 成功下载图片之后回主线程进行回调
            self.completedBlock(completedImage);
        }];
        
        // 将下载好的图片缓存至沙盒
        NSString *imageString = [self diskCachePathWithImageURL:self.imageURL];
        [imageData writeToFile:imageString atomically:YES];
    }
}

- (NSString *)diskCachePathWithImageURL:(NSURL *)imageURL
{
    NSString *cachesDirectoryString = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *diskCacheImagePath = [cachesDirectoryString stringByAppendingPathComponent:@"/appIconCaches"];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:diskCacheImagePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:diskCacheImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [diskCacheImagePath stringByAppendingPathComponent:imageURL.absoluteString.lastPathComponent];
}

- (void)dealloc
{
    NSLog(@"operation释放啦");
}

@end
