//
//  pageChildVC.m
//  LGFOCTool
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFCenterPageChildVC.h"

#undef lgf_CenterChildPageCVRealRect
#define lgf_CenterChildPageCVRealRect ([self.view.superview convertRect:self.view.frame toView:nil])

@interface LGFCenterPageChildVC () <CHTCollectionViewDelegateWaterfallLayout>
@end

@implementation LGFCenterPageChildVC

lgf_SBViewControllerForM(LGFCenterPageChildVC, @"LGFCenterPageVC", @"LGFCenterPageChildVC");

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.lgf_CenterChildPageCV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.lgf_PanScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 代理回调 viewDidLoad
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVCDidLoad:)] && self) {
        [self.delegate lgf_CenterChildPageVCDidLoad:self];
    }
    
    // 给 header view 预留 top 空间
    if (self.lgf_CenterChildPageCV.contentInset.top != self.lgf_HeaderHeight) {
        [self.lgf_CenterChildPageCV setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight, 0,  self.lgf_PageCVBottom, 0)];
        [self.lgf_PanScrollView setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight, 0, self.lgf_PageCVBottom, 0)];
    }
    
    // 外部 cell 注册
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVCellClass:)]) {
        lgf_RegisterNibCVCell(self.lgf_CenterChildPageCV, [self.delegate lgf_CenterChildPageCVCellClass:self], NSStringFromClass([self.delegate lgf_CenterChildPageCVCellClass:self]));
    }
    
    if (self.lgf_SelectIndex == 0) {
        [self.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -self.lgf_HeaderHeight) animated:NO];
        [self.lgf_PanScrollView setContentOffset:CGPointMake(0, -self.lgf_HeaderHeight) animated:NO];
    }
    // 这里使用我改写过的 MJRefresh (支持双 ScrollView 重叠刷新)
    LGFMJRefreshFooter *footer = LGFPageMJFooter(self, @selector(lgf_ChildLoadMoreData));
    footer.bscrollView = self.lgf_PanScrollView;
    self.lgf_CenterChildPageCV.lgf_PageFooter = footer;
    
    self.lgf_PanScrollView.scrollsToTop = NO;
    self.lgf_CenterChildPageCV.scrollsToTop = YES;
}

- (void)dealloc {
    self.lgf_CenterChildPageCV.lgfmj_header = nil;
    self.lgf_CenterChildPageCV.lgfmj_footer = nil;
}

- (void)lgf_ChildLoadData {
    self.lgf_Page = 1;
    if ([self.delegate respondsToSelector:@selector(lgf_CenterPageChildVCLoadData:selectIndex:loadType:)] && self) {
        [self.delegate lgf_CenterPageChildVCLoadData:self selectIndex:self.lgf_SelectIndex loadType:lgf_ChildLoadData];
    }
}

- (void)lgf_ChildLoadMoreData {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterPageChildVCLoadData:selectIndex:loadType:)] && self) {
        [self.delegate lgf_CenterPageChildVCLoadData:self selectIndex:self.lgf_SelectIndex loadType:lgf_ChildLoadMoreData];
    }
}

#pragma mark - 空白占位逻辑优化
- (void)lgf_SynContentSize {
    if (!self.lgf_IsLoadData) { self.lgf_CenterChildPageCV.alpha = 0.0; }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.lgf_CenterChildPageCV setNeedsLayout];
        [self.lgf_CenterChildPageCV layoutIfNeeded];
        [self.lgf_PanScrollView setContentSize:self.lgf_CenterChildPageCV.contentSize];
        NSLog(@"%f", lgf_CenterChildPageCVRealRect.origin.y);
        if (self.lgf_CenterChildPageCV.contentSize.height < (self.view.lgf_height - self.lgf_HeaderHeight)) {
            [self.lgf_CenterChildPageCV setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight,
                                                                         0,
                                                                         self.view.lgf_height - self.lgf_CenterChildPageCV.contentSize.height - self.lgf_PageTitleViewHeight + self.lgf_PageCVBottom,
                                                                         0)];
            [self.lgf_PanScrollView setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight,
                                                                     0,
                                                                     self.view.lgf_height - self.lgf_CenterChildPageCV.contentSize.height - self.lgf_PageTitleViewHeight + self.lgf_PageCVBottom,
                                                                     0)];
        } else {
            [self.lgf_CenterChildPageCV setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight,
                                                                         0,
                                                                         LGFMJRefreshFooterHeight + self.lgf_PageCVBottom,
                                                                         0)];
            [self.lgf_PanScrollView setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight,
                                                                     0,
                                                                     LGFMJRefreshFooterHeight + self.lgf_PageCVBottom,
                                                                     0)];
        }
        if (!self.lgf_IsLoadData) {
            if (self.lgf_SelectIndex == 0) {
                [self.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -self.lgf_HeaderHeight) animated:NO];
                [self.lgf_PanScrollView setContentOffset:CGPointMake(0, -self.lgf_HeaderHeight) animated:NO];
            } else {
                [self.lgf_CenterChildPageCV setContentOffset:CGPointMake(0.0, self.lgf_OffsetY) animated:NO];
                [self.lgf_PanScrollView setContentOffset:CGPointMake(0.0, self.lgf_OffsetY) animated:NO];
            }
            self.lgf_CenterChildPageCV.alpha = 1.0;
        }
        self.lgf_IsLoadData = YES;
        [lgf_NCenter postNotificationName:@"LGFChildScroll" object:@[@(self.lgf_CenterChildPageCV.contentOffset.y), @(self.lgf_SelectIndex)]];
    });
}

