//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+Extension.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIScrollView+LGFMJExtension.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (LGFMJExtension)

static BOOL respondsToAdjustedContentInset_;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        respondsToAdjustedContentInset_ = [self instancesRespondToSelector:@selector(adjustedContentInset)];
    });
}

- (UIEdgeInsets)lgfmj_inset
{
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (void)setLgfmj_insetT:(CGFloat)lgfmj_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = lgfmj_insetT;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgfmj_insetT
{
    return self.lgfmj_inset.top;
}

- (void)setLgfmj_insetB:(CGFloat)lgfmj_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = lgfmj_insetB;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgfmj_insetB
{
    return self.lgfmj_inset.bottom;
}

- (void)setLgfmj_insetL:(CGFloat)lgfmj_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = lgfmj_insetL;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgfmj_insetL
{
    return self.lgfmj_inset.left;
}

- (void)setLgfmj_insetR:(CGFloat)lgfmj_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = lgfmj_insetR;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgfmj_insetR
{
    return self.lgfmj_inset.right;
}

- (void)setLgfmj_offsetX:(CGFloat)lgfmj_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = lgfmj_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)lgfmj_offsetX
{
    return self.contentOffset.x;
}

- (void)setLgfmj_offsetY:(CGFloat)lgfmj_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = lgfmj_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)lgfmj_offsetY
{
    return self.contentOffset.y;
}

- (void)setLgfmj_contentW:(CGFloat)lgfmj_contentW
{
    CGSize size = self.contentSize;
    size.width = lgfmj_contentW;
    self.contentSize = size;
}

- (CGFloat)lgfmj_contentW
{
    return self.contentSize.width;
}

- (void)setLgfmj_contentH:(CGFloat)lgfmj_contentH
{
    CGSize size = self.contentSize;
    size.height = lgfmj_contentH;
    self.contentSize = size;
}

- (CGFloat)lgfmj_contentH
{
    return self.contentSize.height;
}
@end
#pragma clang diagnostic pop
