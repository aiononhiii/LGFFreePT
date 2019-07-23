//
//  CustomViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/15.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "CustomViewController.h"
#import "LGFFreePTStyleCenter.h"
#import "LGFFreePT.h"
#import "ChildViewController.h"
#import "colorSelectView.h"
#import "StyleDemoViewController.h"
#import "customDataSourceView.h"

@interface CustomViewController () <LGFFreePTDelegate>
@property (strong, nonatomic) LGFFreePTView *fptView;
@property (weak, nonatomic) IBOutlet UILabel *naviTitle;
@property (weak, nonatomic) IBOutlet UIView *pageSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageSuperViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *pageCollectionView;
@property (strong, nonatomic) NSMutableArray *chlidVCs;

// 自定义配置区域
@property (weak, nonatomic) IBOutlet UIScrollView *toolScrollView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UITextField *lgf_UnTitleSelectColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_UnTitleSelectColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleSelectColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_TitleSelectColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_UnSubTitleSelectColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_UnSubTitleSelectColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_SubTitleSelectColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_SubTitleSelectColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleBackgroundColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_TitleBackgroundColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_LineColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleBorderColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_TitleBorderColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleBorderWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_PVTitleViewBackgroundColor;
@property (weak, nonatomic) IBOutlet UIView *lgf_PVTitleViewBackgroundColorView;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleSelectFont;
@property (weak, nonatomic) IBOutlet UITextField *lgf_UnTitleSelectFont;
@property (weak, nonatomic) IBOutlet UITextField *lgf_SubTitleSelectFont;
@property (weak, nonatomic) IBOutlet UITextField *lgf_UnSubTitleSelectFont;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleTransformSX;
@property (weak, nonatomic) IBOutlet UITextField *lgf_MainTitleTransformSX;
@property (weak, nonatomic) IBOutlet UITextField *lgf_MainTitleTransformTY;
@property (weak, nonatomic) IBOutlet UIButton *lgf_MainTitleTransformTYPlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_MainTitleTransformTX;
@property (weak, nonatomic) IBOutlet UIButton *lgf_MainTitleTransformTXPlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_SubTitleTransformSX;
@property (weak, nonatomic) IBOutlet UITextField *lgf_SubTitleTransformTY;
@property (weak, nonatomic) IBOutlet UIButton *lgf_SubTitleTransformTYPlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_SubTitleTransformTX;
@property (weak, nonatomic) IBOutlet UIButton *lgf_SubTitleTransformTXPlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineCenterX;
@property (weak, nonatomic) IBOutlet UIButton *lgf_LineCenterXPlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineHeight;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineBottom;
@property (weak, nonatomic) IBOutlet UIButton *lgf_LineBottomPlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineAlpha;
@property (weak, nonatomic) IBOutlet UITextField *lgf_SubTitleTopSpace;
@property (weak, nonatomic) IBOutlet UIButton *lgf_SubTitleTopSpacePlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleClickAnimationDuration;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleScrollToTheMiddleAnimationDuration;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleFixedWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleLeftRightSpace;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TitleCornerRadius;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TopImageSpace;
@property (weak, nonatomic) IBOutlet UIButton *lgf_TopImageSpacePlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TopImageWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_TopImageHeight;
@property (weak, nonatomic) IBOutlet UITextField *lgf_BottomImageSpace;
@property (weak, nonatomic) IBOutlet UIButton *lgf_BottomImageSpacePlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_BottomImageWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_BottomImageHeight;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LeftImageSpace;
@property (weak, nonatomic) IBOutlet UIButton *lgf_LeftImageSpacePlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LeftImageWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LeftImageHeight;
@property (weak, nonatomic) IBOutlet UITextField *lgf_RightImageSpace;
@property (weak, nonatomic) IBOutlet UIButton *lgf_RightImageSpacePlusMinus;
@property (weak, nonatomic) IBOutlet UITextField *lgf_RightImageWidth;
@property (weak, nonatomic) IBOutlet UITextField *lgf_RightImageHeight;
@property (weak, nonatomic) IBOutlet UITextField *lgf_LineCornerRadius;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_TitleHaveAnimation;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_IsShowLine;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_IsTitleCenter;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_IsDoubleTitle;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_IsLineAlignSubTitle;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_StartDebug;
@property (weak, nonatomic) IBOutlet UISwitch *lgf_IsExecutedImmediatelyTitleScrollFollow;
@property (weak, nonatomic) IBOutlet UIPickerView *lgf_LineAnimation;
@property (weak, nonatomic) IBOutlet UILabel *lgf_LineAnimationDescribe;
@property (weak, nonatomic) IBOutlet UIPickerView *lgf_TitleScrollFollowType;
@property (weak, nonatomic) IBOutlet UILabel *lgf_TitleScrollFollowTypeDescribe;
@property (weak, nonatomic) IBOutlet UIPickerView *lgf_PVAnimationType;
@property (weak, nonatomic) IBOutlet UILabel *lgf_PVAnimationTypeDescribe;
@property (weak, nonatomic) IBOutlet UIPickerView *lgf_LineWidthType;
@property (weak, nonatomic) IBOutlet UILabel *lgf_LineWidthTypeDescribe;
@property (nonatomic, assign) NSInteger lgf_LineAnimationInt;
@property (nonatomic, assign) NSInteger lgf_TitleScrollFollowTypeInt;
@property (nonatomic, assign) NSInteger lgf_PVAnimationTypeInt;
@property (nonatomic, assign) NSInteger lgf_LineWidthTypeInt;
@property (weak, nonatomic) IBOutlet UISwitch *setlgf_ImageNames;
@property (weak, nonatomic) IBOutlet UISwitch *setlgf_LineImageName;
@property (weak, nonatomic) IBOutlet UITextField *lgf_PageLeftRightSpace;
@property (weak, nonatomic) IBOutlet UITextField *LGFFreePTSuperViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *LGFFreePTSuperViewBorderColor;
@property (weak, nonatomic) IBOutlet UIView *LGFFreePTSuperViewBorderColorView;
@property (weak, nonatomic) IBOutlet UITextField *LGFFreePTSuperViewBorderWidth;
// 枚举类型展示用数据源
@property (nonatomic, copy) NSArray *lgf_LineAnimationArray;
@property (nonatomic, copy) NSArray *lgf_TitleScrollFollowTypeArray;
@property (nonatomic, copy) NSArray *lgf_PVAnimationTypeArray;
@property (nonatomic, copy) NSArray *lgf_LineWidthTypeArray;
@property (nonatomic, copy) NSArray *lgf_LineAnimationDescribeArray;
@property (nonatomic, copy) NSArray *lgf_TitleScrollFollowTypeDescribeArray;
@property (nonatomic, copy) NSArray *lgf_PVAnimationTypeDescribeArray;
@property (nonatomic, copy) NSArray *lgf_LineWidthTypeDescribeArray;

@property (strong, nonatomic) NSMutableArray <LGFFreePTTitle *> *titleArray;
@end

@implementation CustomViewController

