//
//  HXTGestureLockView.h
//  手势解锁
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXTGestureLockView;
@protocol HXTGestureLockViewDelegate <NSObject>
@optional
- (BOOL)lockView:(HXTGestureLockView *)lockView verifyPassword:(NSString *)password;
@end
@interface HXTGestureLockView : UIView
@property (weak,nonatomic) id<HXTGestureLockViewDelegate> delegate;
@end
