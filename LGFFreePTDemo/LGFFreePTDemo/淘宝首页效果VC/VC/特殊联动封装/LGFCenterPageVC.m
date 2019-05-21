//
//  lgf_CenterPageCV.m
//  LGFOCTool
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFCenterPageVC.h"
#import "LGFCenterPageChildVC.h"

@interface LGFCenterPageVC () <LGFFreePTDelegate, LGFCenterPageChildVCDelegate>
@end

@implementation LGFCenterPageVC

lgf_SBViewControllerForM(LGFCenterPageVC, @"LGFCenterPageVC", @"LGFCenterPageVC");

- (void)lgf_ShowInVC:(UIViewController *)VC view:(UIView *)view {
    [VC addChildViewController:self];
    self.view.frame = view.bounds;
    [view addSubview:self.view];
    view.clipsToBounds = YES;
}

- (void)reloadPageTitleWidthArray:(NSMutableArray *)dataArray {
    self.lgf_PageTitleArray = [NSMutableArray arrayWithArray:dataArray];
    [self.lgf_PageTitleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGFCenterPageChildVC *vc = [LGFCenterPageChildVC lgf];
        vc.title = obj;
        vc.lgf_Page = 1;
        vc.delegate = self;
        vc.lgf_HeaderHeight = self.lgf_HeaderHeight;
        vc.lgf_PageTitleViewHeight = self.lgf_PageTitleViewHeight;
        vc.lgf_SelectIndex = idx;
        vc.lgf_CenterPageCV = self.lgf_CenterPageCV;
        vc.LGFCenterPageView = self.view;
        vc.lgf_HeaderTapView = self.lgf_HeaderTapView;
        vc.lgf_HeaderSuperView = self.lgf_HeaderSuperView;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.lgf_ChildVCArray addObject:vc];
    }];

    // 刷新title数组
    self.lgf_PageTitleView.lgf_Style.lgf_Titles = self.lgf_PageTitleArray;
    [self.lgf_PageTitleView lgf_ReloadTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.lgf_CenterPageCV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.lgf_CenterPageCV.scrollsToTop = NO;
    self.lgf_PageTitleSuperViewHeight.constant = self.lgf_PageTitleViewHeight - IPhoneX_NAVIGATION_BAR_HEIGHT;
    self.lgf_HeaderSuperView.frame = CGRectMake(0, self.lgf_CenterPageCV.lgf_y, lgf_ScreenWidth, self.lgf_HeaderHeight);
    self.lgf_HeaderTapView.frame = self.lgf_HeaderSuperView.frame;
    [self.view addSubview:self.lgf_HeaderTapView];
    [self.view addSubview:self.lgf_HeaderSuperView];
    
    if (self.lgf_HeaderView) {
        self.lgf_HeaderView.frame = CGRectMake(0, 0, lgf_ScreenWidth, self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight + IPhoneX_NAVIGATION_BAR_HEIGHT);
        [self.lgf_HeaderViewForSB addSubview:self.lgf_HeaderView];
    }
    if (self.lgf_PageTitleSuperView) {
        self.lgf_PageTitleSuperView.frame = CGRectMake(0, 0, lgf_ScreenWidth, self.lgf_PageTitleViewHeight);
        [self.lgf_PageTitleSuperViewForSB addSubview:self.lgf_PageTitleSuperView];
    }
    
    [lgf_NCenter addObserver:self selector:@selector(childScroll:) name:@"LGFChildScroll" object:nil];
}

#pragma mark - 分页控制部分逻辑
- (void)childScroll:(NSNotification *)noti {
    NSInteger index = [noti.object[1] integerValue];
    CGFloat offsetY = [noti.object[0] floatValue];
    if (index == self.lgf_SelectIndex) {
        self.lgf_OffsetY = offsetY;
        self.lgf_HeaderSuperView.transform = CGAffineTransformMakeTranslation(0, MAX(-(self.lgf_OffsetY + self.lgf_HeaderHeight), -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)));
        self.lgf_HeaderTapView.transform = self.lgf_HeaderSuperView.transform;
    }
    if (offsetY <= -self.lgf_PageTitleViewHeight) {
        if (self.lgf_PageTitleSuperViewLine.hidden == NO) {
            self.lgf_PageTitleSuperViewLine.hidden = YES;
        }
    } else {
        if (self.lgf_PageTitleSuperViewLine.hidden == YES) {
            self.lgf_PageTitleSuperViewLine.hidden = NO;
        }
    }
}

#pragma mark - LGFCenterPageChildVC Delegate

- (void)lgf_CenterChildPageVCDidLoad:(UIViewController *)VC {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVCDidLoad:)]) {
        return [self.delegate lgf_CenterChildPageVCDidLoad:VC];
    }
}

