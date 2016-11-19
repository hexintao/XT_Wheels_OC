//
//  HXTPictureLoopViewController.m
//  图片轮播
//
//  Created by mac on 16/8/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HXTPictureLoopViewController.h"
#import "HXTPictureLoopView.h"

@interface HXTPictureLoopViewController ()

@end

@implementation HXTPictureLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for(NSInteger i = 0; i < 9; i++)
    {
        [tempArray addObject:[UIImage imageNamed:@(i).description]];
    }
    HXTPictureLoopView *pictureLoopView = [[HXTPictureLoopView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 500) image:tempArray.copy];
    [self.view addSubview:pictureLoopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
