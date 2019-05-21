//
//  LGFMJRefreshBackFooter.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LGFMJRefreshBackFooter.h"

@interface LGFMJRefreshBackFooter()
@property (assign, nonatomic) NSInteger lastRefreshCount;
@property (assign, nonatomic) CGFloat lastBottomDelta;
@end

@implementation LGFMJRefreshBackFooter

#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self scrollViewContentSizeDidChange:nil];
}

#pragma mark - 实现父类的方法
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新，直接返回
    if (self.state == LGFMJRefreshStateRefreshing) return;
    
    _scrollViewOriginalInset = self.scrollView.lgfmj_inset;
    
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.lgfmj_offsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    CGFloat pullingPercent = (currentOffsetY - happenOffsetY) / self.lgfmj_h;
    
    // 如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state == LGFMJRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.lgfmj_h;
        
        if (self.state == LGFMJRefreshStateIdle && currentOffsetY > normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = LGFMJRefreshStatePulling;
        } else if (self.state == LGFMJRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = LGFMJRefreshStateIdle;
        }
    } else if (self.state == LGFMJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.lgfmj_contentH + self.ignoredScrollViewContentInsetBottom;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.lgfmj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
    // 设置位置和尺寸
    self.lgfmj_y = MAX(contentHeight, scrollHeight);
}

- (void)setState:(LGFMJRefreshState)state
{
    LGFMJRefreshCheckState
    
    // 根据状态来设置属性
    if (state == LGFMJRefreshStateNoMoreData || state == LGFMJRefreshStateIdle) {
        // 刷新完毕
        if (LGFMJRefreshStateRefreshing == oldState) {
            [UIView animateWithDuration:LGFMJRefreshSlowAnimationDuration animations:^{
                self.scrollView.lgfmj_insetB -= self.lastBottomDelta;
                self.bscrollView.lgfmj_insetB -= self.lastBottomDelta;
                // 自动调整透明度
                if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
                
                if (self.endRefreshingCompletionBlock) {
                    self.endRefreshingCompletionBlock();
                }
            }];
        }
        
        CGFloat deltaH = [self heightForContentBreakView];
        // 刚刷新完毕
        if (LGFMJRefreshStateRefreshing == oldState && deltaH > 0 && self.scrollView.lgfmj_totalDataCount != self.lastRefreshCount) {
            self.scrollView.lgfmj_offsetY = self.scrollView.lgfmj_offsetY;
        }
    } else if (state == LGFMJRefreshStateRefreshing) {
        // 记录刷新前的数量
        self.lastRefreshCount = self.scrollView.lgfmj_totalDataCount;
        
        [UIView animateWithDuration:LGFMJRefreshFastAnimationDuration animations:^{
            CGFloat bottom = self.lgfmj_h + self.scrollViewOriginalInset.bottom;
            CGFloat deltaH = [self heightForContentBreakView];
            if (deltaH < 0) { // 如果内容高度小于view的高度
                bottom -= deltaH;
            }
            self.lastBottomDelta = bottom - self.scrollView.lgfmj_insetB;
            self.scrollView.lgfmj_insetB = bottom;
            self.scrollView.lgfmj_offsetY = [self happenOffsetY] + self.lgfmj_h;
            self.bscrollView.lgfmj_insetB = bottom;
            self.bscrollView.lgfmj_offsetY = [self happenOffsetY] + self.lgfmj_h;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    }
}
#pragma mark - 私有方法
#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}
@end
