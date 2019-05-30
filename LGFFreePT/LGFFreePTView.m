//
//  LGFFreePTView.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTView.h"
#import "LGFFreePTFlowLayout.h"
#import "LGFFreePTMethod.h"
#import "UIView+LGFFreePT.h"

@interface LGFFreePTView () <UIScrollViewDelegate, LGFFreePTTitleDelegate, LGFFreePTLineDelegate, LGFFreePTFlowLayoutDelegate>
@property (strong, nonatomic) UICollectionView *lgf_PageView;// 外部分页控制器
@property (assign, nonatomic) NSInteger lgf_UnSelectIndex;// 前一个选中下标
@property (assign, nonatomic) NSInteger lgf_RealSelectIndex;// 最准确的选中标值
@property (assign, nonatomic) BOOL lgf_IsSelectTitle;// 点击了顶部标
@property (assign, nonatomic) BOOL lgf_Enabled;// 操作中是否禁用手势
@property (assign, nonatomic) BOOL lgf_FreePTViewEnabled;// 操作中是否禁用手势
@property (assign, nonatomic) BOOL lgf_PageViewEnabled;// 操作中是否禁用手势
@end
@implementation LGFFreePTView

#pragma mark - 初始化
+ (instancetype)lgf {
    LGFFreePTView *freePT = [LGFPTBundle loadNibNamed:NSStringFromClass([LGFFreePTView class]) owner:self options:nil].firstObject;
    freePT.delegate = freePT;
    freePT.lgf_PageViewEnabled = YES;
    freePT.lgf_FreePTViewEnabled = YES;
    return freePT;
}

#pragma mark - 初始化配置
- (instancetype)lgf_InitWithStyle:(LGFFreePTStyle *)style SVC:(UIViewController *)SVC SV:(UIView *)SV PV:(UICollectionView *)PV {
    NSAssert(SVC, @"请在initWithStyle方法中传入父视图控制器! 否则将无法联动控件");
    NSAssert(SV, @"请在initWithStyle方法中传入父View! 否则将无法联动控件");
    NSAssert(style.lgf_UnSelectImageNames.count == style.lgf_SelectImageNames.count, @"选中图片数组和未选中图片数组count必须一致");
    self.lgf_Style = style;
    self.lgf_PageView = PV;
    // 部分基础 UI 配置
    self.backgroundColor = self.lgf_Style.lgf_PVTitleViewBackgroundColor ? self.lgf_Style.lgf_PVTitleViewBackgroundColor : SV.backgroundColor;
    if (@available(iOS 11.0, *)) {
        if (self.lgf_PageView) self.lgf_PageView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        SVC.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.lgf_Style.lgf_PVTitleView = self;
    [SV addSubview:self];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.lgf_PageView) {
            [self lgf_PageViewConfig];
        }
        // 是否有固定 Frame
        if (CGRectEqualToRect(self.lgf_Style.lgf_PVTitleViewFrame, CGRectZero)) {
            self.frame = self.superview.bounds;
        } else {
            self.frame = self.lgf_Style.lgf_PVTitleViewFrame;
        }
    });
    return self;
}

