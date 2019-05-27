//
//  VerticalViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "VerticalViewController.h"
#import "VerticalViewControllerReusableView.h"
#import "VerticalViewControllerCell.h"
#import "VerticalViewControllerThreeCell.h"
#import "VerticalViewControllerOneCell.h"
#import "LGFFreePT.h"

@interface VerticalViewController () <LGFFreePTDelegate>
@property (strong, nonatomic) LGFFreePTView *fptView;
@property (weak, nonatomic) IBOutlet UIView *pageSuperView;
@property (strong, nonatomic) IBOutlet UIView *pageSuperViewSuperView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewOne;
@property (weak, nonatomic) IBOutlet UIView *collectionViewOneBack;
@property (strong, nonatomic) IBOutlet UIView *collectionViewFiveBack;
@property (weak, nonatomic) IBOutlet UIView *latelyView;
@property (weak, nonatomic) IBOutlet UIView *recommendView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewTwo;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewThree;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFour;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFive;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (assign, nonatomic) CGFloat headerHeight;
// 我的应用数据源数组
@property (strong, nonatomic) NSMutableArray *myDataArray;
// 最近使用数据源数组
@property (strong, nonatomic) NSMutableArray *latelyDataArray;
// 底下数据源数组
@property (strong, nonatomic) NSMutableArray *dataArray;
// 记录用于滚动选择判断的 contentOffset.y
@property (strong, nonatomic) NSMutableArray *pageSelectYArray;
// 是否编辑
@property (assign, nonatomic) BOOL isEdit;
@property (assign, nonatomic) BOOL isSelectTitle;
@end

@implementation VerticalViewController

lgf_SBViewControllerForM(VerticalViewController, @"Main", @"VerticalViewController");

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDataArray = @[@"转账", @"信用卡还款", @"淘票票电影", @"花呗", @"滴滴出行", @"饿了么外卖", @"蚂蚁庄园", @"蚂蚁森林", @"充值中心", @"我的快递"].mutableCopy;
    
    self.latelyDataArray = @[@"生活缴费", @"城市服务", @"车主服务", @"红包", @"商家服务", @"发票管家", @"借呗", @"更多"].mutableCopy;
    
    self.dataArray = @[@{@"便民生活" : @[@"充值中心", @"信用卡还款", @"生活缴费", @"城市服务", @"我的快递", @"医疗健康", @"记账本", @"发票管家", @"车主服务", @"交通出行", @"体育服务", @"安全备忘"]},
                       @{@"财富管理" : @[@"余额宝", @"花呗", @"芝麻信用", @"借呗", @"蚂蚁保险", @"汇率换算"]},
                       @{@"资金往来" : @[@"转账", @"红包", @"AA收款", @"亲情号", @"商家服务"]},
                       @{@"购物娱乐" : @[@"出境", @"彩票", @"奖励金"]},
                       @{@"教育公益" : @[@"校园生活", @"蚂蚁森林", @"蚂蚁庄园", @"中小学", @"运动", @"亲子账户"]},
                       @{@"第三方服务" : @[@"淘票票电影", @"滴滴出行", @"饿了么外卖", @"天猫", @"淘宝", @"火车票机票", @"飞猪酒店", @"蚂上租租房", @"高德打车", @"哈啰出行"]}].mutableCopy;
    
    // 计算需要选中的 contentOffset.y 保存
    __block CGFloat oldY = 0.0;
    __block CGFloat newY = 0.0;
    [self.dataArray enumerateObjectsUsingBlock:^(NSMutableDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *items = [obj allValues].firstObject;
        NSInteger num = ceilf(items.count / 4.0);
        newY = newY + (idx == 0 ? 10.0 : 50.0) + num * 70.0;
        [self.pageSelectYArray addObject:@[@(oldY), @(newY)]];
        oldY = oldY + (idx == 0 ? 10.0 : 50.0) + num * 70.0;
    }];
    
    // 刷新title数组
    self.fptView.lgf_Style.lgf_Titles = self.titles;
    [self.fptView lgf_ReloadTitleAndSelectIndex:0 isExecutionDelegate:NO animated:NO];
    [self setHeader];
}

#pragma mark - 头部视图配置
- (void)setHeader {
    // 设置头高度（可动态适配，我这边只用于示例代码因此是写死的高度）
    self.headerHeight = 454.0 + 10.0;
    // 添加头
    self.headerView.frame = CGRectMake(0.0, -self.headerHeight, lgf_ScreenWidth, self.headerHeight);
    [self.collectionViewFour addSubview:self.headerView];
    [self.collectionViewFour sendSubviewToBack:self.headerView];
    // 添加 LGFFreePTView 父控件
    self.pageSuperViewSuperView.frame = CGRectMake(0.0, -10.0, lgf_ScreenWidth, 48.0);
    [self.collectionViewFour addSubview:self.pageSuperViewSuperView];
    
    [self setCVContentInset:0.0];
}