lgf_SBViewControllerForM(CustomViewController, @"Main", @"CustomViewController");

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.toolScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 枚举类型展示用数据源
    self.lgf_LineAnimationArray = @[@"lgf_PageLineAnimationDefult", @"lgf_PageLineAnimationShortToLong", @"lgf_PageLineAnimationHideShow", @"lgf_PageLineAnimationTortoiseDown", @"lgf_PageLineAnimationTortoiseUp", @"lgf_PageLineAnimationSmallToBig", @"lgf_PageLineAnimationCustomize"];
    self.lgf_TitleScrollFollowTypeArray = @[@"lgf_TitleScrollFollowDefult", @"lgf_TitleScrollFollowLeftRight", @"lgf_TitleScrollFollowCustomize"];
    self.lgf_PVAnimationTypeArray = @[@"lgf_PageViewAnimationDefult", @"lgf_PageViewAnimationTopToBottom", @"lgf_PageViewAnimationSmallToBig", @"lgf_PageViewAnimationNone", @"lgf_PageViewAnimationCustomize"];
    self.lgf_LineWidthTypeArray = @[@"lgf_EqualTitleSTR", @"lgf_EqualTitleSTRAndImage", @"lgf_EqualTitle", @"lgf_FixedWith"];
    
    self.lgf_LineAnimationDescribeArray = @[@"默认效果", @"短到长效果", @"隐藏显示效果", @"底部隐藏效果", @"顶部隐藏效果", @"放大缩小效果", @"自定义效果，需添加自定义代理自行实现"];
    self.lgf_TitleScrollFollowTypeDescribeArray = @[@"结束后居中", @"跟随两边（腾讯新闻效果）", @"自定义效果，需添加自定义代理自行实现"];
    self.lgf_PVAnimationTypeDescribeArray = @[@"默认效果", @"上下效果", @"放大缩小效果", @"禁止拖拽滚动", @"自定义效果，需添加自定义代理自行实现"];
    self.lgf_LineWidthTypeDescribeArray = @[@"对准标文本", @"对准标文本和图片", @"对准标", @"固定宽度，需配置 line 的 lgf_LineWidth"];
   
    if ([lgf_Defaults objectForKey:@"LGFCustomDataSource"]) {
        self.titles = [[lgf_Defaults objectForKey:@"LGFCustomDataSource"] componentsSeparatedByString:@"\n"];
    }
    self.naviTitle.text = self.type;
    self.toolScrollView.hidden = NO;
    self.toolBar.hidden = NO;
    [self setDefultStyle];
    [self addChlidVC];
    // 刷新title数组
    self.fptView.lgf_Style.lgf_Titles = @[];
    [self.fptView lgf_ReloadTitle];
}

- (void)addChlidVC {
    // 删除子控制器
    [self.chlidVCs enumerateObjectsUsingBlock:^(ChildViewController *  _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }];
    [self.chlidVCs removeAllObjects];
    // 添加子控制器
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChildViewController *vc = [ChildViewController lgf];
        vc.index = idx;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.chlidVCs addObject:vc];
    }];
}

#pragma mark - 更新 UI
- (IBAction)reloadLGFFreePTView:(id)sender {
    [[LGFAlertView lgf] lgf_ShowAlertWithMessage:@"确定要自定义 LGFFreePTView 吗？" cancel:nil confirm:^{
        [self.fptView removeFromSuperview];
        [self addChlidVC];
        [self.fptView lgf_InitWithStyle:[self getNewStyle] SVC:self SV:self.pageSuperView PV:self.pageCollectionView];
        [self.fptView lgf_ReloadTitle];
    }];
}

#pragma mark - 恢复默认 UI
- (IBAction)defultLGFFreePTView:(id)sender {
    [[LGFAlertView lgf] lgf_ShowAlertWithMessage:@"确定要恢复默认吗？" cancel:nil confirm:^{
        [self.fptView removeFromSuperview];
        [lgf_Defaults removeObjectForKey:@"LGFStyleDict"];
        [self setDefultStyle];
        [self.fptView lgf_InitWithStyle:[self getNewStyle] SVC:self SV:self.pageSuperView PV:self.pageCollectionView];
        [self.fptView lgf_ReloadTitle];
    }];
}

#pragma mark - 配置自定义数据源
- (IBAction)customDataSource:(UIButton *)sender {
    customDataSourceView *view = [customDataSourceView lgf];
    [view lgf_ShowCustomDataSourceView:self oldData:self.titles];
    @LGFPTWeak(self);
    view.lgf_DataSourceBlock = ^() {
        @LGFPTStrong(self);
        self.titles = [[lgf_Defaults objectForKey:@"LGFCustomDataSource"] componentsSeparatedByString:@"\n"];
    };
}