#pragma mark - 刷新所有标
- (void)lgf_ReloadTitle {
    [self lgf_ReloadTitleAndSelectIndex:0 animated:NO];
}
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated {
    [self lgf_ReloadTitleAndSelectIndex:selectIndex isExecutionDelegate:YES animated:animated];
}
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex isExecutionDelegate:(BOOL)isExecutionDelegate animated:(BOOL)animated {
    [self lgf_ReloadTitleAndSelectIndex:selectIndex isExecutionDelegate:isExecutionDelegate isReloadPageCV:YES animated:animated];
}
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex isExecutionDelegate:(BOOL)isExecutionDelegate isReloadPageCV:(BOOL)isReloadPageCV animated:(BOOL)animated {
    if (self.lgf_PageView) {
        NSAssert(self.lgf_Style.lgf_Titles.count == [self.lgf_PageView.dataSource collectionView:self.lgf_PageView numberOfItemsInSection:0], @"如果关联 lgf_PageView 外部子控制器/ cell 数量必须和 lgf_Titles 标数量保持一致，如果不关联 lgf_PageView 请传 nil");
        if (isReloadPageCV) [self.lgf_PageView reloadData];
    }
    NSAssert((selectIndex <= (self.lgf_Style.lgf_Titles.count - 1)) && (selectIndex >= 0), @"lgf_ReloadTitleAndSelectIndex -> selectIndex 导致数组越界了");
    // 删除一遍所有子控件
    [self lgf_RemoveAllSubViews];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 初始化选中值
        [self lgf_AutoSelectIndex:selectIndex];
        // 配置标
        [self lgf_AddTitles];
        // 添加底部滚动线
        [self lgf_AddLine];
        
        // 默认选中
        [self setNeedsLayout];
        [self layoutIfNeeded];
        if (animated) {
            [self lgf_AdjustUIWhenBtnOnClickExecutionDelegate:isExecutionDelegate duration:self.lgf_Style.lgf_TitleClickAnimationDuration autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration];
        } else {
            [self lgf_AdjustUIWhenBtnOnClickExecutionDelegate:isExecutionDelegate duration:0.0 autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration];
        }
    });
}

#pragma mark - 手动选中某个标（如果关联外部 CV 外部 CV 请手动滚动）
- (void)lgf_SelectIndex:(NSInteger)index {
    [self lgf_SelectIndex:index isExecutionDelegate:NO];
}
- (void)lgf_SelectIndex:(NSInteger)index isExecutionDelegate:(BOOL)isExecutionDelegate {
    [self lgf_SelectIndex:index duration:self.lgf_Style.lgf_TitleClickAnimationDuration autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration isExecutionDelegate:isExecutionDelegate];
}
- (void)lgf_SelectIndex:(NSInteger)index duration:(CGFloat)duration autoScrollDuration:(CGFloat)autoScrollDuration {
    [self lgf_SelectIndex:index duration:duration autoScrollDuration:autoScrollDuration isExecutionDelegate:NO];
}
- (void)lgf_SelectIndex:(NSInteger)index duration:(CGFloat)duration autoScrollDuration:(CGFloat)autoScrollDuration isExecutionDelegate:(BOOL)isExecutionDelegate {
    NSAssert((index <= (self.lgf_Style.lgf_Titles.count - 1)) && (index >= 0), @"lgf_ReloadTitleAndSelectIndex -> selectIndex 导致数组越界了");
    if (self.lgf_SelectIndex == index) { return; }
    dispatch_async(dispatch_get_main_queue(), ^{
        // 初始化选中值
        [self lgf_AutoSelectIndex:index];
        // 默认选中
        [self lgf_AdjustUIWhenBtnOnClickExecutionDelegate:isExecutionDelegate duration:duration autoScrollDuration:autoScrollDuration];
    });
}

#pragma mark - 添加标
- (void)lgf_AddTitles {
    __block CGFloat contentWidth = 0.0;
    [self.lgf_Style.lgf_Titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull titleText, NSUInteger idx, BOOL * _Nonnull stop) {
        LGFFreePTTitle *title = [LGFFreePTTitle lgf_AllocTitle:titleText index:idx style:self.lgf_Style delegate:self];
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lgf_TitleClick:)];
        tapRecognize.cancelsTouchesInView = NO;
        [title addGestureRecognizer:tapRecognize];
        [self.lgf_TitleButtons addObject:title];
        contentWidth += title.frame.size.width;
    }];
    // 标view 滚动区域配置
    [self setContentSize:CGSizeMake(contentWidth + self.lgf_Style.lgf_PageLeftRightSpace * 2.0, -self.lgfpt_Height)];
    // 标总长度小于 LGFFreePT 宽度的情况下是否居中
    if (self.lgf_Style.lgf_IsTitleCenter) {
        if (self.contentSize.width < self.lgfpt_Width) {
            self.lgfpt_X = (self.lgfpt_Width / 2.0) - (self.contentSize.width / 2.0);
        } else {
            self.lgfpt_X = 0.0;
        }
    }
}

