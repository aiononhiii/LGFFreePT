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
    [self loadData];
}

- (void)loadData {
//    [self.titleArray removeAllObjects];
//    [self loadMoreData];
    [self.pageVC reloadPageTitleWidthArray:self.titles];
}

- (void)loadMoreData {
    [self.titleArray addObjectsFromArray:@[@"", @"", @"", @"", @"", @"", @"", @"", @"", @""]];
}

#pragma mark - 配置分页联动
- (void)configPage {
    self.pageVC = [LGFCenterPageVC lgf];
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_IsTitleCenter = YES;// title 少的时候默认居中
    style.lgf_TitleFixedWidth = 80.0;
    style.lgf_LineWidth = 80.0;
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_LineHeight = 4.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    self.pageVC.lgf_PageTitleStyle = style;
    self.pageVC.delegate = self;
    self.pageVC.lgf_HeaderHeight = 1100 + 50 + self.headerTop.constant;
    self.pageVC.lgf_PageTitleViewHeight = 50 + self.headerTop.constant;
    self.pageVC.lgf_HeaderView = self.headerView;
    [self.pageVC lgf_ShowInVC:self view:self.pageView];
}

#pragma mark - LGFCenterPageChildVC Delegate

- (void)lgf_CenterPageChildVCLoadData:(LGFCenterPageChildVC *)VC selectIndex:(NSInteger)selectIndex loadType:(lgf_LoadType)loadType {
    if (loadType == lgf_LoadData) [self.view lgf_ShowToastActivity:UIEdgeInsetsZero isClearBack:YES cornerRadius:0 style:UIActivityIndicatorViewStyleGray];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *datas = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @""];
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
//    vc.lgf_PageCVBottom = 49;
}

- (NSInteger)lgf_NumberOfItems:(LGFCenterPageChildVC *)VC {
    return VC.lgf_PageChildDataArray.count;
}

- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath VC:(LGFCenterPageChildVC *)VC {
    return CGSizeMake(lgf_ScreenWidth / 2, (lgf_ScreenWidth / 2) * 1.4);
}

- (Class)lgf_CenterChildPageCVCellClass:(LGFCenterPageChildVC *)VC {
    return [TaoBaoCell class];
}

- (void)lgf_CenterChildPageVC:(LGFCenterPageChildVC *)VC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    TaoBaoCell *bcell = (TaoBaoCell *)cell;
    [bcell.good setImage:lgf_Image(@"taobao_cell1.png")];
    
}

- (void)lgf_CenterChildPageVC:(LGFCenterPageChildVC *)VC didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