- (void)setCVContentInset:(CGFloat)top {
    CGFloat lastY = lgf_ScreenHeight - IPhoneX_NAVIGATION_BAR_HEIGHT - 40 - ([[[self.pageSelectYArray lastObject] lastObject] floatValue] - [[[self.pageSelectYArray lastObject] firstObject] floatValue] + top);
    [self.collectionViewFour setContentInset:UIEdgeInsetsMake(self.headerHeight, 0.0, lastY, 0.0)];
    [self.collectionViewFour lgf_ScrollToTopAnimated:NO];
}

#pragma mark - 编辑
- (IBAction)edit:(UIButton *)sender {
    self.isEdit = !self.isEdit;
    // 编辑动画
    if (self.isEdit) {
        // 在 headerView 上添加我的应用 CV
        self.collectionViewFiveBack.frame = CGRectMake(0.0, 0.0, lgf_ScreenWidth, 250.0);
        [self.headerView addSubview:self.collectionViewFiveBack];
        [self.headerView insertSubview:self.collectionViewFiveBack belowSubview:self.latelyView];
        [self setCVContentInset:258.0];
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionViewOneBack.transform = CGAffineTransformMakeTranslation(0, 20);
            self.latelyView.transform = CGAffineTransformMakeTranslation(0, self.collectionViewFive.lgf_height);
            self.recommendView.transform = CGAffineTransformMakeTranslation(0, self.collectionViewFive.lgf_height);
            self.collectionViewOneBack.alpha = 0.0;
            self.recommendView.alpha = 0.0;
            self.editButton.alpha = 0.0;
            self.completeButton.alpha = 1.0;
            self.collectionViewFive.transform = CGAffineTransformMakeTranslation(0, 10);
            self.collectionViewFiveBack.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.headerView.backgroundColor = lgf_HexColor(@"F5F4FB");
            // 在 collectionViewFour 上添加我的应用 CV
            [self.collectionViewFiveBack removeFromSuperview];
            self.collectionViewFiveBack.frame = CGRectMake(0.0, -self.headerHeight, lgf_ScreenWidth, 250.0);
            [self.collectionViewFour addSubview:self.collectionViewFiveBack];
            [self goEdit:^(BOOL finished) {
                
            }];
        }];
    } else {
        self.headerView.backgroundColor = lgf_HexColor(@"FFFFFF");
        [self.fptView lgf_SelectIndex:0 duration:0.1 autoScrollDuration:0.25];
        [self setCVContentInset:0];
        [self goEdit:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.collectionViewFive.transform = CGAffineTransformIdentity;
                self.collectionViewFiveBack.alpha = 0.0;
                self.collectionViewOneBack.transform = CGAffineTransformIdentity;
                self.collectionViewOneBack.alpha = 1.0;
                self.editButton.alpha = 1.0;
                self.completeButton.alpha = 0.0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.latelyView.transform = CGAffineTransformIdentity;
                    self.recommendView.transform = CGAffineTransformIdentity;
                    self.recommendView.alpha = 1.0;
                } completion:^(BOOL finished) {
                    [self.collectionViewFiveBack removeFromSuperview];
                }];
            }];
        }];
    }
}

- (void)goEdit:(void (^ __nullable)(BOOL finished))completion {
    [UIView animateWithDuration:0.3 animations:^{
        for (VerticalViewControllerCell *cell in self.collectionViewTwo.visibleCells) {
            cell.isEdit = self.isEdit;
        }
        for (VerticalViewControllerCell *cell in self.collectionViewFour.visibleCells) {
            cell.isEdit = self.isEdit;
        }
    } completion:^(BOOL finished) {
        lgf_HaveBlock(completion, finished);
    }];
}

