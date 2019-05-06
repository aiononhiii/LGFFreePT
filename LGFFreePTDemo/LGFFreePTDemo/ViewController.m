//
//  ViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/4/28.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "ViewController.h"
#import "LGFFreePTStyleCenter.h"
#import "ChildViewController.h"

@interface ViewController ()
@property (strong, nonatomic) LGFFreePTView *fptView;
@property (weak, nonatomic) IBOutlet UIView *pageSuperView;
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
    
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChildViewController *vc = [ChildViewController lgf];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.chlidVCs addObject:vc];
    }];
    // 刷新title数组
    self.fptView.lgf_Style.lgf_Titles = self.titles;
    if ([self.type isEqualToString:@"默认选中 index 5"]) {
        [self.fptView lgf_ReloadTitleAndSelectIndex:5];
    } else {
        [self.fptView lgf_ReloadTitle];
    }
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
        } else if ([self.type isEqualToString:@"根据需求添加左图片"]) {
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
        }
        _fptView = [[LGFFreePTView lgf] lgf_InitWithStyle:style SVC:self SV:self.pageSuperView PV:self.pageCollectionView];
    }
    return _fptView;
}
@end
