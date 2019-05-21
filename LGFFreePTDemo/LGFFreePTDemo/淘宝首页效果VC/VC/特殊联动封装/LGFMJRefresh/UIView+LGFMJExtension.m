//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIView+Extension.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIView+LGFMJExtension.h"

@implementation UIView (LGFMJExtension)
- (void)setLgfmj_x:(CGFloat)lgfmj_x
{
    CGRect frame = self.frame;
    frame.origin.x = lgfmj_x;
    self.frame = frame;
}

- (CGFloat)lgfmj_x
{
    return self.frame.origin.x;
}

- (void)setLgfmj_y:(CGFloat)lgfmj_y
{
    CGRect frame = self.frame;
    frame.origin.y = lgfmj_y;
    self.frame = frame;
}

- (CGFloat)lgfmj_y
{
    return self.frame.origin.y;
}

- (void)setLgfmj_w:(CGFloat)lgfmj_w
{
    CGRect frame = self.frame;
    frame.size.width = lgfmj_w;
    self.frame = frame;
}

- (CGFloat)lgfmj_w
{
    return self.frame.size.width;
}

- (void)setLgfmj_h:(CGFloat)lgfmj_h
{
    CGRect frame = self.frame;
    frame.size.height = lgfmj_h;
    self.frame = frame;
}

- (CGFloat)lgfmj_h
{
    return self.frame.size.height;
}

- (void)setLgfmj_size:(CGSize)lgfmj_size
{
    CGRect frame = self.frame;
    frame.size = lgfmj_size;
    self.frame = frame;
}

- (CGSize)lgfmj_size
{
    return self.frame.size;
}

- (void)setLgfmj_origin:(CGPoint)lgfmj_origin
{
    CGRect frame = self.frame;
    frame.origin = lgfmj_origin;
    self.frame = frame;
}

- (CGPoint)lgfmj_origin
{
    return self.frame.origin;
}
@end