#pragma mark - Collection View DataSource And Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(lgf_NumberOfItems:)] && self) {
        if (!self.lgf_PageChildDataArray || self.lgf_PageChildDataArray.count == 0) {
            return 0;
        }
        return [self.delegate lgf_NumberOfItems:self];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_SizeForItemAtIndexPath:VC:)] && self) {
        return [self.delegate lgf_SizeForItemAtIndexPath:indexPath VC:self];
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumColumnSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self.delegate lgf_CenterChildPageCVCellClass:self]) forIndexPath:indexPath];
    if (self.lgf_PageChildDataArray.count > 0) {
        if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:cell:indexPath:)] && self) {
            [self.delegate lgf_CenterChildPageVC:self cell:cell indexPath:indexPath];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:didSelectItemAtIndexPath:)] && self) {
        [self.delegate lgf_CenterChildPageVC:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - 以一个 空白ScrollView 联动两个非父子关系控件的核心代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView == self.lgf_PanScrollView) {
        // 如果 lgf_CenterChildPageCV 滚动被暂停
        if (self.lgf_CenterChildPageCV.tracking) {
            [self showHeaderTapView];
            [self hidePanScrollView];
            // 暂停 lgf_PanScrollView 滚动
            [self.lgf_PanScrollView setContentOffset:self.lgf_PanScrollView.contentOffset animated:NO];
        }
        // 让 lgf_CenterChildPageCV 与 lgf_PanScrollView 联动
        [self.lgf_CenterChildPageCV setContentOffset:self.lgf_PanScrollView.contentOffset];
    } else {
        // 如果 lgf_PanScrollView 滚动被暂停
        if (self.lgf_PanScrollView.tracking) {
            [self hideHeaderTapView];
            [self showPanScrollView];
            // 暂停 lgf_CenterChildPageCV 滚动
            [self.lgf_CenterChildPageCV setContentOffset:self.lgf_CenterChildPageCV.contentOffset animated:NO];
        }
        // 让 lgf_PanScrollView 与 lgf_CenterChildPageCV 联动
        if (self.lgf_CenterChildPageCV.contentOffset.y > -(self.lgf_HeaderHeight + LGFMJRefreshFooterHeight)) {
            [self.lgf_PanScrollView setContentOffset:self.lgf_CenterChildPageCV.contentOffset];
        }
    }
    [lgf_NCenter postNotificationName:@"LGFChildScroll" object:@[@(scrollView.contentOffset.y), @(self.lgf_SelectIndex)]];
}

// 滚动是否手动暂停
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (!self.lgf_CenterChildPageCV.tracking) {
            [self hidePanScrollView];
        }
        if (!self.lgf_PanScrollView.tracking) {
            [self hideHeaderTapView];
        }
        self.lgf_CenterPageCV.scrollEnabled = YES;
    }
}
// 滚动是否开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lgf_CenterPageCV.scrollEnabled = NO;
}
// 滚动是否暂停
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.lgf_CenterChildPageCV.tracking) {
        [self hidePanScrollView];
    }
    if (!self.lgf_PanScrollView.tracking) {
        [self hideHeaderTapView];
    }
    self.lgf_CenterPageCV.scrollEnabled = YES;
}
// 隐藏 lgf_PanScrollView 展示 lgf_CenterChildPageCV, 并将 pan 手势重新赋值到 lgf_CenterChildPageCV
- (void)hidePanScrollView {
    [self.view bringSubviewToFront:self.lgf_CenterChildPageCV];
    [self.lgf_PanScrollView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_CenterChildPageCV addGestureRecognizer:obj];
             self.lgf_PanScrollView.scrollsToTop = NO;
             self.lgf_CenterChildPageCV.scrollsToTop = YES;
         }
     }];
}
// 展示 lgf_PanScrollView 隐藏 lgf_CenterChildPageCV, 并将 pan 手势赋值到 空白ScrollView
- (void)showPanScrollView {
    [self.view bringSubviewToFront:self.lgf_PanScrollView];
    [self.lgf_CenterChildPageCV.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_PanScrollView addGestureRecognizer:obj];
            self.lgf_CenterChildPageCV.scrollsToTop = NO;
            self.lgf_PanScrollView.scrollsToTop = YES;
        }
    }];
}
// 隐藏 lgf_HeaderTapView 展示 lgf_HeaderSuperView, 并将之前从 lgf_PanScrollView 得到的 pan 手势重新赋值到 lgf_HeaderSuperView
- (void)hideHeaderTapView {
    [self.LGFCenterPageView bringSubviewToFront:self.lgf_HeaderSuperView];
    [self.lgf_HeaderTapView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_HeaderSuperView addGestureRecognizer:self.lgf_HeaderTapView.gestureRecognizers.firstObject];
        }
    }];
}
// 展示 lgf_HeaderTapView 隐藏 lgf_HeaderSuperView, 并将之前从 lgf_PanScrollView 得到的 pan 手势赋值到 lgf_HeaderTapView
- (void)showHeaderTapView {
    [self.LGFCenterPageView bringSubviewToFront:self.lgf_HeaderTapView];
    [self.lgf_HeaderSuperView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_HeaderTapView addGestureRecognizer:obj];
        }
    }];
}
#pragma mark -----------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
- (NSMutableArray *)lgf_PageChildDataArray {
    if (!_lgf_PageChildDataArray) {
        _lgf_PageChildDataArray = [NSMutableArray new];
    }
    return _lgf_PageChildDataArray;
}

- (NSMutableArray *)lgf_PageChildDataHeightArray {
    if (!_lgf_PageChildDataHeightArray) {
        _lgf_PageChildDataHeightArray = [NSMutableArray new];
    }
    return _lgf_PageChildDataHeightArray;
}

@end
