//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  LGFMJRefreshHeader.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LGFMJRefreshHeader.h"

@interface LGFMJRefreshHeader()
@property (assign, nonatomic) CGFloat insetTDelta;
@property (strong, nonatomic) UIScrollView *draggingSV;
@end

@implementation LGFMJRefreshHeader
#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(LGFMJRefreshComponentRefreshingBlock)refreshingBlock
{
    LGFMJRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    LGFMJRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置key
    self.lastUpdatedTimeKey = LGFMJRefreshHeaderLastUpdatedTimeKey;
    
    // 设置高度
    self.lgfmj_h = LGFMJRefreshHeaderHeight;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.lgfmj_y = - self.lgfmj_h - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.scrollView.tracking) {
        self.draggingSV = _scrollView;
    } else {
        self.draggingSV = _bscrollView;
    }
    
    // 在刷新的refreshing状态
    if (self.state == LGFMJRefreshStateRefreshing) {
        // 暂时保留
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.draggingSV.lgfmj_offsetY > _scrollViewOriginalInset.top ? - self.draggingSV.lgfmj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.lgfmj_h + _scrollViewOriginalInset.top ? self.lgfmj_h + _scrollViewOriginalInset.top : insetT;
        _scrollView.lgfmj_insetT = insetT;
        _bscrollView.lgfmj_insetT = insetT;
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.draggingSV.lgfmj_inset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.draggingSV.lgfmj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.lgfmj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.lgfmj_h;
    
    if (self.draggingSV.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == LGFMJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = LGFMJRefreshStatePulling;
        } else if (self.state == LGFMJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
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

- (void)setState:(LGFMJRefreshState)state
{
    LGFMJRefreshCheckState
    
    // 根据状态做事情
    if (state == LGFMJRefreshStateIdle) {
        if (oldState != LGFMJRefreshStateRefreshing) return;
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset
        [UIView animateWithDuration:LGFMJRefreshSlowAnimationDuration animations:^{
            self.scrollView.lgfmj_insetT += self.insetTDelta;
            self.bscrollView.lgfmj_insetT += self.insetTDelta;
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];  
    } else if (state == LGFMJRefreshStateRefreshing) {
        LGFMJRefreshDispatchAsyncOnMainQueue({
            [UIView animateWithDuration:LGFMJRefreshFastAnimationDuration animations:^{
                if (self.draggingSV.panGestureRecognizer.state != UIGestureRecognizerStateCancelled) {
                    CGFloat top = self.scrollViewOriginalInset.top + self.lgfmj_h;
                    // 增加滚动区域top
                    self.scrollView.lgfmj_insetT = top;
                    self.bscrollView.lgfmj_insetT = top;
                    // 设置滚动位置
                    CGPoint offset = self.draggingSV.contentOffset;
                    offset.y = -top;
                    [self.draggingSV setContentOffset:offset animated:NO];
                }
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        })
    }
}

#pragma mark - 公共方法
- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

- (void)setIgnoredScrollViewContentInsetTop:(CGFloat)ignoredScrollViewContentInsetTop {
    _ignoredScrollViewContentInsetTop = ignoredScrollViewContentInsetTop;
    
    self.lgfmj_y = - self.lgfmj_h - _ignoredScrollViewContentInsetTop;
}

@end
