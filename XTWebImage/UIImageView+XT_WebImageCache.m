//
//  UIImageView+XT_WebImageCache.m
//  NSOperation异步加载网络图片
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImageView+XT_WebImageCache.h"
#import "AppImageCacheManager.h"

@implementation UIImageView (XT_WebImageCache)

- (void)xt_setImageWithURL:(NSURL *)imageURL
{
    [[AppImageCacheManager sharedManagerWithOnceToken] loadImageWithURL:imageURL completed:^(UIImage *completedImage) {
        
        self.image = completedImage;
    }];
}

@end
