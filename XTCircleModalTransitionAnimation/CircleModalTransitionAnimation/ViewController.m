//
//  ViewController.m
//  CircleModalTransitionAnimation
//
//  Created by mac on 2016/11/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)modalTransitionStart:(UIButton *)sender {
    ModalViewController *modalVC = [ModalViewController new];
    [self presentViewController:modalVC animated:YES completion:nil];
}

@end
