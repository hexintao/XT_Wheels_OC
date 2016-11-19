//
//  UIImageView+XT_WebImageCache.h
//  NSOperation异步加载网络图片
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XT_WebImageCache)
/**
 *  图片下载
 *
 *  @param imageURL       图片地址
 */
- (void)xt_setImageWithURL:(NSURL *)imageURL;
@end