- (void)lgf_CenterPageChildVCLoadData:(LGFCenterPageChildVC *)VC selectIndex:(NSInteger)selectIndex loadType:(lgf_ChildLoadType)loadType {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterPageChildVCLoadData:selectIndex:loadType:)]) {
        [self.delegate lgf_CenterPageChildVCLoadData:VC selectIndex:selectIndex loadType:loadType == lgf_ChildLoadData ? lgf_LoadData : lgf_LoadMoreData];
    }
}

- (NSInteger)lgf_NumberOfItems:(UIViewController *)lgf_CenterChildPageVC {
    if ([self.delegate respondsToSelector:@selector(lgf_NumberOfItems:)]) {
        return [self.delegate lgf_NumberOfItems:lgf_CenterChildPageVC];
    }
    return 0;
}

- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath VC:(LGFCenterPageChildVC *)VC {
    if ([self.delegate respondsToSelector:@selector(lgf_SizeForItemAtIndexPath:VC:)] && VC) {
        return [self.delegate lgf_SizeForItemAtIndexPath:indexPath VC:VC];
    }
    return CGSizeZero;
}

- (Class)lgf_CenterChildPageCVCellClass:(LGFCenterPageChildVC *)VC {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVCellClass:)]) {
        return [self.delegate lgf_CenterChildPageCVCellClass:VC];
    }
    return nil;
}

- (void)lgf_CenterChildPageVC:(LGFCenterPageChildVC *)VC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:cell:indexPath:)]) {
        [self.delegate lgf_CenterChildPageVC:VC cell:cell indexPath:indexPath];
    }
}

- (void)lgf_CenterChildPageVC:(UIViewController *)VC didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:didSelectItemAtIndexPath:)]) {
        [self.delegate lgf_CenterChildPageVC:VC didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - Collection View DataSource And Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lgf_ChildVCArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.lgf_size;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.tag = indexPath.item;
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[indexPath.item];
    vc.view.frame = cell.bounds;
    [cell addSubview:vc.view];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[indexPath.item];
    if (vc.lgf_SelectIndex != self.lgf_SelectIndex) {
        if (self.lgf_HeaderSuperView.transform.ty > -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)) {
            if (vc.lgf_IsLoadData) {
                [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, self.lgf_OffsetY) animated:NO];
            }
            vc.lgf_OffsetY = self.lgf_OffsetY;
        } else {
            if (!vc.lgf_PageChildDataArray || vc.lgf_PageChildDataArray.count == 0) {
                if (vc.lgf_IsLoadData) {
                    [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -(self.lgf_PageTitleViewHeight)) animated:NO];
                }
                vc.lgf_OffsetY = -(self.lgf_PageTitleViewHeight);
            } else {
                if (vc.lgf_CenterChildPageCV.contentOffset.y < -(self.lgf_PageTitleViewHeight)) {
                    if (vc.lgf_IsLoadData) {
                        [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -(self.lgf_PageTitleViewHeight)) animated:NO];
                    }
                    vc.lgf_OffsetY = -(self.lgf_PageTitleViewHeight);
                }
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.lgf_CenterPageCV) {
        self.lgf_HeaderSuperView.userInteractionEnabled = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.lgf_CenterPageCV) {
        self.lgf_HeaderSuperView.userInteractionEnabled = YES;
    }
}

#pragma arguments LGFFreePTDelegate
- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex {
    self.lgf_SelectIndex = selectIndex;
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[selectIndex];
    if (vc.lgf_PageChildDataArray.count == 0) {
        if ([self.delegate respondsToSelector:@selector(lgf_CenterPageChildVCLoadData:selectIndex:loadType:)]) {
            [self.delegate lgf_CenterPageChildVCLoadData:vc selectIndex:selectIndex loadType:lgf_LoadData];
        }
    }
    
    [self lgf_AddPanGestureRecognizer];
}

- (void)lgf_AddPanGestureRecognizer {
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[self.lgf_SelectIndex];
    if (vc.lgf_PanScrollView) {
        [self.lgf_HeaderSuperView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.lgf_HeaderSuperView removeGestureRecognizer:obj];
        }];
        [self.lgf_HeaderSuperView addGestureRecognizer:vc.lgf_PanScrollView.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载/Set

- (NSMutableArray *)lgf_PageTitleArray {
    if (!_lgf_PageTitleArray) {
        _lgf_PageTitleArray = [NSMutableArray new];
    }
    return _lgf_PageTitleArray;
}

- (NSMutableArray *)lgf_ChildVCArray {
    if (!_lgf_ChildVCArray) {
        _lgf_ChildVCArray = [NSMutableArray new];
    }
    return _lgf_ChildVCArray;
}

- (LGFFreePTView*)lgf_PageTitleView {
    if (!_lgf_PageTitleView) {
        _lgf_PageTitleView = [[LGFFreePTView lgf]  lgf_InitWithStyle:self.lgf_PageTitleStyle SVC:self SV:self.lgf_PageTitleSuperViewForSB PV:self.lgf_CenterPageCV];
        _lgf_PageTitleView.lgf_FreePTDelegate = self;
    }
    return _lgf_PageTitleView;
}

@end