#pragma mark - 添加底部线
- (void)lgf_AddLine {
    if (self.lgf_Style.lgf_IsShowLine) {
        [self addSubview:self.lgf_TitleLine];
        [self sendSubviewToBack:self.lgf_TitleLine];
    }
}

#pragma mark - 标点击事件 滚动到指定tag位置
- (void)lgf_TitleClick:(UITapGestureRecognizer *)sender {
    if (![self lgf_AutoSelectIndex:sender.view.tag]) return;
    [self lgf_AdjustUIWhenBtnOnClickExecutionDelegate:YES duration:self.lgf_Style.lgf_TitleClickAnimationDuration autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration];
    // 获取精确 lgf_RealSelectIndex
    self.lgf_RealSelectIndex = self.lgf_SelectIndex;
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_RealSelectFreePTTitle:)]) {
        [self.lgf_FreePTDelegate lgf_RealSelectFreePTTitle:self.lgf_RealSelectIndex];
    }
}

#pragma mark - 标自动滚动
- (void)lgf_AutoScrollTitle:(NSInteger)selectIndex {
    if (![self lgf_AutoSelectIndex:selectIndex]) return;
    [self lgf_TitleAutoScrollToTheMiddleExecutionDelegate:YES autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration];
}

#pragma mark - 调整title位置 使其滚动到中间
- (void)lgf_TitleAutoScrollToTheMiddleExecutionDelegate:(BOOL)isExecution autoScrollDuration:(CGFloat)autoScrollDuration {
    if (self.lgf_SelectIndex > self.lgf_TitleButtons.count - 1 || self.lgf_TitleButtons.count == 0) { return;
    }
    // 下面有部分重复动画代码，为了直观的鼓励你们使用我的代理来自定义自己的效果，如果可以能够结合 LGFFreePTStyle 分享给大家那是极好的（我的动画代码不一定是最精简的，效果也不一定是最惊艳的～）
    if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowDefult) {
        [LGFFreePTMethod lgf_TitleScrollFollowDefultAnimationConfig:self.lgf_Style lgf_TitleButtons:self.lgf_TitleButtons unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex duration:autoScrollDuration];
    } else if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowLeftRight) {
        [LGFFreePTMethod lgf_TitleScrollFollowLeftRightAnimationConfig:self.lgf_Style lgf_TitleButtons:self.lgf_TitleButtons unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex duration:autoScrollDuration];
    } else if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowCustomize) {
        if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_TitleScrollFollowCustomizeAnimationConfig:lgf_TitleButtons:unSelectIndex:selectIndex:duration:)]) {
            LGFPTLog(@"自定义回位动画的 contentOffset.x:%f", self.contentOffset.x);
            [self.lgf_FreePTDelegate lgf_TitleScrollFollowCustomizeAnimationConfig:self.lgf_Style lgf_TitleButtons:self.lgf_TitleButtons unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex duration:autoScrollDuration];
        }
    }
    if (isExecution && self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_SelectFreePTTitle:)]) {
        LGFPTLog(@"当前选中:%@", self.lgf_Style.lgf_Titles[self.lgf_SelectIndex]);
        [self.lgf_FreePTDelegate lgf_SelectFreePTTitle:self.lgf_SelectIndex];
    }
}

