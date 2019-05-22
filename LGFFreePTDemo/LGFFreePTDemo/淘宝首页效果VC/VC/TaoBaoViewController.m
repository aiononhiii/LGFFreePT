//
//  TaoBaoViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/20.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "TaoBaoViewController.h"
#import "LGFCenterPageVC.h"
#import "LGFCenterPageChildVC.h"
#import "TaoBaoCell.h"
#import "LoveView.h"

@interface TaoBaoViewController ()<LGFCenterPageVCDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTop;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (strong, nonatomic) LGFCenterPageVC *pageVC;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation TaoBaoViewController

lgf_SBViewControllerForM(TaoBaoViewController, @"Main", @"TaoBaoViewController")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerTop.constant = IPhoneX_NAVIGATION_BAR_HEIGHT + 30;
    [self configPage];
    [lgf_NCenter addObserver:self selector:@selector(childScroll:) name:@"LGFChildScroll" object:nil];
}

#pragma mark - 配置分页联动
- (void)configPage {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_TitleFixedWidth = 80.0;
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_LineWidth = 52.0;
    style.lgf_LineHeight = 15.0;
    style.lgf_LineBottom = 12.5;
    style.lgf_LineCornerRadius = 7.5;
    style.lgf_TitleSelectFont = [UIFont systemFontOfSize:15];
    style.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:15];
    style.lgf_SubTitleSelectFont = [UIFont systemFontOfSize:11];
    style.lgf_UnSubTitleSelectFont = [UIFont systemFontOfSize:11];
    style.lgf_SubTitleTopSpace = 2;
    style.lgf_LineColor = lgf_RGBColor(255, 0, 45, 1);
    style.lgf_TitleSelectColor = lgf_RGBColor(255, 0, 45, 1);
    style.lgf_UnTitleSelectColor = lgf_RGBColor(62, 62, 62, 1);
    style.lgf_SubTitleSelectColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_UnSubTitleSelectColor = lgf_RGBColor(138, 138, 138, 1);
    style.lgf_IsDoubleTitle = YES;
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    
    [LoveView lgf].lgf_FreePTSpecialTitleProperty = @"1/80";
    style.lgf_FreePTSpecialTitleArray = @[[LoveView lgf]];
    
    self.pageVC = [LGFCenterPageVC lgf];
    self.pageVC.view.backgroundColor = lgf_RGBColor(243, 243, 243, 1);
    self.pageVC.lgf_PageTitleStyle = style;
    self.pageVC.delegate = self;
    self.pageVC.lgf_NavigationBarHeight = IPhoneX_NAVIGATION_BAR_HEIGHT + 30;// navigationBar 高度
    self.pageVC.lgf_HeaderHeight = 1090 + 60;// header 高度 + LGFFreePTView 高度
    self.pageVC.lgf_PageTitleViewHeight = 60;// LGFFreePTView 高度
    self.pageVC.lgf_HeaderView = self.headerView;
    [self.pageVC lgf_ShowInVC:self view:self.pageView];
    [self.pageVC reloadPageTitleWidthArray:self.titles];
}

#pragma mark - 内部滚动监听
- (void)childScroll:(NSNotification *)noti {
//    CGFloat offsetY = [noti.object[0] floatValue];
//    if (offsetY > -154) {
//        self.pageVC.lgf_PageTitleViewHeight = 60 + self.pageVC.lgf_NavigationBarHeight - MIN(15, (offsetY + 154));
//        self.pageVC.lgf_PageTitleSuperViewHeight.constant = self.pageVC.lgf_PageTitleViewHeight - self.pageVC.lgf_NavigationBarHeight;
//        self.pageVC.lgf_PageTitleSuperViewForSB.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:(MIN(15, (offsetY + 154)) / 15)];
//    } else {
//        self.pageVC.lgf_PageTitleViewHeight = 60 + self.pageVC.lgf_NavigationBarHeight;
//        self.pageVC.lgf_PageTitleSuperViewHeight.constant = self.pageVC.lgf_PageTitleViewHeight - self.pageVC.lgf_NavigationBarHeight;
//        self.pageVC.lgf_PageTitleSuperViewForSB.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
//    }
}

#pragma mark - LGFCenterPageChildVC Delegate

- (void)lgf_CenterPageChildVCLoadData:(LGFCenterPageChildVC *)VC selectIndex:(NSInteger)selectIndex loadType:(lgf_LoadType)loadType {
    if (loadType == lgf_LoadData) [self.view lgf_ShowToastActivity:UIEdgeInsetsZero isClearBack:YES cornerRadius:0 style:UIActivityIndicatorViewStyleGray];
    // 模拟异步请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *datas = [[NSMutableArray new] lgf_CreatDentical:@"" count:25];
        if (VC.lgf_Page == 1) {
            VC.lgf_PageChildDataArray = [NSMutableArray arrayWithArray:datas];
        } else {
            [VC.lgf_PageChildDataArray addObjectsFromArray:datas];
        }
        [VC.lgf_CenterChildPageCV reloadData];
        [VC lgf_SynContentSize];
        if (datas.count > 0) VC.lgf_Page++;
        [VC.lgf_CenterChildPageCV lgf_PageEndRefreshing];
        [VC.lgf_PanScrollView lgf_PageEndRefreshing];
        [self.view lgf_HideToastActivity];
    });
}

- (void)lgf_CenterChildPageVCDidLoad:(LGFCenterPageChildVC *)VC {
    VC.lgf_PageCVBottom = 49;
}

- (NSInteger)lgf_NumberOfItems:(LGFCenterPageChildVC *)VC {
    return VC.lgf_PageChildDataArray.count;
}

- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath VC:(LGFCenterPageChildVC *)VC {
    return CGSizeMake(lgf_ScreenWidth / 2, (lgf_ScreenWidth / 2) * (indexPath.item % (indexPath.item / 2) == 0 ? 0.8 : 1.0));
}

- (Class)lgf_CenterChildPageCVCellClass:(LGFCenterPageChildVC *)VC {
    return [TaoBaoCell class];
}

- (void)lgf_CenterChildPageVC:(LGFCenterPageChildVC *)VC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    TaoBaoCell *bcell = (TaoBaoCell *)cell;
    if (indexPath.item % (indexPath.item / 2) == 0) {
        [bcell.good setImage:lgf_Image(@"taobao_cell_one")];
    } else {
        [bcell.good setImage:lgf_Image(@"taobao_cell_two")];
    }
    
}

- (void)lgf_CenterChildPageVC:(LGFCenterPageChildVC *)VC didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 处理 特殊标 动画
- (void)lgf_RealSelectFreePTTitle:(NSInteger)selectIndex {
    if (selectIndex == 1) {
        [LoveView lgf].subTitle.textColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.45 initialSpringVelocity:0.45 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [LoveView lgf].image.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [LoveView lgf].subTitle.textColor = lgf_RGBColor(138, 138, 138, 1);
        [UIView animateWithDuration:0.3 animations:^{
            [LoveView lgf].image.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _titleArray;
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}

@end
