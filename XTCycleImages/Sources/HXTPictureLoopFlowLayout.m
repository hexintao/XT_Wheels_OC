//
//  HXTPictureLoopFlowLayout.m
//  图片轮播
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HXTPictureLoopFlowLayout.h"

@implementation HXTPictureLoopFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    // item大小
    self.itemSize = self.collectionView.frame.size;
    
    // 最小间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

@end