#pragma mark -  外层分页控制器 contentOffset 转化
- (void)lgf_ConvertToProgress:(CGFloat)contentOffsetX {
    CGFloat selectProgress = contentOffsetX / self.lgf_PageView.lgfpt_Width;
    CGFloat progress = selectProgress - floor(selectProgress);
    NSInteger selectIndex = self.lgf_UnSelectIndex;
    NSInteger unSelectIndex = self.lgf_SelectIndex;
    if (contentOffsetX >= (self.lgf_PageView.contentSize.width - self.lgf_PageView.lgfpt_Width)) {
        progress = 1.0;
        unSelectIndex = selectProgress - 1;
        selectIndex = selectProgress;
    } else {
        if (self.lgf_TitleLine.lgfpt_X < contentOffsetX) {
            selectIndex = selectProgress + 1;
            unSelectIndex = selectProgress;
        } else {
            progress = 1.0 - progress;
            unSelectIndex = selectProgress + 1;
            selectIndex = selectProgress;
        }
    }
    
    // 获取精确 lgf_RealSelectIndex
    if (self.lgf_RealSelectIndex != roundf(selectProgress)) {
        self.lgf_RealSelectIndex = roundf(selectProgress);
        // 精确跟随
        if (self.lgf_Style.lgf_IsExecutedImmediatelyTitleScrollFollow) {
            [self lgf_AutoScrollTitle:self.lgf_RealSelectIndex];
        }
        if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_RealSelectFreePTTitle:)]) {
            [self.lgf_FreePTDelegate lgf_RealSelectFreePTTitle:self.lgf_RealSelectIndex];
        }
    }
    [self lgf_AdjustUIWithProgress:progress unSelectIndex:unSelectIndex selectIndex:selectIndex];
}

