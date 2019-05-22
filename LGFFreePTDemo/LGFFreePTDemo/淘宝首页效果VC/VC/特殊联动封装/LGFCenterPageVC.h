//
//  LGFCenterPageVC.h
//  LGFOCTool
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFFreePT.h"

typedef NS_ENUM(NSUInteger, lgf_LoadType) {
    lgf_LoadData,
    lgf_LoadMoreData,
};

@protocol LGFCenterPageVCDelegate <NSObject>
// 精确 select index
- (void)lgf_RealSelectFreePTTitle:(NSInteger)selectIndex;
// lgf_CenterPageChildCV 子控制器加载数据
- (void)lgf_CenterPageChildVCLoadData:(UIViewController *)VC selectIndex:(NSInteger)selectIndex loadType:(lgf_LoadType)loadType;
// 配置内部 centerPageChildVC
- (void)lgf_CenterChildPageVCDidLoad:(UIViewController *)VC;
// 返回 cell 个数
- (NSInteger)lgf_NumberOfItems:(UIViewController *)VC;
// 返回 cell 大小
- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath VC:(UIViewController *)VC;
// 返回 cellclass 用于注册cell 如果是xibcell 请建立与 cellclass 相同名字的 xib
- (Class)lgf_CenterChildPageCVCellClass:(UIViewController *)VC;
// cell 数据源赋值
- (void)lgf_CenterChildPageVC:(UIViewController *)VC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
// cell 点击事件
- (void)lgf_CenterChildPageVC:(UIViewController *)VC didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface LGFCenterPageVC : UIViewController
@property (nonatomic, weak, nullable) id <LGFCenterPageVCDelegate> delegate;
@property (strong, nonatomic) LGFFreePTStyle *lgf_PageTitleStyle;
// header view
@property (strong, nonatomic) UIView *lgf_HeaderView;
// header view 高度
@property (assign, nonatomic) CGFloat lgf_HeaderHeight;
// page title view 高度
@property (assign, nonatomic) CGFloat lgf_PageTitleViewHeight;
// navigation bar 高度
@property (assign, nonatomic) CGFloat lgf_NavigationBarHeight;
// 分页滚动 UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *lgf_CenterPageCV;
// header view
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderViewForSB;
// lgf_PageTitleView 父控件(superview)
@property (strong, nonatomic) IBOutlet UIView *lgf_PageTitleSuperViewForSB;
// 头部父控件
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderSuperView;
// 联动点击view
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderTapView;
// header view 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_PageTitleSuperViewHeight;
// 分页控件 底部分割线 根据 contentOffset.y 自动显示
@property (weak, nonatomic) IBOutlet UIView *lgf_PageTitleSuperViewLine;
// 分页控件
@property (strong, nonatomic) LGFFreePTView *lgf_PageTitleView;
// 子控制器记录用 contentOffset.y
@property (nonatomic, assign) CGFloat lgf_OffsetY;
// 当前选择子控制器 selectIndex
@property (nonatomic, assign) NSInteger lgf_SelectIndex;
// page title 数组
@property (nonatomic, strong) NSMutableArray *lgf_PageTitleArray;
// 子控制器数组
@property (nonatomic, strong) NSMutableArray *lgf_ChildVCArray;
lgf_SBViewControllerForH;
- (void)lgf_ShowInVC:(UIViewController *)VC view:(UIView *)view;
- (void)reloadPageTitleWidthArray:(NSMutableArray *)dataArray;
@end