#pragma mark - 隐藏/显示工具栏
- (IBAction)hideShow:(UIButton *)sender {
    [UIView animateWithDuration:0.4 animations:^{
        if (CGAffineTransformEqualToTransform(self.toolScrollView.transform, CGAffineTransformIdentity)) {
            self.toolScrollView.transform = CGAffineTransformMakeTranslation(0, self.toolScrollView.lgfpt_Height);
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, self.toolScrollView.lgfpt_Height);
        } else {
            self.toolScrollView.transform = CGAffineTransformIdentity;
            self.toolBar.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        if (CGAffineTransformEqualToTransform(self.toolScrollView.transform, CGAffineTransformIdentity)) {
            [sender setTitle:@"隐藏" forState:UIControlStateNormal];
        } else {
            [sender setTitle:@"显示" forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - 生成 LGFFreePTStyle 配置 Demo
- (IBAction)getLGFFreePTStyleDemo:(id)sender {
    StyleDemoViewController *vc = [StyleDemoViewController lgf];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 颜色选择回调
- (IBAction)setLGFFreePTColor:(UITapGestureRecognizer *)sender {
    __block UITextField *textF = (UITextField *)sender.view;
    colorSelectView *selectV = [colorSelectView lgf];
    [selectV lgf_ShowColorSelectView:self selectColor:textF.text];
    @lgf_Weak(self);
    selectV.lgf_CurrentColorBlock = ^(NSString * _Nonnull colorHexString) {
        @lgf_Strong(self);
        textF.text = colorHexString;
        [self setViewColor];
    };
}

#pragma mark - 特殊值加减
- (IBAction)plusMinus:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chlidVCs.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.lgfpt_Size;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ChildViewController *vc = self.chlidVCs[indexPath.item];
    if (![cell.subviews containsObject:vc.view]) {
        vc.view.frame = cell.bounds;
        vc.index = indexPath.item;
        vc.view.backgroundColor = lgf_RandomColor;
        [cell addSubview:vc.view];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    return cell;
}

#pragma mark - LGFFreePTView Delegate

//- (void)lgf_SetAllTitleState:(NSArray <LGFFreePTTitle *> *)allTitles style:(LGFFreePTStyle *)style selectTitle:(LGFFreePTTitle *)selectTitle unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectIndex:(NSInteger)selectIndex unSelectIndex:(NSInteger)unSelectIndex progress:(CGFloat)progress {
//    [unSelectTitle lgf_SetMainTitleTransform:progress isSelectTitle:NO selectIndex:selectIndex unselectIndex:unSelectIndex];
//    [selectTitle lgf_SetMainTitleTransform:progress isSelectTitle:YES selectIndex:selectIndex unselectIndex:unSelectIndex];
//    if (self.titleArray.count == 0) {
//        self.titleArray = allTitles.mutableCopy;
//    }
//    [allTitles enumerateObjectsUsingBlock:^(LGFFreePTTitle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj != selectTitle) {
//            CGFloat titleX = self.titleArray[idx].lgfpt_X;
//            if (obj.lgfpt_X == titleX) {
//                if (idx < selectIndex) {
//                    obj.lgfpt_X = titleX - titleX * progress;
//                } else if (idx > selectIndex) {
//                    obj.lgfpt_X = titleX + titleX * progress;
//                }
//            }
//        }
//    }];
//}

- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_SuperEnabled = YES;
    style.lgf_BackBtnEnabled = YES;
    style.lgf_Duration = 2.0;
    style.lgf_ToastMessage = [NSString stringWithFormat:@"当前选中:%@(%ld), 当前未选中:%@(%ld)", self.fptView.lgf_Style.lgf_Titles[self.fptView.lgf_SelectIndex], (long)self.fptView.lgf_SelectIndex, self.fptView.lgf_Style.lgf_Titles[self.fptView.lgf_UnSelectIndex], (long)self.fptView.lgf_UnSelectIndex];
    [self.view lgf_ShowMessageStyle:style animated:NO completion:^{
        
    }];
}

// 自定义 line 滚动动画配置代理（非自定义动画无需实现）
- (void)lgf_FreePTViewCustomizeScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
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
// 自定义 line 点击动画配置代理（非自定义动画无需实现）
- (void)lgf_FreePTViewCustomizeClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    CGFloat space = style.lgf_LineBottom + line.lgfpt_Height;
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 - (0.0001 / duration)  animations:^{
        line.transform = CGAffineTransformMakeTranslation(0, space);
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 - (0.0001 / duration) relativeDuration:0.0002 / duration animations:^{
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 + (0.0001 / duration) relativeDuration:0.5 - (0.0001 / duration) animations:^{
        line.transform = CGAffineTransformIdentity;
    }];
}
// 自定义选中结束后标的回位模式（非自定义动画无需实现）
- (void)lgf_TitleScrollFollowCustomizeAnimationConfig:(LGFFreePTStyle *)style lgf_TitleButtons:(NSMutableArray<LGFFreePTTitle *> *)lgf_TitleButtons unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex duration:(NSTimeInterval)duration {
    LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)lgf_TitleButtons[selectIndex];
    CGFloat offSetx = MIN(MAX(selectTitle.center.x - style.lgf_PVTitleView.lgfpt_Width * 0.5, 0.0), MAX(style.lgf_PVTitleView.contentSize.width - style.lgf_PVTitleView.lgfpt_Width, 0.0));
    [UIView animateWithDuration:duration animations:^{
        [style.lgf_PVTitleView setContentOffset:CGPointMake(offSetx, 0.0)];
    }];
}
// 自定义分页动画（非自定义动画无需实现）
- (void)lgf_FreePageViewCustomizeAnimationConfig:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout {
    CGFloat contentOffsetX = flowLayout.collectionView.contentOffset.x;
    CGFloat collectionViewCenterX = flowLayout.collectionView.lgfpt_Width * 0.5;
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        CGFloat alpha = fabs(1.0 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) / flowLayout.collectionView.lgfpt_Width);
        CGFloat scale = -fabs(fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /flowLayout.collectionView.lgfpt_Width) * 50.0;
        NSInteger index = fabs(flowLayout.collectionView.contentOffset.x / flowLayout.collectionView.lgfpt_Width);
        if ([flowLayout.collectionView.panGestureRecognizer translationInView:flowLayout.collectionView].x < 0.0) {
            if (attr.indexPath.item != index) {
                attr.alpha = alpha;
            }
        } else {
            if (attr.indexPath.item == index) {
                attr.alpha = alpha;
            }
        }
        attr.transform = CGAffineTransformMakeTranslation(0, scale);
    }
}
// 部分系统属性配置
- (void)lgf_GetLGFFreePTTitle:(UIView *)lgf_FreePTTitle index:(NSInteger)index style:(LGFFreePTStyle *)style {
    if (self.lgf_TitleBorderWidth.text.floatValue > 0.0) {
        lgf_FreePTTitle.layer.borderWidth = self.lgf_TitleBorderWidth.text.floatValue;
        lgf_FreePTTitle.layer.borderColor = lgf_HexColor(self.lgf_TitleBorderColor.text).CGColor;
    }
    if (!style.lgf_StartDebug)lgf_FreePTTitle.backgroundColor = lgf_HexColor(self.lgf_TitleBackgroundColor.text);
    lgf_FreePTTitle.layer.cornerRadius = self.lgf_TitleCornerRadius.text.floatValue;
}

- (void)lgf_GetLGFFreePTLine:(UIImageView *)lgf_FreePTLine style:(LGFFreePTStyle *)style {
    lgf_FreePTLine.alpha = self.lgf_LineAlpha.text.floatValue;
}



#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.lgf_LineAnimation) {
        return self.lgf_LineAnimationArray.count;
    } else if (pickerView == self.lgf_TitleScrollFollowType) {
        return self.lgf_TitleScrollFollowTypeArray.count;
    } else if (pickerView == self.lgf_PVAnimationType) {
        return self.lgf_PVAnimationTypeArray.count;
    } else if (pickerView == self.lgf_LineWidthType) {
        return self.lgf_LineWidthTypeArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
    }
    pickerLabel.textColor = lgf_HexColor(@"333333");
    pickerLabel.font = [UIFont systemFontOfSize:10.0];
    if (pickerView == self.lgf_LineAnimation) {
        pickerLabel.text = self.lgf_LineAnimationArray[row];
    } else if (pickerView == self.lgf_TitleScrollFollowType) {
        pickerLabel.text = self.lgf_TitleScrollFollowTypeArray[row];
    } else if (pickerView == self.lgf_PVAnimationType) {
        pickerLabel.text = self.lgf_PVAnimationTypeArray[row];
    } else if (pickerView == self.lgf_LineWidthType) {
        pickerLabel.text = self.lgf_LineWidthTypeArray[row];
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.lgf_LineAnimation) {
        self.lgf_LineAnimationInt = row;
        self.lgf_LineAnimationDescribe.text = self.lgf_LineAnimationDescribeArray[row];
    } else if (pickerView == self.lgf_TitleScrollFollowType) {
        self.lgf_TitleScrollFollowTypeInt = row;
        self.lgf_TitleScrollFollowTypeDescribe.text = self.lgf_TitleScrollFollowTypeDescribeArray[row];
    } else if (pickerView == self.lgf_PVAnimationType) {
        self.lgf_PVAnimationTypeInt = row;
        self.lgf_PVAnimationTypeDescribe.text = self.lgf_PVAnimationTypeDescribeArray[row];
    } else if (pickerView == self.lgf_LineWidthType) {
        self.lgf_LineWidthTypeInt = row;
        self.lgf_LineWidthTypeDescribe.text = self.lgf_LineWidthTypeDescribeArray[row];
    }
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text lgf_IsBlank]) {
        textField.text = @"0";
    } else {
        NSArray *texts = [textField.text componentsSeparatedByString:@"."];
        if ([texts.lastObject lgf_IsBlank]) {
            textField.text = [NSString stringWithFormat:@"%@.0", texts.firstObject];
        } else {
            textField.text = [NSString stringWithFormat:@"%@", [textField.text lgf_KeepDecimals:2]];
            if ([textField.text floatValue] <= 0.0) {
                textField.text = @"0";
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [LGFAllMethod lgf_DecimalPointInputSpecificationWithTextField:textField String:string Range:range];
    return YES;
}

#pragma mark - 自定义style
- (void)setDefultStyle {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    NSMutableDictionary *styleDict = [[NSMutableDictionary alloc] initWithDictionary:[lgf_Defaults objectForKey:@"LGFStyleDict"]];
    self.lgf_UnTitleSelectColor.text = styleDict[@"lgf_UnTitleSelectColor"] ? styleDict[@"lgf_UnTitleSelectColor"] : [style.lgf_UnTitleSelectColor lgf_HexStringWithAlpha];
    self.lgf_TitleSelectColor.text = styleDict[@"lgf_TitleSelectColor"] ? styleDict[@"lgf_TitleSelectColor"] : [style.lgf_TitleSelectColor lgf_HexStringWithAlpha];
    self.lgf_UnSubTitleSelectColor.text = styleDict[@"lgf_UnSubTitleSelectColor"] ? styleDict[@"lgf_UnSubTitleSelectColor"] : [style.lgf_UnSubTitleSelectColor lgf_HexStringWithAlpha];
    self.lgf_SubTitleSelectColor.text = styleDict[@"lgf_SubTitleSelectColor"] ? styleDict[@"lgf_SubTitleSelectColor"] : [style.lgf_SubTitleSelectColor lgf_HexStringWithAlpha];
    self.lgf_LineColor.text = styleDict[@"lgf_LineColor"] ? styleDict[@"lgf_LineColor"] : [style.lgf_LineColor lgf_HexStringWithAlpha];
    self.lgf_PVTitleViewBackgroundColor.text = styleDict[@""] ? styleDict[@""] : [style.lgf_PVTitleViewBackgroundColor lgf_HexStringWithAlpha];
    self.lgf_TitleSelectFont.text = styleDict[@"lgf_TitleSelectFont"] ? styleDict[@"lgf_TitleSelectFont"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TitleSelectFont.pointSize) lgf_KeepDecimals:2]];
    self.lgf_UnTitleSelectFont.text = styleDict[@"lgf_UnTitleSelectFont"] ? styleDict[@"lgf_UnTitleSelectFont"] : [NSString stringWithFormat:@"%@", [@(style.lgf_UnTitleSelectFont.pointSize) lgf_KeepDecimals:2]];
    self.lgf_SubTitleSelectFont.text = styleDict[@"lgf_SubTitleSelectFont"] ? styleDict[@"lgf_SubTitleSelectFont"] : [NSString stringWithFormat:@"%@", [@(style.lgf_SubTitleSelectFont.pointSize) lgf_KeepDecimals:2]];
    self.lgf_UnSubTitleSelectFont.text = styleDict[@"lgf_UnSubTitleSelectFont"] ? styleDict[@"lgf_UnSubTitleSelectFont"] : [NSString stringWithFormat:@"%@", [@(style.lgf_UnSubTitleSelectFont.pointSize) lgf_KeepDecimals:2]];
    self.lgf_TitleTransformSX.text = styleDict[@"lgf_TitleTransformSX"] ? styleDict[@"lgf_TitleTransformSX"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TitleTransformSX) lgf_KeepDecimals:2]];
    self.lgf_MainTitleTransformSX.text = styleDict[@"lgf_MainTitleTransformSX"] ? styleDict[@"lgf_MainTitleTransformSX"] : [NSString stringWithFormat:@"%@", [@(style.lgf_MainTitleTransformSX) lgf_KeepDecimals:2]];
    self.lgf_MainTitleTransformTY.text = styleDict[@"lgf_MainTitleTransformTY"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_MainTitleTransformTY"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_MainTitleTransformTY)) lgf_KeepDecimals:2]];
    self.lgf_MainTitleTransformTYPlusMinus.selected = (styleDict[@"lgf_MainTitleTransformTY"] ? [styleDict[@"lgf_MainTitleTransformTY"] floatValue] : style.lgf_MainTitleTransformTY) < 0.0;
    self.lgf_MainTitleTransformTX.text = styleDict[@"lgf_MainTitleTransformTX"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_MainTitleTransformTX"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_MainTitleTransformTX)) lgf_KeepDecimals:2]];
    self.lgf_MainTitleTransformTXPlusMinus.selected = (styleDict[@"lgf_MainTitleTransformTX"] ? [styleDict[@"lgf_MainTitleTransformTX"] floatValue] : style.lgf_MainTitleTransformTX) < 0.0;
    self.lgf_SubTitleTransformSX.text = styleDict[@"lgf_SubTitleTransformSX"] ? styleDict[@"lgf_SubTitleTransformSX"] : [NSString stringWithFormat:@"%@", [@(style.lgf_SubTitleTransformSX) lgf_KeepDecimals:2]];
    self.lgf_SubTitleTransformTY.text = styleDict[@"lgf_SubTitleTransformTY"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_SubTitleTransformTY"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_SubTitleTransformTY)) lgf_KeepDecimals:2]];
    self.lgf_SubTitleTransformTYPlusMinus.selected = (styleDict[@"lgf_SubTitleTransformTY"] ? [styleDict[@"lgf_SubTitleTransformTY"] floatValue] : style.lgf_SubTitleTransformTY) < 0.0;
    self.lgf_SubTitleTransformTX.text = styleDict[@"lgf_SubTitleTransformTX"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_SubTitleTransformTX"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_SubTitleTransformTX)) lgf_KeepDecimals:2]];
    self.lgf_SubTitleTransformTXPlusMinus.selected = (styleDict[@"lgf_SubTitleTransformTX"] ? [styleDict[@"lgf_SubTitleTransformTX"] floatValue] : style.lgf_SubTitleTransformTX) < 0.0;
    self.lgf_LineWidth.text = styleDict[@"lgf_LineWidth"] ? styleDict[@"lgf_LineWidth"] : [NSString stringWithFormat:@"%@", [@(style.lgf_LineWidth) lgf_KeepDecimals:2]];
    self.lgf_LineCenterX.text = styleDict[@"lgf_LineCenterX"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_LineCenterX"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_LineCenterX)) lgf_KeepDecimals:2]];
    self.lgf_LineCenterXPlusMinus.selected = (styleDict[@"lgf_LineCenterX"] ? [styleDict[@"lgf_LineCenterX"] floatValue] : style.lgf_LineCenterX) < 0.0;
    self.lgf_LineHeight.text = styleDict[@"lgf_LineHeight"] ? styleDict[@"lgf_LineHeight"] : [NSString stringWithFormat:@"%@", [@(style.lgf_LineHeight) lgf_KeepDecimals:2]];
    self.lgf_LineBottom.text = styleDict[@"lgf_LineBottom"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_LineBottom"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_LineBottom)) lgf_KeepDecimals:2]];
    self.lgf_LineBottomPlusMinus.selected = (styleDict[@"lgf_LineBottom"] ? [styleDict[@"lgf_LineBottom"] floatValue] : style.lgf_LineBottom) < 0.0;
    self.lgf_SubTitleTopSpace.text = styleDict[@"lgf_SubTitleTopSpace"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_SubTitleTopSpace"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_SubTitleTopSpace)) lgf_KeepDecimals:2]];
    self.lgf_SubTitleTopSpacePlusMinus.selected = (styleDict[@"lgf_SubTitleTopSpace"] ? [styleDict[@"lgf_SubTitleTopSpace"] floatValue] : style.lgf_SubTitleTopSpace) < 0.0;
    self.lgf_TitleClickAnimationDuration.text = styleDict[@"lgf_TitleClickAnimationDuration"] ? styleDict[@"lgf_TitleClickAnimationDuration"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TitleClickAnimationDuration) lgf_KeepDecimals:2]];
    self.lgf_TitleScrollToTheMiddleAnimationDuration.text = styleDict[@"lgf_TitleScrollToTheMiddleAnimationDuration"] ? styleDict[@"lgf_TitleScrollToTheMiddleAnimationDuration"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TitleScrollToTheMiddleAnimationDuration) lgf_KeepDecimals:2]];
    self.lgf_TitleFixedWidth.text = styleDict[@"lgf_TitleFixedWidth"] ? styleDict[@"lgf_TitleFixedWidth"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TitleFixedWidth) lgf_KeepDecimals:2]];
    self.lgf_TitleLeftRightSpace.text = styleDict[@"lgf_TitleLeftRightSpace"] ? styleDict[@"lgf_TitleLeftRightSpace"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TitleLeftRightSpace) lgf_KeepDecimals:2]];
    self.lgf_TopImageSpace.text = styleDict[@"lgf_TopImageSpace"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_TopImageSpace"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_TopImageSpace)) lgf_KeepDecimals:2]];
    self.lgf_TopImageSpacePlusMinus.selected = (styleDict[@"lgf_TopImageSpace"] ? [styleDict[@"lgf_TopImageSpace"] floatValue] : style.lgf_TopImageSpace) < 0.0;
    self.lgf_TopImageWidth.text = styleDict[@"lgf_TopImageWidth"] ? styleDict[@"lgf_TopImageWidth"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TopImageWidth) lgf_KeepDecimals:2]];
    self.lgf_TopImageHeight.text = styleDict[@"lgf_TopImageHeight"] ? styleDict[@"lgf_TopImageHeight"] : [NSString stringWithFormat:@"%@", [@(style.lgf_TopImageHeight) lgf_KeepDecimals:2]];
    self.lgf_BottomImageSpace.text = styleDict[@"lgf_BottomImageSpace"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_BottomImageSpace"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_BottomImageSpace)) lgf_KeepDecimals:2]];
    self.lgf_BottomImageSpacePlusMinus.selected = (styleDict[@"lgf_BottomImageSpace"] ? [styleDict[@"lgf_BottomImageSpace"] floatValue] : style.lgf_BottomImageSpace) < 0.0;
    self.lgf_BottomImageWidth.text = styleDict[@"lgf_BottomImageWidth"] ? styleDict[@"lgf_BottomImageWidth"] : [NSString stringWithFormat:@"%@", [@(style.lgf_BottomImageWidth) lgf_KeepDecimals:2]];
    self.lgf_BottomImageHeight.text = styleDict[@"lgf_BottomImageHeight"] ? styleDict[@"lgf_BottomImageHeight"] : [NSString stringWithFormat:@"%@", [@(style.lgf_BottomImageHeight) lgf_KeepDecimals:2]];
    self.lgf_LeftImageSpace.text = styleDict[@"lgf_LeftImageSpace"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_LeftImageSpace"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_LeftImageSpace)) lgf_KeepDecimals:2]];
    self.lgf_LeftImageSpacePlusMinus.selected = (styleDict[@"lgf_LeftImageSpace"] ? [styleDict[@"lgf_LeftImageSpace"] floatValue] : style.lgf_LeftImageSpace) < 0.0;
    self.lgf_LeftImageWidth.text = styleDict[@"lgf_LeftImageWidth"] ? styleDict[@"lgf_LeftImageWidth"] : [NSString stringWithFormat:@"%@", [@(style.lgf_LeftImageWidth) lgf_KeepDecimals:2]];
    self.lgf_LeftImageHeight.text = styleDict[@"lgf_LeftImageHeight"] ? styleDict[@"lgf_LeftImageHeight"] : [NSString stringWithFormat:@"%@", [@(style.lgf_LeftImageHeight) lgf_KeepDecimals:2]];
    self.lgf_RightImageSpace.text = styleDict[@"lgf_RightImageSpace"] ? [NSString stringWithFormat:@"%@", [@(ABS([styleDict[@"lgf_RightImageSpace"] floatValue])) lgf_KeepDecimals:2]] : [NSString stringWithFormat:@"%@", [@(ABS(style.lgf_RightImageSpace)) lgf_KeepDecimals:2]];
    self.lgf_RightImageSpacePlusMinus.selected = (styleDict[@"lgf_RightImageSpace"] ? [styleDict[@"lgf_RightImageSpace"] floatValue] : style.lgf_RightImageSpace) < 0.0;
    self.lgf_RightImageWidth.text = styleDict[@"lgf_RightImageWidth"] ? styleDict[@"lgf_RightImageWidth"] : [NSString stringWithFormat:@"%@", [@(style.lgf_RightImageWidth) lgf_KeepDecimals:2]];
    self.lgf_RightImageHeight.text = styleDict[@"lgf_RightImageHeight"] ? styleDict[@"lgf_RightImageHeight"] : [NSString stringWithFormat:@"%@", [@(style.lgf_RightImageHeight) lgf_KeepDecimals:2]];
    self.lgf_LineCornerRadius.text = styleDict[@"lgf_LineCornerRadius"] ? styleDict[@"lgf_LineCornerRadius"] : [NSString stringWithFormat:@"%@", [@(style.lgf_LineCornerRadius) lgf_KeepDecimals:2]];
    self.lgf_PageLeftRightSpace.text = styleDict[@"lgf_PageLeftRightSpace"] ? styleDict[@"lgf_PageLeftRightSpace"] : [NSString stringWithFormat:@"%@", [@(style.lgf_PageLeftRightSpace) lgf_KeepDecimals:2]];
    self.lgf_TitleHaveAnimation.on = style.lgf_TitleHaveAnimation;
    self.lgf_IsShowLine.on = styleDict[@"lgf_IsShowLine"] ? [styleDict[@"lgf_IsShowLine"] boolValue] : style.lgf_IsShowLine;
    self.lgf_IsTitleCenter.on = styleDict[@"lgf_IsTitleCenter"] ? [styleDict[@"lgf_IsTitleCenter"] boolValue] : style.lgf_IsTitleCenter;
    self.lgf_IsDoubleTitle.on = styleDict[@"lgf_IsDoubleTitle"] ? [styleDict[@"lgf_IsDoubleTitle"] boolValue] : style.lgf_IsDoubleTitle;
    self.lgf_IsLineAlignSubTitle.on = styleDict[@"lgf_IsLineAlignSubTitle"] ? [styleDict[@"lgf_IsLineAlignSubTitle"] boolValue] : style.lgf_IsLineAlignSubTitle;
    self.lgf_StartDebug.on = styleDict[@"lgf_StartDebug"] ? [styleDict[@"lgf_StartDebug"] boolValue] : style.lgf_StartDebug;
    self.lgf_IsExecutedImmediatelyTitleScrollFollow.on = styleDict[@"lgf_IsExecutedImmediatelyTitleScrollFollow"] ? [styleDict[@"lgf_IsExecutedImmediatelyTitleScrollFollow"] boolValue] : style.lgf_IsExecutedImmediatelyTitleScrollFollow;
    self.setlgf_ImageNames.on = styleDict[@"setlgf_ImageNames"] ? [styleDict[@"setlgf_ImageNames"] boolValue] : NO;
    self.setlgf_LineImageName.on = styleDict[@"setlgf_LineImageName"] ? [styleDict[@"setlgf_LineImageName"] boolValue] : NO;
    self.lgf_LineAnimationInt = styleDict[@"lgf_LineAnimation"] ? [self.lgf_LineAnimationArray indexOfObject:styleDict[@"lgf_LineAnimation"]] : style.lgf_LineAnimation;
    self.lgf_TitleScrollFollowTypeInt = styleDict[@"lgf_TitleScrollFollowType"] ? [self.lgf_TitleScrollFollowTypeArray indexOfObject:styleDict[@"lgf_TitleScrollFollowType"]] : style.lgf_TitleScrollFollowType;
    self.lgf_PVAnimationTypeInt = styleDict[@"lgf_PVAnimationType"] ? [self.lgf_PVAnimationTypeArray indexOfObject:styleDict[@"lgf_PVAnimationType"]] : style.lgf_PVAnimationType;
    self.lgf_LineWidthTypeInt = styleDict[@"lgf_LineWidthType"] ? [self.lgf_LineWidthTypeArray indexOfObject:styleDict[@"lgf_LineWidthType"]] : style.lgf_LineWidthType;
    [self.lgf_LineAnimation selectRow:self.lgf_LineAnimationInt inComponent:0 animated:NO];
    [self.lgf_TitleScrollFollowType selectRow:self.lgf_TitleScrollFollowTypeInt inComponent:0 animated:NO];
    [self.lgf_PVAnimationType selectRow:self.lgf_PVAnimationTypeInt inComponent:0 animated:NO];
    [self.lgf_LineWidthType selectRow:self.lgf_LineWidthTypeInt inComponent:0 animated:NO];
    
    self.lgf_LineAnimationDescribe.text = self.lgf_LineAnimationDescribeArray[self.lgf_LineAnimationInt];
    self.lgf_TitleScrollFollowTypeDescribe.text = self.lgf_TitleScrollFollowTypeDescribeArray[self.lgf_TitleScrollFollowTypeInt];
    self.lgf_PVAnimationTypeDescribe.text = self.lgf_PVAnimationTypeDescribeArray[self.lgf_PVAnimationTypeInt];
    self.lgf_LineWidthTypeDescribe.text = self.lgf_LineWidthTypeDescribeArray[self.lgf_LineWidthTypeInt];
    
    self.LGFFreePTSuperViewHeight.text = styleDict[@"LGFFreePTSuperViewHeight"] ? styleDict[@"LGFFreePTSuperViewHeight"] : @"40";
    self.LGFFreePTSuperViewBorderWidth.text = styleDict[@"LGFFreePTSuperViewBorderWidth"] ? styleDict[@"LGFFreePTSuperViewBorderWidth"] : @"0";
    self.LGFFreePTSuperViewBorderColor.text = styleDict[@"LGFFreePTSuperViewBorderColor"] ? styleDict[@"LGFFreePTSuperViewBorderColor"] : @"00000000";
    
    // 非 style 属性
    self.lgf_TitleBackgroundColor.text = styleDict[@"lgf_TitleBackgroundColor"] ? styleDict[@"lgf_TitleBackgroundColor"] : @"00000000";
    self.lgf_TitleBorderColor.text = styleDict[@"lgf_TitleBorderColor"] ? styleDict[@"lgf_TitleBorderColor"] : @"00000000";
    self.lgf_TitleBorderWidth.text = styleDict[@"lgf_TitleBorderWidth"] ? styleDict[@"lgf_TitleBorderWidth"] : @"0";
    self.lgf_TitleCornerRadius.text = styleDict[@"lgf_TitleCornerRadius"] ? styleDict[@"lgf_TitleCornerRadius"] : @"0";
    self.lgf_LineAlpha.text = styleDict[@"lgf_LineAlpha"] ? styleDict[@"lgf_LineAlpha"] : @"1";
    
    [self setViewColor];
    
    if (styleDict.allValues.count == 0) {
        [self saveStyleDict:@"LGFStyleDefultDict"];
    }
}

- (void)setViewColor {
    self.lgf_UnTitleSelectColorView.backgroundColor = lgf_HexColor(self.lgf_UnTitleSelectColor.text);
    self.lgf_TitleSelectColorView.backgroundColor = lgf_HexColor(self.lgf_TitleSelectColor.text);
    self.lgf_UnSubTitleSelectColorView.backgroundColor = lgf_HexColor(self.lgf_UnSubTitleSelectColor.text);
    self.lgf_SubTitleSelectColorView.backgroundColor = lgf_HexColor(self.lgf_SubTitleSelectColor.text);
    self.lgf_TitleBackgroundColorView.backgroundColor = lgf_HexColor(self.lgf_TitleBackgroundColor.text);
    self.lgf_LineColorView.backgroundColor = lgf_HexColor(self.lgf_LineColor.text);
    self.lgf_TitleBorderColorView.backgroundColor = lgf_HexColor(self.lgf_TitleBorderColor.text);
    self.lgf_PVTitleViewBackgroundColorView.backgroundColor = lgf_HexColor(self.lgf_PVTitleViewBackgroundColor.text);
    self.LGFFreePTSuperViewBorderColorView.backgroundColor = lgf_HexColor(self.LGFFreePTSuperViewBorderColor.text);
}

- (LGFFreePTStyle *)getNewStyle {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_UnTitleSelectColor = [UIColor lgf_ColorWithHexString:self.lgf_UnTitleSelectColor.text];
    style.lgf_TitleSelectColor = [UIColor lgf_ColorWithHexString:self.lgf_TitleSelectColor.text];
    style.lgf_UnSubTitleSelectColor = [UIColor lgf_ColorWithHexString:self.lgf_UnSubTitleSelectColor.text];
    style.lgf_SubTitleSelectColor = [UIColor lgf_ColorWithHexString:self.lgf_SubTitleSelectColor.text];
    style.lgf_LineColor = [UIColor lgf_ColorWithHexString:self.lgf_LineColor.text];
    style.lgf_PVTitleViewBackgroundColor = [UIColor lgf_ColorWithHexString:self.lgf_PVTitleViewBackgroundColor.text];
    style.lgf_TitleSelectFont = [UIFont systemFontOfSize:self.lgf_TitleSelectFont.text.floatValue];
    style.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:self.lgf_UnTitleSelectFont.text.floatValue];
    style.lgf_SubTitleSelectFont = [UIFont systemFontOfSize:self.lgf_SubTitleSelectFont.text.floatValue];
    style.lgf_UnSubTitleSelectFont = [UIFont systemFontOfSize:self.lgf_UnSubTitleSelectFont.text.floatValue];
    style.lgf_TitleTransformSX = self.lgf_TitleTransformSX.text.floatValue;
    style.lgf_MainTitleTransformSX = self.lgf_MainTitleTransformSX.text.floatValue;
    style.lgf_MainTitleTransformTY = self.lgf_MainTitleTransformTYPlusMinus.selected ? -self.lgf_MainTitleTransformTY.text.floatValue : self.lgf_MainTitleTransformTY.text.floatValue;
    style.lgf_MainTitleTransformTX = self.lgf_MainTitleTransformTXPlusMinus.selected ? -self.lgf_MainTitleTransformTX.text.floatValue : self.lgf_MainTitleTransformTX.text.floatValue;
    style.lgf_SubTitleTransformSX = self.lgf_SubTitleTransformSX.text.floatValue;
    style.lgf_SubTitleTransformTY = self.lgf_SubTitleTransformTYPlusMinus.selected ? -self.lgf_SubTitleTransformTY.text.floatValue : self.lgf_SubTitleTransformTY.text.floatValue;
    style.lgf_SubTitleTransformTX = self.lgf_SubTitleTransformTXPlusMinus.selected ? -self.lgf_SubTitleTransformTX.text.floatValue : self.lgf_SubTitleTransformTX.text.floatValue;
    style.lgf_LineWidth = self.lgf_LineWidth.text.floatValue;
    style.lgf_LineCenterX = self.lgf_LineCenterXPlusMinus.selected ? -self.lgf_LineCenterX.text.floatValue : self.lgf_LineCenterX.text.floatValue;
    style.lgf_LineHeight = self.lgf_LineHeight.text.floatValue;
    style.lgf_LineBottom = self.lgf_LineBottomPlusMinus.selected ? -self.lgf_LineBottom.text.floatValue : self.lgf_LineBottom.text.floatValue;
    style.lgf_SubTitleTopSpace = self.lgf_SubTitleTopSpacePlusMinus.selected ? -self.lgf_SubTitleTopSpace.text.floatValue : self.lgf_SubTitleTopSpace.text.floatValue;
    style.lgf_TitleClickAnimationDuration = self.lgf_TitleClickAnimationDuration.text.floatValue;
    style.lgf_TitleScrollToTheMiddleAnimationDuration = self.lgf_TitleScrollToTheMiddleAnimationDuration.text.floatValue;
    style.lgf_TitleFixedWidth = self.lgf_TitleFixedWidth.text.floatValue;
    style.lgf_TitleLeftRightSpace = self.lgf_TitleLeftRightSpace.text.floatValue;
    style.lgf_LineCornerRadius = self.lgf_LineCornerRadius.text.floatValue;
    style.lgf_PageLeftRightSpace = self.lgf_PageLeftRightSpace.text.floatValue;
    style.lgf_TitleHaveAnimation = self.lgf_TitleHaveAnimation.on;
    style.lgf_IsShowLine = self.lgf_IsShowLine.on;
    style.lgf_IsTitleCenter = self.lgf_IsTitleCenter.on;
    style.lgf_IsDoubleTitle = self.lgf_IsDoubleTitle.on;
    style.lgf_IsExecutedImmediatelyTitleScrollFollow = self.lgf_IsExecutedImmediatelyTitleScrollFollow.on;
    style.lgf_IsLineAlignSubTitle = self.lgf_IsLineAlignSubTitle.on;
    style.lgf_StartDebug = self.lgf_StartDebug.on;
    style.lgf_LineAnimation = self.lgf_LineAnimationInt;
    style.lgf_TitleScrollFollowType = self.lgf_TitleScrollFollowTypeInt;
    style.lgf_PVAnimationType = self.lgf_PVAnimationTypeInt;
    style.lgf_LineWidthType = self.lgf_LineWidthTypeInt;
    if (self.setlgf_ImageNames.on) {
        style.lgf_ImageBundel = lgf_Bundle(@"LGFFreePTDemo");
        
        style.lgf_TopImageSpace = self.lgf_TopImageSpacePlusMinus.selected ? -self.lgf_TopImageSpace.text.floatValue : self.lgf_TopImageSpace.text.floatValue;
        style.lgf_TopImageWidth = self.lgf_TopImageWidth.text.floatValue;
        style.lgf_TopImageHeight = self.lgf_TopImageHeight.text.floatValue;
        
        style.lgf_BottomImageSpace = self.lgf_BottomImageSpacePlusMinus.selected ? -self.lgf_BottomImageSpace.text.floatValue : self.lgf_BottomImageSpace.text.floatValue;
        style.lgf_BottomImageWidth = self.lgf_BottomImageWidth.text.floatValue;
        style.lgf_BottomImageHeight = self.lgf_BottomImageHeight.text.floatValue;
        
        style.lgf_LeftImageSpace = self.lgf_LeftImageSpacePlusMinus.selected ? -self.lgf_LeftImageSpace.text.floatValue : self.lgf_LeftImageSpace.text.floatValue;
        style.lgf_LeftImageWidth = self.lgf_LeftImageWidth.text.floatValue;
        style.lgf_LeftImageHeight = self.lgf_LeftImageHeight.text.floatValue;
        
        style.lgf_RightImageSpace = self.lgf_RightImageSpacePlusMinus.selected ? -self.lgf_RightImageSpace.text.floatValue : self.lgf_RightImageSpace.text.floatValue;
        style.lgf_RightImageWidth = self.lgf_RightImageWidth.text.floatValue;
        style.lgf_RightImageHeight = self.lgf_RightImageHeight.text.floatValue;
        
        style.lgf_SelectImageNames = [[NSMutableArray new] lgf_CreatDentical:@"tupian" count:self.titles.count].mutableCopy;
        style.lgf_UnSelectImageNames = [[NSMutableArray new] lgf_CreatDentical:@"tupian_un" count:self.titles.count].mutableCopy;
    } else {
        style.lgf_SelectImageNames = @[].mutableCopy;
        style.lgf_UnSelectImageNames = @[].mutableCopy;
    }
    if (self.setlgf_LineImageName.on) {
        style.lgf_LineImageName = @"line_image";
        style.lgf_ImageBundel = lgf_Bundle(@"LGFFreePTDemo");
    } else {
        style.lgf_LineImageName = @"";
    }
    style.lgf_Titles = self.titles;
    [lgf_Defaults setObject:[NSString stringWithFormat:@"style.lgf_Titles = @[@\"%@\"].copy;", [style.lgf_Titles componentsJoinedByString:@"\", @\""]] forKey:@"LGFCustomDataSourceStr"];
    
    self.pageSuperViewHeight.constant = self.LGFFreePTSuperViewHeight.text.floatValue;
    self.pageSuperView.layer.borderWidth = self.LGFFreePTSuperViewBorderWidth.text.floatValue;
    self.pageSuperView.layer.borderColor = [UIColor lgf_ColorWithHexString:self.LGFFreePTSuperViewBorderColor.text].CGColor;
    [self.pageSuperView setNeedsLayout];
    [self saveStyleDict:@"LGFStyleDict"];
    return style;
}