#pragma mark - 更新标view的UI(用于滚动外部分页控制器的时候)
- (void)lgf_AdjustUIWithProgress:(CGFloat)progress unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex {
    // 取得 前一个选中的标 和将要选中的标
    __block LGFFreePTTitle *unSelectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[unSelectIndex];
    __block LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[selectIndex];
    
    // 标整体状态改变
    [unSelectTitle lgf_SetMainTitleTransform:progress isSelectTitle:NO selectIndex:unSelectIndex unselectIndex:selectIndex];
    [selectTitle lgf_SetMainTitleTransform:progress isSelectTitle:YES selectIndex:unSelectIndex unselectIndex:selectIndex];
    
    // 标底部滚动条 更新位置
    if (self.lgf_TitleLine && self.lgf_Style.lgf_IsShowLine) {
        @LGFPTWeak(self);
        [self lgf_GetXAndW:^(CGFloat selectX, CGFloat selectWidth, CGFloat unSelectX, CGFloat unSelectWidth) {
            @LGFPTStrong(self);
            // 下面有部分重复动画代码，为了直观的鼓励你们使用我的代理来自定义自己的动画，如果可以能够结合 LGFFreePTStyle 分享给大家那是极好的（我的动画代码不一定是最精简的，效果也不一定是最惊艳的～）
            if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationDefult) {
                [LGFFreePTMethod lgf_PageLineAnimationDefultScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationShortToLong) {
                [LGFFreePTMethod lgf_PageLineAnimationShortToLongScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationHideShow) {
                [LGFFreePTMethod lgf_PageLineAnimationHideShowScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
                [LGFFreePTMethod lgf_PageLineAnimationSmallToBigScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseDown) {
                [LGFFreePTMethod lgf_PageLineAnimationTortoiseDownScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseUp) {
                [LGFFreePTMethod lgf_PageLineAnimationTortoiseUpScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationCustomize) {
                if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_FreePTViewCustomizeScrollLineAnimationConfig:selectX:selectWidth:unSelectX:unSelectWidth:unSelectTitle:selectTitle:unSelectIndex:selectIndex:line:progress:)]) {
                    [self.lgf_FreePTDelegate lgf_FreePTViewCustomizeScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:unSelectIndex selectIndex:selectIndex line:self.lgf_TitleLine progress:progress];
                    LGFPTLog(@"自定义 line 动画 progress:%f", progress);
                }
            }
        } selectTitle:selectTitle unSelectTitle:unSelectTitle];
    }
}

#pragma mark - 更新标view的UI(用于点击标的时候)
- (void)lgf_AdjustUIWhenBtnOnClickExecutionDelegate:(BOOL)isExecution duration:(CGFloat)duration autoScrollDuration:(CGFloat)autoScrollDuration {
    self.lgf_PageViewEnabled = NO;
    // 外部分页控制器 滚动到对应下标
    if (self.lgf_PageView) [self.lgf_PageView setContentOffset:CGPointMake(self.lgf_PageView.lgfpt_Width * self.lgf_SelectIndex, 0)];
    // 取得 前一个选中的标 和 将要选中的标
    __block LGFFreePTTitle *unSelectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[self.lgf_UnSelectIndex];
    __block LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[self.lgf_SelectIndex];
    // 动画时间
    __block CGFloat animatedDuration = self.lgf_Style.lgf_TitleHaveAnimation ? duration : 0.0;
    [UIView animateKeyframesWithDuration:animatedDuration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        // 标整体状态改变
        [unSelectTitle lgf_SetMainTitleTransform:1.0 isSelectTitle:NO selectIndex:self.lgf_UnSelectIndex unselectIndex:self.lgf_UnSelectIndex];
        [selectTitle lgf_SetMainTitleTransform:1.0 isSelectTitle:YES selectIndex:self.lgf_UnSelectIndex unselectIndex:self.lgf_UnSelectIndex];
        
        // 标底部滚动条 更新位置
        if (self.lgf_TitleLine && self.lgf_Style.lgf_IsShowLine) {
            @LGFPTWeak(self);
            [self lgf_GetXAndW:^(CGFloat selectX, CGFloat selectWidth, CGFloat unSelectX, CGFloat unSelectWidth) {
                @LGFPTStrong(self);
                // 下面有部分重复动画代码，为了直观的鼓励你们使用我的代理来自定义自己的动画，如果可以能够结合 LGFFreePTStyle 分享给大家那是极好的（我的动画代码不一定是最精简的，效果也不一定是最惊艳的～）
                if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationDefult) {
                    [LGFFreePTMethod lgf_PageLineAnimationDefultClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:duration];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationShortToLong) {
                    [LGFFreePTMethod lgf_PageLineAnimationShortToLongClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:duration];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationHideShow) {
                    [LGFFreePTMethod lgf_PageLineAnimationHideShowClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:duration];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
                    [LGFFreePTMethod lgf_PageLineAnimationSmallToBigClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:duration];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseDown) {
                    [LGFFreePTMethod lgf_PageLineAnimationTortoiseDownClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:duration];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseUp) {
                    [LGFFreePTMethod lgf_PageLineAnimationTortoiseUpClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:duration];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationCustomize) {
                    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_FreePTViewCustomizeClickLineAnimationConfig:selectX:selectWidth:unSelectX:unSelectWidth:unSelectTitle:selectTitle:unSelectIndex:selectIndex:line:duration:)]) {
                        [self.lgf_FreePTDelegate lgf_FreePTViewCustomizeClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle unSelectIndex:self.lgf_UnSelectIndex selectIndex:self.lgf_SelectIndex line:self.lgf_TitleLine duration:animatedDuration];
                    }
                }
            } selectTitle:selectTitle unSelectTitle:unSelectTitle];
        }
    } completion:^(BOOL finished) {
        [self lgf_TitleAutoScrollToTheMiddleExecutionDelegate:isExecution autoScrollDuration:autoScrollDuration];
        self.lgf_PageViewEnabled = YES;
    }];
}

