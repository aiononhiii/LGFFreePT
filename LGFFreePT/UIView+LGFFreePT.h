//
//  UIView+LGFFreePT.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LGFFreePT)
@property (assign, nonatomic) CGFloat lgfpt_X;
@property (assign, nonatomic) CGFloat lgfpt_Y;
@property (assign, nonatomic) CGFloat lgfpt_CenterX;
@property (assign, nonatomic) CGFloat lgfpt_CenterY;
@property (assign, nonatomic) CGFloat lgfpt_Width;
@property (assign, nonatomic) CGFloat lgfpt_Height;
@property (assign, nonatomic) CGPoint lgfpt_Origin;
@property (assign, nonatomic) CGSize lgfpt_Size;
#pragma mark - 用于特殊 title 赋值属性用
@property (copy, nonatomic) IBInspectable NSString *lgf_FreePTSpecialTitleProperty;
@end

NS_ASSUME_NONNULL_END
