//
//  ModalViewController.m
//  CircleModalTransitionAnimation
//
//  Created by mac on 2016/11/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ModalViewController.h"
#import "ModalTransitionAnimator.h"

@interface ModalViewController ()

@end

@implementation ModalViewController {
    ModalTransitionAnimator *_transitionAnimator;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        // 设置转场代理
        _transitionAnimator = [ModalTransitionAnimator new];
        self.transitioningDelegate = _transitionAnimator;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