#pragma mark - 取得要改变的 X 和 Width 核心逻辑部分
- (void)lgf_GetXAndW:(void (^)(CGFloat selectX, CGFloat selectWidth, CGFloat unSelectX, CGFloat unSelectWidth))XAndW selectTitle:(LGFFreePTTitle *)selectTitle unSelectTitle:(LGFFreePTTitle *)unSelectTitle {
    CGFloat selectX = 0.0;
    CGFloat selectWidth = 0.0;
    CGFloat unSelectX = 0.0;
    CGFloat unSelectWidth = 0.0;
    if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitle) {
        selectX = selectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX;
        selectWidth = selectTitle.lgfpt_Width;
        unSelectX = unSelectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX;
        unSelectWidth = unSelectTitle.lgfpt_Width;
    } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTRAndImage) {
        selectX = (selectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX + selectTitle.lgf_LeftImage.lgfpt_X * selectTitle.lgf_CurrentTransformSX);
        selectWidth = (selectTitle.lgf_RightImage.lgfpt_X + selectTitle.lgf_RightImage.lgfpt_Width - selectTitle.lgf_LeftImage.lgfpt_X) * selectTitle.lgf_CurrentTransformSX;
        unSelectX = (unSelectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX + unSelectTitle.lgf_LeftImage.lgfpt_X * unSelectTitle.lgf_CurrentTransformSX);
        unSelectWidth = (unSelectTitle.lgf_RightImage.lgfpt_X + unSelectTitle.lgf_RightImage.lgfpt_Width - unSelectTitle.lgf_LeftImage.lgfpt_X) * unSelectTitle.lgf_CurrentTransformSX;
    } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTR) {
        selectX = selectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX + (self.lgf_Style.lgf_IsLineAlignSubTitle ? selectTitle.lgf_SubTitle.lgfpt_X : selectTitle.lgf_Title.lgfpt_X) * selectTitle.lgf_CurrentTransformSX;
        selectWidth = (self.lgf_Style.lgf_IsLineAlignSubTitle ? selectTitle.lgf_SubTitle.lgfpt_Width : selectTitle.lgf_Title.lgfpt_Width) * selectTitle.lgf_CurrentTransformSX;
        unSelectX = unSelectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX + (self.lgf_Style.lgf_IsLineAlignSubTitle ? unSelectTitle.lgf_SubTitle.lgfpt_X : unSelectTitle.lgf_Title.lgfpt_X) * unSelectTitle.lgf_CurrentTransformSX;
        unSelectWidth = (self.lgf_Style.lgf_IsLineAlignSubTitle ? unSelectTitle.lgf_SubTitle.lgfpt_Width : unSelectTitle.lgf_Title.lgfpt_Width) * unSelectTitle.lgf_CurrentTransformSX;
    } else if (self.lgf_Style.lgf_LineWidthType == lgf_FixedWith) {
        selectX = selectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX + (selectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0;
        selectWidth = self.lgf_Style.lgf_LineWidth;
        unSelectX = unSelectTitle.lgfpt_X + self.lgf_Style.lgf_LineCenterX + (unSelectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0;
        unSelectWidth = self.lgf_Style.lgf_LineWidth;
    }
    if (XAndW) XAndW(selectX, selectWidth, unSelectX, unSelectWidth);
}

#pragma mark - LGFFreePTTitleDelegate
- (void)lgf_GetTitleNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl {
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_GetNetImage:imageUrl:)]) {
        [self.lgf_FreePTDelegate lgf_GetNetImage:imageView imageUrl:imageUrl];
    }
}
- (void)lgf_GetTitle:(UIView *)lgf_FreePTTitle index:(NSInteger)index style:(LGFFreePTStyle *)style {
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_GetLGFFreePTTitle:index:style:)]) {
        [self.lgf_FreePTDelegate lgf_GetLGFFreePTTitle:lgf_FreePTTitle index:index style:style];
    }
}

#pragma mark - LGFFreePTLineDelegate
- (void)lgf_GetLineNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl {
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_GetNetImage:imageUrl:)]) {
        [self.lgf_FreePTDelegate lgf_GetNetImage:imageView imageUrl:imageUrl];
    }
}
- (void)lgf_GetLine:(UIImageView *)lgf_FreePTLine style:(LGFFreePTStyle *)style {
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_GetLGFFreePTLine:style:)]) {
        [self.lgf_FreePTDelegate lgf_GetLGFFreePTLine:lgf_FreePTLine style:style];
    }
}

