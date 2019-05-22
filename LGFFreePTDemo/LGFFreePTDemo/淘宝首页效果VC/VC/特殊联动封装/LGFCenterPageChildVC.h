//
//  pageChildVC.h
//  LGFOCTool
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFCenterPageVC.h"
#import "UIScrollView+LGFPageRefresh.h"

typedef NS_ENUM(NSUInteger, lgf_ChildLoadType) {
    lgf_ChildLoadData,
    lgf_ChildLoadMoreData,
};

@protocol LGFCenterPageChildVCDelegate <NSObject>
// lgf_CenterPageChildCV 子控制器加载数据
- (void)lgf_CenterPageChildVCLoadData:(UIViewController *)VC selectIndex:(NSInteger)selectIndex loadType:(lgf_ChildLoadType)loadType;
// 配置内部 centerPageChildVC
- (void)lgf_CenterChildPageVCDidLoad:(UIViewController *)VC;
// 返回 cell 个数
- (NSInteger)lgf_NumberOfItems:(UIViewController *)VC;
// 返回 cell 大小
- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath VC:(UIViewController *)VC;
// 返回 cellclass 用于注册cell 如果是xibcell 请建立与 cellclass 相同名字的 xib
- (Class)lgf_CenterChildPageCVCellClass:(UIViewController *)centerPageChildVC;
// cell 数据源赋值
- (void)lgf_CenterChildPageVC:(UIViewController *)VC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
// cell 点击事件
- (void)lgf_CenterChildPageVC:(UIViewController *)VC didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface LGFCenterPageChildVC : UIViewController
@property (nonatomic, weak, nullable) id <LGFCenterPageChildVCDelegate> delegate;
// 内部子控制器 UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *lgf_CenterChildPageCV;
// 用于控制联动的 空白ScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *lgf_PanScrollView;
// 外部分页滚动 UICollectionView
@property (strong, nonatomic) UICollectionView *lgf_CenterPageCV;
@property (strong, nonatomic) NSMutableArray *lgf_PageChildDataArray;
@property (strong, nonatomic) NSMutableArray *lgf_PageChildDataHeightArray;
// 父控制器传进来的
@property (strong, nonatomic) UIView *lgf_HeaderTapView;
@property (strong, nonatomic) UIView *lgf_HeaderSuperView;
@property (strong, nonatomic) UIView *LGFCenterPageView;
@property (nonatomic, assign) NSInteger lgf_SelectIndex;
@property (nonatomic, assign) NSInteger lgf_SuperSelectIndex;
@property (nonatomic, assign) CGFloat lgf_HeaderHeight;
@property (nonatomic, assign) CGFloat lgf_PageTitleViewHeight;
@property (assign, nonatomic) CGFloat lgf_OffsetY;
@property (assign, nonatomic) BOOL lgf_PageTitleViewIsCenter;
@property (assign, nonatomic) BOOL lgf_IsGreaterFullContentSize;
@property (assign, nonatomic) BOOL lgf_IsLoadData;
@property (assign, nonatomic) NSInteger lgf_Page;
@property (assign, nonatomic) CGFloat lgf_PageCVBottom;

lgf_SBViewControllerForH;
// 同步 lgf_PanScrollView 和 lgf_CenterChildPageCV 的 ContentSize
- (void)lgf_SynContentSize;
- (void)lgf_ChildLoadData;
@end
