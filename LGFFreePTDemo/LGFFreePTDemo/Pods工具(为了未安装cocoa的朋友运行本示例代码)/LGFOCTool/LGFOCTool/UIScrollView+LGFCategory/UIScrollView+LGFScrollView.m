//
//  UIScrollView+LGFScrollView.m
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIScrollView+LGFScrollView.h"

@implementation UIScrollView (LGFScrollView)

- (void)lgf_ScrollToTop {
    [self lgf_ScrollToTopAnimated:YES];
}

- (void)lgf_ScrollToBottom {
    [self lgf_ScrollToBottomAnimated:YES];
}

- (void)lgf_ScrollToLeft {
    [self lgf_ScrollToLeftAnimated:YES];
}

- (void)lgf_ScrollToRight {
    [self lgf_ScrollToRightAnimated:YES];
}

- (void)lgf_ScrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)lgf_ScrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)lgf_ScrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)lgf_ScrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

- (NSInteger)lgf_GetScrollPageIndex {
    NSInteger index = self.contentOffset.x / (NSInteger)self.bounds.size.width;
    return index;
}

@end
