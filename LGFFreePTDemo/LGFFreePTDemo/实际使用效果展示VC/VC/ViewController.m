//
//  ViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/4/28.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "ViewController.h"
#import "LGFFreePTStyleCenter.h"
#import "LGFFreePT.h"
#import "ChildViewController.h"
#import "colorSelectView.h"

@interface ViewController () <LGFFreePTDelegate>
@property (strong, nonatomic) LGFFreePTView *fptView;
@property (weak, nonatomic) IBOutlet UILabel *naviTitle;
@property (weak, nonatomic) IBOutlet UIView *pageSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageSuperViewHeight;
@property (weak, nonatomic) IBOutlet UIView *pageSuperViewSuperView;
@property (weak, nonatomic) IBOutlet UICollectionView *pageCollectionView;
@property (strong, nonatomic) NSMutableArray *chlidVCs;
@end

@implementation ViewController

lgf_SBViewControllerForM(ViewController, @"Main", @"ViewController");

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTitle.text = self.type;
    // 添加子控制器
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChildViewController *vc = [ChildViewController lgf];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.chlidVCs addObject:vc];
    }];
    // 刷新title数组
    self.fptView.lgf_Style.lgf_Titles = self.titles;
    if ([self.type isEqualToString:@"默认选中 index 5"]) {
        [self.fptView lgf_ReloadTitleAndSelectIndex:5 animated:YES];
    } else {
        [self.fptView lgf_ReloadTitle];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.pageSuperView.transform = CGAffineTransformMakeTranslation(0.0, 50.0);
    }];
}

#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chlidVCs.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.lgfpt_Size;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ChildViewController *vc = self.chlidVCs[indexPath.item];
    vc.view.frame = cell.bounds;
    [cell addSubview:vc.view];
    vc.view.backgroundColor = lgf_RandomColor;
    return cell;
}

#pragma mark - LGFFreePTView Delegate

- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_SuperEnabled = YES;
    style.lgf_BackBtnEnabled = YES;
    style.lgf_ToastMessage = [NSString stringWithFormat:@"第 %ld 页", (long)selectIndex];
    [self.view lgf_ShowMessageStyle:style animated:NO completion:^{
        
    }];
}

// 自定义 line 动画配置代理
- (void)lgf_FreePTViewCustomizeLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    CGFloat space = style.lgf_LineBottom + line.lgfpt_Height;
    if (progress > 0.5) {
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
        line.transform = CGAffineTransformIdentity;
        line.transform = CGAffineTransformMakeTranslation(0, space * (2.0 * (1.0 - progress)));
    } else {
        line.lgfpt_X = unSelectX;
        line.lgfpt_Width = unSelectWidth;
        line.transform = CGAffineTransformIdentity;
        line.transform = CGAffineTransformMakeTranslation(0, space + space * (1.0 - (2.0 * (1.0 - progress))));
    }
}

// 加载网络图片时候需要实现这个代理
- (void)lgf_GetNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl {
    [imageView sd_setImageWithURL:imageUrl];
}

#pragma mark - 懒加载
- (NSMutableArray *)chlidVCs {
    if (!_chlidVCs) {
        _chlidVCs = [NSMutableArray new];
    }
    return _chlidVCs;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = [NSArray new];
    }
    return _titles;
}

- (LGFFreePTView *)fptView {
    if (!_fptView) {
        LGFFreePTStyle *style;
        if ([self.type isEqualToString:@"普通"]) {
            style = [LGFFreePTStyleCenter one];
        } else if ([self.type isEqualToString:@"普通-底部线对准 title"]) {
            style = [LGFFreePTStyleCenter two];
        } else if ([self.type isEqualToString:@"普通-选中放大/缩小"]) {
            style = [LGFFreePTStyleCenter three];
        } else if ([self.type isEqualToString:@"毛毛虫"]) {
            style = [LGFFreePTStyleCenter four];
        } else if ([self.type isEqualToString:@"毛毛虫-底部线对准 title"]) {
            style = [LGFFreePTStyleCenter five];
        } else if ([self.type isEqualToString:@"毛毛虫-选中放大/缩小"]) {
            style = [LGFFreePTStyleCenter six];
        } else if ([self.type isEqualToString:@"添加左图片(加载网络图片示例)"]) {
            style = [LGFFreePTStyleCenter seven];
        } else if ([self.type isEqualToString:@"根据需求添加上下左右图片"]) {
            style = [LGFFreePTStyleCenter eight];
        } else if ([self.type isEqualToString:@"默认选中 index 5"]) {
            style = [LGFFreePTStyleCenter one];
        } else if ([self.type isEqualToString:@"父子标题-普通"]) {
            style = [LGFFreePTStyleCenter ten];
        } else if ([self.type isEqualToString:@"父子标题-加图片"]) {
            style = [LGFFreePTStyleCenter eleven];
        } else if ([self.type isEqualToString:@"父子标题-放大缩小"]) {
            style = [LGFFreePTStyleCenter twelve];
        } else if ([self.type isEqualToString:@"少标的时候默认居中"]) {
            style = [LGFFreePTStyleCenter one];
        } else if ([self.type isEqualToString:@"line 占满"]) {
            style = [LGFFreePTStyleCenter nine];
        } else if ([self.type isEqualToString:@"line 占满-图片"]) {
            style = [LGFFreePTStyleCenter thirteen];
        } else if ([self.type isEqualToString:@"line 占满-图片-毛毛虫"]) {
            style = [LGFFreePTStyleCenter fourteen];
        } else if ([self.type isEqualToString:@"模拟系统 UISegmentedControl"]) {
            self.pageSuperView.layer.borderWidth = 1.0;
            style = [LGFFreePTStyleCenter fifteen];
        } else if ([self.type isEqualToString:@"指定部分 index 添加特殊 title"]) {
            style = [LGFFreePTStyleCenter sixteen];
        } else if ([self.type isEqualToString:@"部分需求效果"]) {
            style = [LGFFreePTStyleCenter seventeen];
        } else if ([self.type isEqualToString:@"小乌龟"]) {
            style = [LGFFreePTStyleCenter eighteen];
        } else if ([self.type isEqualToString:@"小乌龟-底部线对准 title(自定义)"]) {
            style = [LGFFreePTStyleCenter nineteen];
        } else if ([self.type isEqualToString:@"小乌龟-选中放大/缩小"]) {
            style = [LGFFreePTStyleCenter twenty];
        } else if ([self.type isEqualToString:@"小乌龟反向"]) {
            style = [LGFFreePTStyleCenter twentyone];
        } else if ([self.type isEqualToString:@"渐隐效果"]) {
            style = [LGFFreePTStyleCenter twentytwo];
        }
        _fptView = [[LGFFreePTView lgf] lgf_InitWithStyle:style SVC:self SV:self.pageSuperView PV:self.pageCollectionView];
        _fptView.lgf_FreePTDelegate = self;
    }
    return _fptView;
}
@end
