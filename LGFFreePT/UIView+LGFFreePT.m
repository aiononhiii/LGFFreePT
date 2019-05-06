//
//  UIView+LGFFreePT.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "UIView+LGFFreePT.h"

@implementation UIView (LGFFreePT)

- (void)setLgfpt_X:(CGFloat)lgfpt_X {
    CGRect frame = self.frame;
    frame.origin.x = lgfpt_X;
    self.frame = frame;
}

- (void)setLgfpt_Y:(CGFloat)lgfpt_Y {
    CGRect frame = self.frame;
    frame.origin.y = lgfpt_Y;
    self.frame = frame;
}

- (CGFloat)lgfpt_X {
    return self.frame.origin.x;
}

- (CGFloat)lgfpt_Y {
    return self.frame.origin.y;
}

- (void)setLgfpt_CenterX:(CGFloat)lgfpt_CenterX {
    CGPoint center = self.center;
    center.x = lgfpt_CenterX;
    self.center = center;
}

- (CGFloat)lgfpt_CenterX {
    return self.center.x;
}

- (void)setLgfpt_CenterY:(CGFloat)lgfpt_CenterY {
    CGPoint center = self.center;
    center.y = lgfpt_CenterY;
    self.center = center;
}

- (CGFloat)lgfpt_CenterY {
    return self.center.y;
}

- (void)setLgfpt_Width:(CGFloat)lgfpt_Width {
    CGRect frame = self.frame;
    frame.size.width = lgfpt_Width;
    self.frame = frame;
}

- (CGFloat)lgfpt_Width {
    return self.frame.size.width;
}

- (void)setLgfpt_Height:(CGFloat)lgfpt_Height {
    CGRect frame = self.frame;
    frame.size.height = lgfpt_Height;
    self.frame = frame;
}

- (CGFloat)lgfpt_Height {
    return self.frame.size.height;
}

- (void)setLgfpt_Size:(CGSize)lgfpt_Size {
    CGRect frame = self.frame;
    frame.size = lgfpt_Size;
    self.frame = frame;
}

- (CGSize)lgfpt_Size {
    return self.frame.size;
}

- (void)setLgfpt_Origin:(CGPoint)lgfpt_Origin {
    CGRect frame = self.frame;
    frame.origin = lgfpt_Origin;
    self.frame = frame;
}

- (CGPoint)lgfpt_Origin {
    return self.frame.origin;
}

@end
