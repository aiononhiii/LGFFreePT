//
//  UIScrollView+LGFLGFMJRefresh.m
//  OptimalLive
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 LGF. All rights reserved.
//

#import "UIScrollView+LGFPageRefresh.h"

@implementation UIScrollView (LGFPageRefresh)

@dynamic lgf_PageNoMoreView;
@dynamic lgf_PageFooter;
@dynamic lgf_PageHeader;

static const char *lgf_PageNoMoreViewKey = "lgf_PageNoMoreViewKey";

- (LGFMJRefreshFooter *)lgf_PageFooter {
    return (LGFMJRefreshFooter *)self.lgfmj_footer;
}

- (LGFMJRefreshHeader *)lgf_PageHeader {
    return (LGFMJRefreshHeader *)self.lgfmj_header;
}

- (void)setLgf_PageHeader:(LGFMJRefreshHeader *)lgf_PageHeader {
    self.lgfmj_header = lgf_PageHeader;
}

- (void)setLgf_PageFooter:(LGFMJRefreshFooter *)lgf_PageFooter {
    LGFMJRefreshAutoNormalFooter *footer = (LGFMJRefreshAutoNormalFooter *)lgf_PageFooter;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.textColor = [UIColor clearColor];
    [footer setTitle:@"" forState:LGFMJRefreshStateIdle];
    [footer setTitle:@"" forState:LGFMJRefreshStateRefreshing];
    [footer setTitle:@"" forState:LGFMJRefreshStateNoMoreData];
    self.lgfmj_footer = footer;
}

- (void)lgf_PageSetGifHeader:(LGFMJRefreshGifHeader *)gifHeader gifName:(NSString *)gifName gifSize:(CGSize)gifSize {
    gifHeader.stateLabel.textColor = [UIColor whiteColor];
    gifHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    // 以后如果要给header加gif动画， 加在这里
    NSMutableArray *images = [NSMutableArray arrayWithArray:[UIImage lgf_ImagesWithGif:gifName]];
    if (images.count > 0) {
        [gifHeader setImages:images forState:LGFMJRefreshStateIdle];
        [gifHeader setImages:images forState:LGFMJRefreshStateWillRefresh];
        [gifHeader setImages:@[images.firstObject] forState:LGFMJRefreshStatePulling];
        [gifHeader setImages:images forState:LGFMJRefreshStateRefreshing];
        gifHeader.lastUpdatedTimeLabel.hidden = YES;
        gifHeader.stateLabel.hidden = YES;
        gifHeader.lgf_height = gifSize.height;
        gifHeader.gifView.translatesAutoresizingMaskIntoConstraints = NO;
        [gifHeader.gifView addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:gifSize.width]];
        [gifHeader.gifView addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:gifSize.height]];
        [gifHeader addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:gifHeader
                                                              attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                               constant:0]];
        [gifHeader addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:gifHeader
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:0]];
    }
    self.lgfmj_header = gifHeader;
}

- (void)setLgf_PageNoMoreView:(UIView *)lgf_PageNoMoreView {
    objc_setAssociatedObject(self, &lgf_PageNoMoreViewKey, lgf_PageNoMoreView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lgf_PageNoMoreView {
    return objc_getAssociatedObject(self, &lgf_PageNoMoreViewKey);
}

- (void)lgf_PageEndRefreshing {
    [self.lgfmj_footer endRefreshing];
    [self.lgfmj_header endRefreshing];
}

- (void)lgf_PageReloadDataAndNoMoreDataView:(UIView *)noMoreDataView isShow:(BOOL)isShow {
    [self.lgf_PageNoMoreView removeFromSuperview];
    // 数据数组count小于10 显示我是有底线的view
    if (isShow) {
        [self.lgfmj_footer endRefreshingWithNoMoreData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lgf_PageNoMoreView = noMoreDataView;
            self.lgf_PageNoMoreView.frame = self.lgfmj_footer.bounds;
            [self.lgfmj_footer addSubview:self.lgf_PageNoMoreView];
        });
    } else {
        [self.lgfmj_footer resetNoMoreData];
    }
    // 刷新数据源
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *cv = (UICollectionView *)self;
        [cv reloadData];
    } else if ([self isKindOfClass:[UITableView class]]) {
        UITableView *cv = (UITableView *)self;
        [cv reloadData];
    }
}

- (void)lgf_PageReloadData:(NSInteger)count dataArrayCount:(NSInteger)dataArrayCount {
    [self lgf_PageReloadData:count noDataViewType:1 limitCount:10 dataArrayCount:dataArrayCount];
}

- (void)lgf_PageReloadData:(NSInteger)count noDataViewType:(NSInteger)noDataViewType dataArrayCount:(NSInteger)dataArrayCount {
    [self lgf_PageReloadData:count noDataViewType:0 limitCount:10 dataArrayCount:dataArrayCount];
}

- (void)lgf_PageReloadData:(NSInteger)count limitCount:(NSInteger)limit dataArrayCount:(NSInteger)dataArrayCount {
    [self lgf_PageReloadData:count noDataViewType:1 limitCount:limit dataArrayCount:dataArrayCount];
}

- (void)lgf_PageReloadData:(NSInteger)count noDataViewType:(NSInteger)noDataViewType limitCount:(NSInteger)limit dataArrayCount:(NSInteger)dataArrayCount {
    if (count == 0 && dataArrayCount == 0) {
        //        [self.lgfmj_footer.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //            if ([obj isKindOfClass:[QTNoDataView class]]) {
        //                [obj removeFromSuperview];
        //            }
        //        }];
        [self.lgfmj_footer endRefreshingWithNoMoreData];
        // 刷新数据源
        if ([self isKindOfClass:[UICollectionView class]]) {
            UICollectionView *cv = (UICollectionView *)self;
            [cv reloadData];
        } else if ([self isKindOfClass:[UITableView class]]) {
            UITableView *cv = (UITableView *)self;
            [cv reloadData];
        }
    } else {
//        QTNoDataView *view = [QTNoDataView lgf];
//        view.noDataViewType = noDataViewType;
//        [self lgf_PageReloadDataAndNoMoreDataView:view isShow:dataArrayCount == 0 ? NO : count < limit];
    }
}

@end