#pragma mark - LGFFreePTFlowLayoutDelegate
- (void)lgf_FreePageViewCustomizeAnimation:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout {
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_FreePageViewCustomizeAnimationConfig:flowLayout:)]) {
        [self.lgf_FreePTDelegate lgf_FreePageViewCustomizeAnimationConfig:attributes flowLayout:flowLayout];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // setContentOffset 方法触发的不算数～
        if (self.lgf_PageView.isTracking || self.lgf_PageView.isDragging || self.lgf_PageView.isDecelerating) {
            self.lgf_FreePTViewEnabled = NO;
            [self lgf_ConvertToProgress:self.lgf_PageView.contentOffset.x < 0.0 ? 0.0 : self.lgf_PageView.contentOffset.x];
            if ((NSInteger)self.lgf_PageView.contentOffset.x % (NSInteger)self.lgf_PageView.lgfpt_Width == 0) {
                self.lgf_FreePTViewEnabled = YES;
                if (!self.lgf_Style.lgf_IsExecutedImmediatelyTitleScrollFollow) {
                    [self lgf_AutoScrollTitle:(self.lgf_PageView.contentOffset.x / (NSInteger)self.lgf_PageView.lgfpt_Width)];
                }
            }
        }
    }
}

#pragma mark - 销毁
- (void)dealloc {
    [self lgf_RemoveAllSubViews];
    if (self.lgf_PageView) [self.lgf_PageView removeObserver:self forKeyPath:@"contentOffset"];
    LGFPTLog(@"LGF的分页控件:LGFFreePT --- 已经释放");
}

#pragma mark - 删除所有子控件
- (void)lgf_RemoveAllSubViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lgf_TitleButtons enumerateObjectsUsingBlock:^(LGFFreePTTitle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        obj = nil;
    }];
    [self.lgf_TitleLine removeFromSuperview];
    self.lgf_TitleLine = nil;
    [self.lgf_TitleButtons removeAllObjects];
}

#pragma mark - 懒加载

- (BOOL)lgf_AutoSelectIndex:(NSInteger)selectIndex {
    if (self.lgf_SelectIndex == selectIndex) {
        return NO;
    }
    self.lgf_UnSelectIndex = self.lgf_SelectIndex;
    self.lgf_SelectIndex = selectIndex;
    return YES;
}

- (void)setLgf_FreePTViewEnabled:(BOOL)lgf_FreePTViewEnabled {
    _lgf_FreePTViewEnabled = lgf_FreePTViewEnabled;
    [self setViewEnabled:_lgf_FreePTViewEnabled view:self];
}

- (void)setLgf_PageViewEnabled:(BOOL)lgf_PageViewEnabled {
    _lgf_PageViewEnabled = lgf_PageViewEnabled;
    [self setViewEnabled:_lgf_PageViewEnabled view:self.lgf_PageView];
}

- (void)setViewEnabled:(BOOL)enabled view:(UIScrollView *)view  {
    if (view){
        if (enabled) {
            view.scrollEnabled = ((self.lgf_Style.lgf_PVAnimationType == lgf_PageViewAnimationNone) && (view == self.lgf_PageView)) ? NO : YES;
            view.userInteractionEnabled = YES;
        } else {
            view.scrollEnabled = NO;
            view.userInteractionEnabled = NO;
        }
    }
}

- (void)lgf_PageViewConfig {
    if (self.lgf_PageView) {
        LGFFreePTFlowLayout *layout = [[LGFFreePTFlowLayout alloc] init];
        layout.lgf_PVAnimationType = self.lgf_Style.lgf_PVAnimationType;
        layout.lgf_FreePTFlowLayoutDelegate = self;
        [self.lgf_PageView setCollectionViewLayout:layout];
        [self.lgf_PageView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        self.lgf_PageView.pagingEnabled = YES;
        self.lgf_PageView.scrollsToTop = NO;
        self.lgf_PageView.tag = 333333;
    }
}

- (LGFFreePTLine *)lgf_TitleLine {
    if (!_lgf_TitleLine) {
        _lgf_TitleLine = [LGFFreePTLine lgf];
        [_lgf_TitleLine lgf_AllocLine:self.lgf_Style delegate:self];
    }
    return _lgf_TitleLine;
}

- (NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons {
    if (!_lgf_TitleButtons) {
        _lgf_TitleButtons = [NSMutableArray new];
    }
    return _lgf_TitleButtons;
}
@end
