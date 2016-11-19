//
//  HXTGestureLockView.m
//  手势解锁
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HXTGestureLockView.h"

@interface HXTGestureLockView ()
{
    CGPoint _movePoint;
}
@property (strong,nonatomic) NSMutableArray <UIButton *> *selectedButtonMutableArray;
@end
@implementation HXTGestureLockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupUI
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint beganLoc = [touches.anyObject locationInView:self];
    [self addSelectedButtonIfContainPoint:beganLoc];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _movePoint = [touches.anyObject locationInView:self];
    [self addSelectedButtonIfContainPoint:_movePoint];
    [self setNeedsDisplay];
//    NSLog(@"%zd", self.selectedButtonMutableArray.count);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _movePoint = self.selectedButtonMutableArray.lastObject.center;
    [self setNeedsDisplay];
    
    // 拼接密码
    NSMutableString *passwordString = [[NSMutableString alloc]init];
    // 不可变的字符串也可以
//    __block NSString *pwdString = [[NSString alloc]init];
    [self.selectedButtonMutableArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger buttonIndex = [self.subviews indexOfObject:obj];
//        pwdString = [pwdString stringByAppendingString:[NSString stringWithFormat:@"%zd", buttonIndex]];
        [passwordString appendString:[NSString stringWithFormat:@"%zd", buttonIndex]];
    }];
    NSLog(@"%@", passwordString);

    if ([self.delegate respondsToSelector:@selector(lockView:verifyPassword:)])
    {
       if(![self.delegate lockView:self verifyPassword:passwordString.copy])
       {
           [self.selectedButtonMutableArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               obj.selected = NO;
               obj.enabled = NO;
           }];
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self.selectedButtonMutableArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   obj.selected = NO;
                   obj.enabled = YES;
               }];
               self.selectedButtonMutableArray = nil;
               [self setNeedsDisplay];
           });
       }
    }
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (!self.selectedButtonMutableArray.firstObject)
    {
        return;
    }
    [path moveToPoint:self.selectedButtonMutableArray.firstObject.center];
    [self.selectedButtonMutableArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [path addLineToPoint:obj.center];
        }
    }];
    [path addLineToPoint:_movePoint];
    path.lineWidth = 10;
    [[UIColor whiteColor] setStroke];
    [path stroke];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger columnNum = 3;
    CGFloat buttonWidth = 78;
    CGFloat buttonHeight = buttonWidth;
    CGFloat buttonPaddingX = (self.bounds.size.width - buttonWidth*columnNum) / (columnNum-1);
    CGFloat buttonPaddingY = buttonPaddingX;
    CGFloat buttonX = 0;
    CGFloat buttonY = buttonX;
    // 添加按钮
    for(NSInteger i = 0; i < 9; i++)
    {
        CGFloat buttonForX = buttonX + (buttonPaddingX + buttonWidth) * (i % columnNum);
        CGFloat buttonForY = buttonY + (buttonPaddingY + buttonHeight) * (i / columnNum);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonForX, buttonForY, buttonWidth, buttonHeight);
        [self addSubview:button];
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"]
                forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_selected"]
                forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"gesture_node_error"]
                forState:UIControlStateDisabled];
        
        button.userInteractionEnabled = NO;
    }
}

- (void)addSelectedButtonIfContainPoint:(CGPoint)point
{
    for (UIButton *button in self.subviews)
    {
        if(CGRectContainsPoint(button.frame, point))
        {
            button.selected = YES;
            if (![self.selectedButtonMutableArray containsObject:button])
            {
                [self.selectedButtonMutableArray addObject:button];
            }
        }
    }
}

- (NSMutableArray<UIButton *> *)selectedButtonMutableArray
{
    if (_selectedButtonMutableArray == nil) {
        _selectedButtonMutableArray = [NSMutableArray array];
    }
    return _selectedButtonMutableArray;
}

@end