- (void)saveStyleDict:(NSString *)name {
    NSMutableDictionary *styleDict = [[NSMutableDictionary alloc] init];
    [styleDict setValue:self.lgf_UnTitleSelectColor.text forKey:@"lgf_UnTitleSelectColor"];
    [styleDict setValue:self.lgf_TitleSelectColor.text forKey:@"lgf_TitleSelectColor"];
    [styleDict setValue:self.lgf_UnSubTitleSelectColor.text forKey:@"lgf_UnSubTitleSelectColor"];
    [styleDict setValue:self.lgf_SubTitleSelectColor.text forKey:@"lgf_SubTitleSelectColor"];
    [styleDict setValue:self.lgf_TitleBackgroundColor.text forKey:@"lgf_TitleBackgroundColor"];
    [styleDict setValue:self.lgf_LineColor.text forKey:@"lgf_LineColor"];
    [styleDict setValue:self.lgf_TitleBorderColor.text forKey:@"lgf_TitleBorderColor"];
    [styleDict setValue:self.lgf_PVTitleViewBackgroundColor.text forKey:@"lgf_PVTitleViewBackgroundColor"];
    [styleDict setValue:self.lgf_TitleBorderWidth.text forKey:@"lgf_TitleBorderWidth"];
    [styleDict setValue:self.lgf_TitleSelectFont.text forKey:@"lgf_TitleSelectFont"];
    [styleDict setValue:self.lgf_UnTitleSelectFont.text forKey:@"lgf_UnTitleSelectFont"];
    [styleDict setValue:self.lgf_SubTitleSelectFont.text forKey:@"lgf_SubTitleSelectFont"];
    [styleDict setValue:self.lgf_UnSubTitleSelectFont.text forKey:@"lgf_UnSubTitleSelectFont"];
    [styleDict setValue:self.lgf_TitleTransformSX.text forKey:@"lgf_TitleTransformSX"];
    [styleDict setValue:self.lgf_MainTitleTransformSX.text forKey:@"lgf_MainTitleTransformSX"];
    [styleDict setValue:self.lgf_MainTitleTransformTYPlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_MainTitleTransformTY.text] : self.lgf_MainTitleTransformTY.text forKey:@"lgf_MainTitleTransformTY"];
    [styleDict setValue:self.lgf_MainTitleTransformTXPlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_MainTitleTransformTX.text] : self.lgf_MainTitleTransformTX.text forKey:@"lgf_MainTitleTransformTX"];
    [styleDict setValue:self.lgf_SubTitleTransformSX.text forKey:@"lgf_SubTitleTransformSX"];
    [styleDict setValue:self.lgf_SubTitleTransformTYPlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_SubTitleTransformTY.text] : self.lgf_SubTitleTransformTY.text forKey:@"lgf_SubTitleTransformTY"];
    [styleDict setValue:self.lgf_SubTitleTransformTXPlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_SubTitleTransformTX.text] : self.lgf_SubTitleTransformTX.text forKey:@"lgf_SubTitleTransformTX"];
    [styleDict setValue:self.lgf_LineWidth.text forKey:@"lgf_LineWidth"];
    [styleDict setValue:self.lgf_LineCenterXPlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_LineCenterX.text] : self.lgf_LineCenterX.text forKey:@"lgf_LineCenterX"];
    [styleDict setValue:self.lgf_LineHeight.text forKey:@"lgf_LineHeight"];
    [styleDict setValue:self.lgf_LineBottomPlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_LineBottom.text] : self.lgf_LineBottom.text forKey:@"lgf_LineBottom"];
    [styleDict setValue:self.lgf_LineAlpha.text forKey:@"lgf_LineAlpha"];
    [styleDict setValue:self.lgf_SubTitleTopSpacePlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_SubTitleTopSpace.text] : self.lgf_SubTitleTopSpace.text forKey:@"lgf_SubTitleTopSpace"];
    [styleDict setValue:self.lgf_TitleClickAnimationDuration.text forKey:@"lgf_TitleClickAnimationDuration"];
    [styleDict setValue:self.lgf_TitleScrollToTheMiddleAnimationDuration.text forKey:@"lgf_TitleScrollToTheMiddleAnimationDuration"];
    [styleDict setValue:self.lgf_TitleFixedWidth.text forKey:@"lgf_TitleFixedWidth"];
    [styleDict setValue:self.lgf_TitleLeftRightSpace.text forKey:@"lgf_TitleLeftRightSpace"];
    [styleDict setValue:self.lgf_TitleCornerRadius.text forKey:@"lgf_TitleCornerRadius"];
    [styleDict setValue:self.lgf_TopImageSpacePlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_TopImageSpace.text] : self.lgf_TopImageSpace.text forKey:@"lgf_TopImageSpace"];
    [styleDict setValue:self.lgf_TopImageWidth.text forKey:@"lgf_TopImageWidth"];
    [styleDict setValue:self.lgf_TopImageHeight.text forKey:@"lgf_TopImageHeight"];
    [styleDict setValue:self.lgf_BottomImageSpacePlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_BottomImageSpace.text] : self.lgf_BottomImageSpace.text forKey:@"lgf_BottomImageSpace"];
    [styleDict setValue:self.lgf_BottomImageWidth.text forKey:@"lgf_BottomImageWidth"];
    [styleDict setValue:self.lgf_BottomImageHeight.text forKey:@"lgf_BottomImageHeight"];
    [styleDict setValue:self.lgf_LeftImageSpacePlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_LeftImageSpace.text] : self.lgf_LeftImageSpace.text forKey:@"lgf_LeftImageSpace"];
    [styleDict setValue:self.lgf_LeftImageWidth.text forKey:@"lgf_LeftImageWidth"];
    [styleDict setValue:self.lgf_LeftImageHeight.text forKey:@"lgf_LeftImageHeight"];
    [styleDict setValue:self.lgf_RightImageSpacePlusMinus.selected ? [NSString stringWithFormat:@"-%@", self.lgf_RightImageSpace.text] : self.lgf_RightImageSpace.text forKey:@"lgf_RightImageSpace"];
    [styleDict setValue:self.lgf_RightImageWidth.text forKey:@"lgf_RightImageWidth"];
    [styleDict setValue:self.lgf_RightImageHeight.text forKey:@"lgf_RightImageHeight"];
    [styleDict setValue:self.lgf_LineCornerRadius.text forKey:@"lgf_LineCornerRadius"];
    [styleDict setObject:self.lgf_PageLeftRightSpace.text forKey:@"lgf_PageLeftRightSpace"];
    [styleDict setObject:(self.lgf_TitleHaveAnimation.on ? @"YES" : @"NO") forKey:@"lgf_TitleHaveAnimation"];
    [styleDict setObject:(self.lgf_IsShowLine.on ? @"YES" : @"NO") forKey:@"lgf_IsShowLine"];
    [styleDict setObject:(self.lgf_IsTitleCenter.on ? @"YES" : @"NO") forKey:@"lgf_IsTitleCenter"];
    [styleDict setObject:(self.lgf_IsDoubleTitle.on ? @"YES" : @"NO") forKey:@"lgf_IsDoubleTitle"];
    [styleDict setObject:(self.lgf_IsLineAlignSubTitle.on ? @"YES" : @"NO") forKey:@"lgf_IsLineAlignSubTitle"];
    [styleDict setObject:(self.lgf_StartDebug.on ? @"YES" : @"NO") forKey:@"lgf_StartDebug"];
    [styleDict setObject:(self.lgf_IsExecutedImmediatelyTitleScrollFollow.on ? @"YES" : @"NO") forKey:@"lgf_IsExecutedImmediatelyTitleScrollFollow"];
    [styleDict setValue:self.lgf_LineAnimationArray[self.lgf_LineAnimationInt] forKey:@"lgf_LineAnimation"];
    [styleDict setValue:self.lgf_TitleScrollFollowTypeArray[self.lgf_TitleScrollFollowTypeInt] forKey:@"lgf_TitleScrollFollowType"];
    [styleDict setValue:self.lgf_PVAnimationTypeArray[self.lgf_PVAnimationTypeInt] forKey:@"lgf_PVAnimationType"];
    [styleDict setValue:self.lgf_LineWidthTypeArray[self.lgf_LineWidthTypeInt] forKey:@"lgf_LineWidthType"];
    [styleDict setObject:(self.setlgf_ImageNames.on ? @"YES" : @"NO") forKey:@"setlgf_ImageNames"];
    [styleDict setObject:(self.setlgf_LineImageName.on ? @"YES" : @"NO") forKey:@"setlgf_LineImageName"];
    [styleDict setObject:self.LGFFreePTSuperViewHeight.text forKey:@"LGFFreePTSuperViewHeight"];
    [styleDict setObject:self.LGFFreePTSuperViewBorderWidth.text forKey:@"LGFFreePTSuperViewBorderWidth"];
    [styleDict setValue:self.LGFFreePTSuperViewBorderColor.text forKey:@"LGFFreePTSuperViewBorderColor"];
    [lgf_Defaults setObject:styleDict forKey:name];
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
        _fptView = [[LGFFreePTView lgf] lgf_InitWithStyle:[self getNewStyle] SVC:self SV:self.pageSuperView PV:nil];
        _fptView.lgf_FreePTDelegate = self;
    }
    return _fptView;
}

- (NSMutableArray <LGFFreePTTitle *> *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray new];
    }
    return _titleArray;
}
@end
