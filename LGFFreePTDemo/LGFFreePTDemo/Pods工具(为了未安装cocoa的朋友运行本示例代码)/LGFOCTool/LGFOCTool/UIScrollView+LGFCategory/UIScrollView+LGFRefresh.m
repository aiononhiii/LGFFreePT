//
//  UIScrollView+LGFRefresh.m
//  OptimalLive
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 LGF. All rights reserved.
//

#import "UIScrollView+LGFRefresh.h"

@implementation UIScrollView (LGFRefresh)

@dynamic lgf_NoMoreView;
@dynamic lgf_Footer;
@dynamic lgf_Header;

static const char *lgf_NoMoreViewKey = "lgf_NoMoreViewKey";

- (MJRefreshFooter *)lgf_Footer {
    return (MJRefreshFooter *)self.mj_footer;
}

- (MJRefreshHeader *)lgf_Header {
    return (MJRefreshHeader *)self.mj_header;
}

- (void)setLgf_Header:(MJRefreshHeader *)lgf_Header {
    self.mj_header = lgf_Header;
}

- (void)setLgf_Footer:(MJRefreshFooter *)lgf_Footer {
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)lgf_Footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.textColor = [UIColor clearColor];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

- (void)lgf_SetGifHeader:(MJRefreshGifHeader *)gifHeader gifName:(NSString *)gifName gifSize:(CGSize)gifSize {
    gifHeader.stateLabel.textColor = [UIColor whiteColor];
    gifHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    // 以后如果要给header加gif动画， 加在这里
    NSMutableArray *images = [NSMutableArray arrayWithArray:[UIImage lgf_ImagesWithGif:gifName]];
    if (images.count > 0) {
        [gifHeader setImages:images forState:MJRefreshStateIdle];
        [gifHeader setImages:images forState:MJRefreshStateWillRefresh];
        [gifHeader setImages:@[images.firstObject] forState:MJRefreshStatePulling];
        [gifHeader setImages:images forState:MJRefreshStateRefreshing];
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
    self.mj_header = gifHeader;
}

- (void)setLgf_NoMoreView:(UIView *)lgf_NoMoreView {
    objc_setAssociatedObject(self, &lgf_NoMoreViewKey, lgf_NoMoreView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lgf_NoMoreView {
    return objc_getAssociatedObject(self, &lgf_NoMoreViewKey);
}

- (void)lgf_EndRefreshing {
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}

- (void)lgf_ReloadDataAndNoMoreDataView:(UIView *)noMoreDataView isShow:(BOOL)isShow {
    [self.lgf_NoMoreView removeFromSuperview];
    // 数据数组count小于10 显示我是有底线的view
    if (isShow) {
        [self.mj_footer endRefreshingWithNoMoreData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lgf_NoMoreView = noMoreDataView;
            self.lgf_NoMoreView.frame = self.mj_footer.bounds;
            [self.mj_footer addSubview:self.lgf_NoMoreView];
        });
    } else {
        [self.mj_footer resetNoMoreData];
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

@end
