//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  LGFMJRefreshFooter.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LGFMJRefreshFooter.h"
#include "UIScrollView+LGFMJRefresh.h"

@interface LGFMJRefreshFooter()

@end

@implementation LGFMJRefreshFooter

#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(LGFMJRefreshComponentRefreshingBlock)refreshingBlock
{
    LGFMJRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    LGFMJRefreshFooter *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置自己的高度
    self.lgfmj_h = LGFMJRefreshFooterHeight;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
            [self.scrollView setLgfmj_reloadDataBlock:^(NSInteger totalDataCount) {
                self.hidden = (totalDataCount == 0);
            }];
        }
        if ([self.bscrollView isKindOfClass:[UITableView class]] || [self.bscrollView isKindOfClass:[UICollectionView class]]) {
            [self.bscrollView setLgfmj_reloadDataBlock:^(NSInteger totalDataCount) {
                self.hidden = (totalDataCount == 0);
            }];
        }
    }
}

#pragma mark - 公共方法
- (void)endRefreshingWithNoMoreData
{
    LGFMJRefreshDispatchAsyncOnMainQueue(self.state = LGFMJRefreshStateNoMoreData;)
}

- (void)noticeNoMoreData
{
    [self endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    LGFMJRefreshDispatchAsyncOnMainQueue(self.state = LGFMJRefreshStateIdle;)
}

- (void)setAutomaticallyHidden:(BOOL)automaticallyHidden
{
    _automaticallyHidden = automaticallyHidden;
}

@end