#pragma mark - Collection View DataSource And Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.collectionViewFour) {
        return self.titles.count;
    }
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    view.layer.zPosition = 0.0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && collectionView == self.collectionViewFour) {
        VerticalViewControllerReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"VerticalViewControllerReusableView" forIndexPath:indexPath];
        header.title.text = self.titles[indexPath.section];
        if (indexPath.section == 0) {
            header.lgf_height = 0.0;
        } else {
            header.lgf_height = 40.0;
        }
        return header;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.collectionViewOne) {
        return 6;
    } else if (collectionView == self.collectionViewTwo) {
        return self.latelyDataArray.count;
    } else if (collectionView == self.collectionViewThree) {
        return 10;
    } else if (collectionView == self.collectionViewFive) {
        return self.myDataArray.count;
    }
    NSArray *items = [self.dataArray[section] allValues].firstObject;
    return items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionViewOne) {
        return CGSizeMake(collectionView.lgf_width / 6.0, collectionView.lgf_height);
    } else if (collectionView == self.collectionViewTwo) {
        return CGSizeMake(lgf_ScreenWidth / 4.0, 140.0 / 2.0);
    } else if (collectionView == self.collectionViewThree) {
        return CGSizeMake(collectionView.lgf_width / 3.1, collectionView.lgf_height);
    } else if (collectionView == self.collectionViewFive) {
        return CGSizeMake(lgf_ScreenWidth / 4.0, 140.0 / 2.0);
    }
    return CGSizeMake(lgf_ScreenWidth / 4.0, 140.0 / 2.0);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionViewOne) {
        VerticalViewControllerOneCell *cell = lgf_CVGetCell(collectionView, VerticalViewControllerOneCell, indexPath);
        cell.imageName = self.myDataArray[indexPath.item];
        return cell;
    } else if (collectionView == self.collectionViewTwo) {
        VerticalViewControllerCell *cell = lgf_CVGetCell(collectionView, VerticalViewControllerCell, indexPath);
        cell.title.text = self.latelyDataArray[indexPath.item];
        cell.isEdit = self.isEdit;
        cell.imageName = cell.title.text;
        return cell;
    } else if (collectionView == self.collectionViewThree) {
        VerticalViewControllerThreeCell *cell = lgf_CVGetCell(collectionView, VerticalViewControllerThreeCell, indexPath);
        return cell;
    } else if (collectionView == self.collectionViewFive) {
        VerticalViewControllerCell *cell = lgf_CVGetCell(collectionView, VerticalViewControllerCell, indexPath);
        cell.title.text = self.myDataArray[indexPath.item];
        cell.imageName = cell.title.text;
        return cell;
    }
    VerticalViewControllerCell *cell = lgf_CVGetCell(collectionView, VerticalViewControllerCell, indexPath);
    cell.title.text = [self.dataArray[indexPath.section] allValues].firstObject[indexPath.item];
    cell.isEdit = self.isEdit;
    cell.imageName = cell.title.text;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionViewFour) {
        NSLog(@"%f", scrollView.contentOffset.y);
        // 这一句用于设置 pageSuperViewSuperView 顶端悬停效果
        self.pageSuperViewSuperView.lgf_y = MAX(-18.0, self.isEdit ?  (scrollView.contentOffset.y + 250.0) : (scrollView.contentOffset.y - 8.0));
        // 我的应用 view 因为是添加在 CV 上因此也需要做悬停处理，加上 MIN 防止下拉时跟随，就和支付宝首页的效果差不多
        self.collectionViewFiveBack.lgf_y = MIN(MAX(-self.headerHeight, scrollView.contentOffset.y), scrollView.contentOffset.y);
        if (!self.isSelectTitle) {// 是否是手指滚动触发
            [self.pageSelectYArray enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat realY = self.isEdit ? (scrollView.contentOffset.y + 250.0 + 8.0) : scrollView.contentOffset.y;
                if (realY > [obj.firstObject floatValue] && realY < [obj.lastObject floatValue]) {
                    // 根据 contentOffset.y 选中某个 title
                    [self.fptView lgf_SelectIndex:idx duration:0.1 autoScrollDuration:0.25];
                }
            }];
        }
        for (VerticalViewControllerCell *cell in self.collectionViewFour.visibleCells) {
            if (cell.isEdit != self.isEdit) {
                cell.isEdit = self.isEdit;
            }
        }
    }
}

#pragma mark - LGFFreePTView Delegate
- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex {
    // 选中滚动
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(configIsSelectTitle) object:nil];
    self.isSelectTitle = YES;
    [self.collectionViewFour setContentOffset:CGPointMake(0, [[self.pageSelectYArray[selectIndex] firstObject] floatValue] - (self.isEdit ? 250.0 + 8.0 : 0.0)) animated:YES];
    [self performSelector:@selector(configIsSelectTitle) withObject:nil afterDelay:0.3];
}

- (void)configIsSelectTitle {
    self.isSelectTitle = NO;
}

#pragma mark - 懒加载
- (NSMutableArray *)latelyDataArray {
    if (!_latelyDataArray) {
        _latelyDataArray = [NSMutableArray new];
    }
    return _latelyDataArray;
}

- (NSMutableArray *)myDataArray {
    if (!_myDataArray) {
        _myDataArray = [NSMutableArray new];
    }
    return _myDataArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)pageSelectYArray {
    if (!_pageSelectYArray) {
        _pageSelectYArray = [NSMutableArray new];
    }
    return _pageSelectYArray;
}

- (LGFFreePTView *)fptView {
    if (!_fptView) {
        // 支付宝效果配置
        LGFFreePTStyle *style = [LGFFreePTStyle lgf];
        style.lgf_LineWidthType = lgf_EqualTitleSTR;// 底部线对准字
        style.lgf_TitleLeftRightSpace = 10.0;
        style.lgf_LineHeight = 2.0;
        style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:16];
        style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:16];
        style.lgf_LineColor = lgf_RGBColor(15.0, 143.0, 233.0, 1.0);
        style.lgf_TitleSelectColor = lgf_RGBColor(15.0, 143.0, 233.0, 1.0);
        style.lgf_UnTitleSelectColor = LGFPTHexColor(@"333333");
        style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
        style.lgf_TitleScrollToTheMiddleAnimationDuration = 0.2;
        _fptView = [[LGFFreePTView lgf] lgf_InitWithStyle:style SVC:self SV:self.pageSuperView PV:nil];
        _fptView.lgf_FreePTDelegate = self;
    }
    return _fptView;
}
@end
