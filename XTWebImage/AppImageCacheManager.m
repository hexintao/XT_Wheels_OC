//
//  AppImageCacheManager.m
//  NSOperation异步加载网络图片
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppImageCacheManager.h"
#import "AppDownloadOperation.h"

@interface AppImageCacheManager ()
/// 图片内存缓存
@property (strong,nonatomic) NSCache *memoryImagesCache;
/// 下载任务缓存
@property (strong,nonatomic) NSCache *downloadOperationsCache;
/// 下载图片队列
@property (strong,nonatomic) NSOperationQueue *downloadQueue;
@end
@implementation AppImageCacheManager
#pragma mark - initialize
/// 通过初始化类的方法初始化单例对象，饿汉式
static id sharedInstance;
+ (void)initialize
{
    if (self == [AppImageCacheManager self]) {
        sharedInstance = [[AppImageCacheManager alloc]init];
    }
}

+ (instancetype)sharedManagerWithInitialize
{
    return sharedInstance;
}

/// 通过dispatch_once方法初始化单例对象，懒汉式
+ (instancetype)sharedManagerWithOnceToken
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)loadImageWithURL:(NSURL *)imageURL completed:(void (^)(UIImage *))completedBlock
{
    [self loadCacheImageWithURL:imageURL success:^(UIImage *cacheImage, BOOL isExist) {
        
        NSLog(@"传入前的block在%@", completedBlock);
        void (^block)(UIImage *) = [completedBlock copy];
        NSLog(@"传入后的block在%@", block);
        
        if (isExist) {
            block(cacheImage);
            return;
        }
        else
        {
            // 判断下载任务是否已经存在
            AppDownloadOperation *operation = [self.downloadOperationsCache objectForKey:imageURL];
            if (operation) {
                NSLog(@"任务已经存在");
                return;
            }
            
            AppDownloadOperation *downloadOperation = [AppDownloadOperation downloadImageWithURL:imageURL completionBlock:^(UIImage *completedImage) {
                
                // 下载图片成功之后的回调
                block(completedImage);
                
                // 将图片放入内存缓存
                [self.memoryImagesCache setObject:completedImage forKey:imageURL];
            }];
            
            // 任务添加到队列
            [self.downloadQueue addOperation:downloadOperation];
            
            // 任务添加到缓存
            [self.downloadOperationsCache setObject:downloadOperation forKey:imageURL];
        }
    }];
}

- (void)loadCacheImageWithURL:(NSURL *)imageURL success:(void (^)(UIImage *cacheImage, BOOL isExist))successBlock
{
    // 查看内存是否有缓存
    UIImage *memoryImage = [self.memoryImagesCache objectForKey:imageURL];
    
    if (memoryImage && successBlock)
    {
        NSLog(@"从内存中进行加载");
        successBlock(memoryImage, YES);
        return;
    }
    else
    {
        // 查看本地磁盘是否有缓存
        AppDownloadOperation *downloadOperation = [[AppDownloadOperation alloc]init];
        UIImage *diskImage = [UIImage imageWithContentsOfFile:[downloadOperation diskCachePathWithImageURL:imageURL]];
        
        if (diskImage && successBlock)
        {
            NSLog(@"从硬盘加载图片");
            successBlock(diskImage, YES);
            // 将图片放入内存进行缓存
            [self.memoryImagesCache setObject:diskImage forKey:imageURL];
            return;
        }
            successBlock(nil, NO);
    }
}

#pragma mark - setters & getters
- (NSCache *)memoryImagesCache
{
    if (_memoryImagesCache == nil) {
        _memoryImagesCache = [[NSCache alloc]init];
    }
    return _memoryImagesCache;
}

- (NSCache *)downloadOperationsCache
{
    if (_downloadOperationsCache == nil) {
        _downloadOperationsCache = [[NSCache alloc]init];
    }
    return _downloadOperationsCache;
}

- (NSOperationQueue *)downloadQueue
{
    if (_downloadQueue == nil) {
        _downloadQueue = [[NSOperationQueue alloc]init];
    }
    return _downloadQueue;
}

@end
