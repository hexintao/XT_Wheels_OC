//
//  ModalTransitionAnimator.m
//  CircleModalTransitionAnimation
//
//  Created by mac on 2016/11/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ModalTransitionAnimator.h"

@interface ModalTransitionAnimator() <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@end

@implementation ModalTransitionAnimator {
    BOOL _isPresented;
    id <UIViewControllerContextTransitioning> _transitionContext;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 1. 获取容器视图
    UIView *containerVieww = [transitionContext containerView];
    
    // 2. 获取源视图和目标视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    NSLog(@"%@ -> %@", fromView.subviews, toView.subviews);
    
    // 2.1 判断是modal展现还是modal消失
    UIView *animatedView;
    if (_isPresented) {
        // 3. 添加视图
        [containerVieww addSubview:toView];
        animatedView = toView;
    } else {
        animatedView = fromView;
    }
    NSLog(@"%@", animatedView.subviews);
    
    // 4. 添加动画效果
    [self animateWithView:animatedView];
    
    // 5. 转场结束(挪到了动画结束的代理方法中)。一定要有！否则，系统会认为转场一直没有结束，导致无法监听用户事件
    _transitionContext = transitionContext;
//    [transitionContext completeTransition:YES];
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateWithView: (UIView *)view {
    // 1. 创建图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    // 2. 设置参数
    CGFloat diameter = 50;
    CGFloat margin = 20;
    CGFloat viewWidth = view.bounds.size.width;
    CGFloat viewHeight = view.bounds.size.height;
    
    // 3. 设置初始位置
    CGRect beginRect = CGRectMake(viewWidth - diameter - margin, margin, diameter, diameter);
    // 3.1 根据矩形画出圆形
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:beginRect];
    layer.path = beginPath.CGPath;
    
    // 4. 设置终止位置
    CGFloat endDiameter = sqrt(viewWidth * viewWidth + viewHeight * viewHeight);
    CGRect endRect = CGRectInset(beginRect, -endDiameter, -endDiameter);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    // 5. 设置图层的遮罩 - 会裁切视图，视图本质上没有发生任何的变化，但是只会显示路径包含范围内的内容
    // 提示：一旦设置为 mask 属性，填充颜色无效！
    view.layer.mask = layer;
    // 直接添加，圆形黑色的区域直接添加在了 view 的 layer 上。
//    [view.layer addSublayer:layer];
    
    // 6. 添加核心动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = [self transitionDuration:_transitionContext];
    // 因为动画是针对的 path 属性，而 path 是 CGPath 类型，但是 fromValue 和 toValue 是 id 类型，所以需要进行桥接转换
    if (_isPresented) {
        anim.fromValue = (__bridge id)beginPath.CGPath;
        anim.toValue = (__bridge id)endPath.CGPath;
    } else {
        anim.fromValue = (__bridge id)endPath.CGPath;
        anim.toValue = (__bridge id)beginPath.CGPath;
    }

    // 不让动画移除: 2步，设置填充模式为向前填充；设置动画结束后不移除
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [layer addAnimation:anim forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_transitionContext completeTransition:YES];
}

#pragma mark - UIViewControllerTransitioningDelegate
/// modal展示时的动画代理
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresented = YES;
    return self;
}

/// modal消失时的动画代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresented = NO;
    return self;
}

@end
