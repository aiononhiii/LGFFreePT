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

@interface LGFFreePTView () <UIScrollViewDelegate, LGFFreePTTitleDelegate, LGFFreePTLineDelegate>
@property (strong, nonatomic) UICollectionView *lgf_PageView;// 外部分页控制器
@property (strong, nonatomic) NSMutableArray <LGFFreePTTitle *> *lgf_TitleButtons;// 所有标数组
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
    // NSAssert
    NSAssert(SVC, @"请在initWithStyle方法中传入父视图控制器! 否则将无法联动控件");
    NSAssert(SV, @"请在initWithStyle方法中传入父View! 否则将无法联动控件");
    NSAssert(style.lgf_UnSelectImageNames.count == style.lgf_SelectImageNames.count, @"选中图片数组和未选中图片数组count必须一致");
    
    [SV setNeedsLayout];
    [SV layoutIfNeeded];
    self.lgf_Style = style;
    self.lgf_PageView = PV;
    
    // 部分基础 UI 配置
    self.backgroundColor = self.lgf_Style.lgf_PVTitleViewBackgroundColor ? self.lgf_Style.lgf_PVTitleViewBackgroundColor : SV.backgroundColor;
    
    if (@available(iOS 11.0, *)) {
        if (self.lgf_PageView) self.lgf_PageView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        SVC.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 是否有固定 Frame
    if (CGRectEqualToRect(self.lgf_Style.lgf_PVTitleViewFrame, CGRectZero)) {
        self.frame = SV.bounds;
    } else {
        self.frame = self.lgf_Style.lgf_PVTitleViewFrame;
    }
    self.lgf_Style.lgf_PVTitleView = self;
    [SV addSubview:self];
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
    if (self.lgf_Style.lgf_Titles.count == 0 || !self.lgf_Style.lgf_Titles || (selectIndex >  self.lgf_Style.lgf_Titles.count - 1)) {
        return;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lgf_TitleButtons enumerateObjectsUsingBlock:^(LGFFreePTTitle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        obj = nil;
    }];
    [self.lgf_TitleLine removeFromSuperview];
    self.lgf_TitleLine = nil;
    [self.lgf_TitleButtons removeAllObjects];
    
    if (self.lgf_PageView && isReloadPageCV) [self.lgf_PageView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 初始化选中值
        self.lgf_UnSelectIndex = 0;
        self.lgf_SelectIndex = selectIndex;
        // 配置标
        [self lgf_AddTitles];
        // 添加底部滚动线
        [self lgf_AddLine];
        // 默认选中
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
    if (self.lgf_Style.lgf_Titles.count == 0 || !self.lgf_Style.lgf_Titles || (index >  self.lgf_Style.lgf_Titles.count - 1) || self.lgf_SelectIndex == index) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        // 初始化选中值
        self.lgf_UnSelectIndex = self.lgf_SelectIndex;
        self.lgf_SelectIndex = index;
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
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
    NSInteger nowSelectIndex = sender.view.tag;
    if (self.lgf_SelectIndex == nowSelectIndex) {
        return;
    }
    self.lgf_UnSelectIndex = self.lgf_SelectIndex;
    self.lgf_SelectIndex = nowSelectIndex;
    [self lgf_AdjustUIWhenBtnOnClickExecutionDelegate:YES duration:self.lgf_Style.lgf_TitleClickAnimationDuration autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration];
    // 获取精确 lgf_RealSelectIndex
    self.lgf_RealSelectIndex = self.lgf_SelectIndex;
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_RealSelectFreePTTitle:)]) {
        [self.lgf_FreePTDelegate lgf_RealSelectFreePTTitle:self.lgf_RealSelectIndex];
    }
}

#pragma mark - 标自动滚动
- (void)lgf_AutoScrollTitle {
    NSInteger nowSelectIndex = (self.lgf_PageView.contentOffset.x / (NSInteger)self.lgf_PageView.lgfpt_Width);
    if (self.lgf_SelectIndex == nowSelectIndex) {
        return;
    }
    self.lgf_UnSelectIndex = self.lgf_SelectIndex;
    self.lgf_SelectIndex = nowSelectIndex;
    [self lgf_TitleAutoScrollToTheMiddleExecutionDelegate:YES autoScrollDuration:self.lgf_Style.lgf_TitleScrollToTheMiddleAnimationDuration];
}

#pragma mark - 调整title位置 使其滚动到中间
- (void)lgf_TitleAutoScrollToTheMiddleExecutionDelegate:(BOOL)isExecution autoScrollDuration:(CGFloat)autoScrollDuration {
    if (self.lgf_SelectIndex > self.lgf_TitleButtons.count - 1 || self.lgf_TitleButtons.count == 0) { return;
    }
    if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowDefult) {
        LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[self.lgf_SelectIndex];
        CGFloat offSetx = MIN(MAX(selectTitle.center.x - self.lgfpt_Width * 0.5, 0.0), MAX(self.contentSize.width - self.lgfpt_Width, 0.0));
        [UIView animateWithDuration:autoScrollDuration animations:^{
            [self setContentOffset:CGPointMake(offSetx, 0.0)];
        }];
    } else if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowLeftRight) {
        BOOL isRight = self.lgf_SelectIndex > self.lgf_UnSelectIndex;
        LGFFreePTTitle *title = (LGFFreePTTitle *)self.lgf_TitleButtons[isRight ? MIN(self.lgf_SelectIndex + 1, self.lgf_TitleButtons.count - 1) : MAX(self.lgf_SelectIndex - 1, 0)];
        [UIView animateWithDuration:autoScrollDuration animations:^{
            if (isRight) {
                if (self.lgf_SelectIndex == (self.lgf_TitleButtons.count - 1)) {
                    [self setContentOffset:CGPointMake(self.contentSize.width - self.lgfpt_Width, 0.0)];
                } else {
                    if ((title.lgfpt_X + title.lgfpt_Width) >= (self.contentOffset.x + self.lgfpt_Width)) {
                        [self setContentOffset:CGPointMake(title.lgfpt_X + title.lgfpt_Width - self.lgfpt_Width + (((self.lgf_SelectIndex + 1) == (self.lgf_TitleButtons.count - 1)) ? self.lgf_Style.lgf_PageLeftRightSpace : 0.0), 0.0)];
                    }
                }
            } else {
                if (self.lgf_SelectIndex == 0) {
                    [self setContentOffset:CGPointMake(0.0, 0.0)];
                } else {
                    if (title.lgfpt_X < self.contentOffset.x) {
                        [self setContentOffset:CGPointMake(title.lgfpt_X - (((self.lgf_SelectIndex - 1) == 0) ? self.lgf_Style.lgf_PageLeftRightSpace : 0.0), 0.0)];
                    }
                }
                
            }
        }];
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
    CGPoint delta = [self.lgf_PageView.panGestureRecognizer translationInView:self.lgf_PageView.superview];
    NSInteger selectIndex;
    NSInteger unselectIndex;
    if (delta.x > 0.0) {
        selectIndex = selectProgress + 1;
        unselectIndex = selectProgress;
    } else if (delta.x < 0.0) {
        progress = 1.0 - progress;
        unselectIndex = selectProgress + 1;
        selectIndex = selectProgress;
    } else {
        return;
    }
    if ((unselectIndex > self.lgf_TitleButtons.count - 1) || (selectIndex > self.lgf_TitleButtons.count - 1 ) || (self.lgf_TitleButtons.count == 0)) {
        return;
    }
    
    // 获取精确 lgf_RealSelectIndex
    if (self.lgf_RealSelectIndex != roundf(selectProgress)) {
        self.lgf_RealSelectIndex = roundf(selectProgress);
        if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_RealSelectFreePTTitle:)]) {
            [self.lgf_FreePTDelegate lgf_RealSelectFreePTTitle:self.lgf_RealSelectIndex];
        }
    }
    [self lgf_AdjustUIWithProgress:progress unselectIndex:unselectIndex selectIndex:selectIndex];
}

#pragma mark - 更新标view的UI(用于滚动外部分页控制器的时候)
- (void)lgf_AdjustUIWithProgress:(CGFloat)progress unselectIndex:(NSInteger)unselectIndex selectIndex:(NSInteger)selectIndex {
    // 取得 前一个选中的标 和将要选中的标
    __block LGFFreePTTitle *unSelectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[unselectIndex];
    __block LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[selectIndex];
    
    // 标整体状态改变
    [unSelectTitle lgf_SetMainTitleTransform:progress isSelectTitle:NO selectIndex:unselectIndex unselectIndex:selectIndex];
    [selectTitle lgf_SetMainTitleTransform:progress isSelectTitle:YES selectIndex:unselectIndex unselectIndex:selectIndex];
    
    // 标底部滚动条 更新位置
    if (self.lgf_TitleLine && self.lgf_Style.lgf_IsShowLine) {
        @LGFPTWeak(self);
        [self lgf_GetXAndW:^(CGFloat selectX, CGFloat selectWidth, CGFloat unSelectX, CGFloat unSelectWidth) {
            @LGFPTStrong(self);
            if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationDefult) {
                self.lgf_TitleLine.lgfpt_X = selectX * progress + unSelectX * (1.0 - progress);
                self.lgf_TitleLine.lgfpt_Width = selectWidth * progress + unSelectWidth * (1.0 - progress);
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationShortToLong) {
                CGFloat space = (unSelectTitle.lgfpt_Width / unSelectTitle.lgf_CurrentTransformSX - unSelectWidth) / 2 + (selectTitle.lgfpt_Width / selectTitle.lgf_CurrentTransformSX - selectWidth) / 2;
                if (progress > 0.5) {
                    if (unselectIndex < selectIndex) {
                        self.lgf_TitleLine.lgfpt_X = selectX - (space + unSelectWidth) * 2 * (1.0 - progress);
                    } else {
                        self.lgf_TitleLine.lgfpt_X = selectX;
                    }
                } else {
                    if (unselectIndex > selectIndex) {
                        self.lgf_TitleLine.lgfpt_X = unSelectX - (space + selectWidth) * 2 * progress;
                    } else {
                        self.lgf_TitleLine.lgfpt_X = unSelectX;
                    }
                }
                if (progress > 0.5) {
                    self.lgf_TitleLine.lgfpt_Width = selectWidth  + (unSelectWidth + space) * 2 * (1.0 - progress);
                } else {
                    self.lgf_TitleLine.lgfpt_Width = unSelectWidth + (selectWidth + space) * 2 * progress;
                }
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationHideShow) {
                if (progress > 0.5) {
                    self.lgf_TitleLine.lgfpt_X = selectX;
                    self.lgf_TitleLine.lgfpt_Width = selectWidth;
                    self.lgf_TitleLine.alpha = 1.0 - (2.0 * (1.0 - progress));
                } else {
                    self.lgf_TitleLine.lgfpt_X = unSelectX;
                    self.lgf_TitleLine.lgfpt_Width = unSelectWidth;
                    self.lgf_TitleLine.alpha = 1.0 - (2.0 * progress);
                }
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
                self.lgf_TitleLine.transform = CGAffineTransformIdentity;
                if (progress > 0.5) {
                    CGFloat num = 1.0 - (2.0 * (1.0 - progress));
                    self.lgf_TitleLine.lgfpt_X = selectX;
                    self.lgf_TitleLine.lgfpt_Width = selectWidth;
                    self.lgf_TitleLine.transform = CGAffineTransformMakeScale(num, num);
                } else {
                    CGFloat num = 1.0 - (2.0 * progress);
                    self.lgf_TitleLine.lgfpt_X = unSelectX;
                    self.lgf_TitleLine.lgfpt_Width = unSelectWidth;
                    self.lgf_TitleLine.transform = CGAffineTransformMakeScale(num, num);
                }
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseDown || self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseUp) {
                CGFloat space = self.lgf_Style.lgf_LineBottom + (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseDown ? self.lgf_TitleLine.lgfpt_Height : -self.lgfpt_Height);
                if (progress > 0.5) {
                    self.lgf_TitleLine.lgfpt_X = selectX;
                    self.lgf_TitleLine.lgfpt_Width = selectWidth;
                    self.lgf_TitleLine.transform = CGAffineTransformIdentity;
                    self.lgf_TitleLine.transform = CGAffineTransformMakeTranslation(0, space * (2.0 * (1.0 - progress)));
                } else {
                    self.lgf_TitleLine.lgfpt_X = unSelectX;
                    self.lgf_TitleLine.lgfpt_Width = unSelectWidth;
                    self.lgf_TitleLine.transform = CGAffineTransformIdentity;
                    self.lgf_TitleLine.transform = CGAffineTransformMakeTranslation(0, space + space * (1.0 - (2.0 * (1.0 - progress))));
                }
            } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationCustomize) {
                if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_FreePTViewCustomizeScrollLineAnimationConfig:selectX:selectWidth:unSelectX:unSelectWidth:unSelectTitle:selectTitle:line:progress:)]) {
                    [self.lgf_FreePTDelegate lgf_FreePTViewCustomizeScrollLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle line:self.lgf_TitleLine progress:progress];
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
                if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseDown || self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseUp || self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationHideShow || self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
                    CGFloat space = self.lgf_Style.lgf_LineBottom + (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationTortoiseDown ? self.lgf_TitleLine.lgfpt_Height : -self.lgfpt_Height);
                    // 这个 0.0001 用于关键帧动画的瞬间无缝坐标改动（肉眼无法识别）
                    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 - (0.0001 / animatedDuration)  animations:^{
                        if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationHideShow) {
                            self.lgf_TitleLine.alpha = 0.0;
                        } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
                            self.lgf_TitleLine.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                        } else {
                            self.lgf_TitleLine.transform = CGAffineTransformMakeTranslation(0.0, space);
                        }
                    }];
                    [UIView addKeyframeWithRelativeStartTime:0.5 + (0.0001 / animatedDuration) relativeDuration:0.5 - (0.0001 / animatedDuration) animations:^{
                        if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationHideShow) {
                            self.lgf_TitleLine.alpha = 1.0;
                        } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
                            self.lgf_TitleLine.transform = CGAffineTransformIdentity;
                        } else {
                            self.lgf_TitleLine.transform = CGAffineTransformIdentity;
                        }
                    }];
                    [UIView addKeyframeWithRelativeStartTime:0.5 - (0.0001 / animatedDuration) relativeDuration:0.0002 / animatedDuration animations:^{
                        self.lgf_TitleLine.lgfpt_X = selectX;
                        self.lgf_TitleLine.lgfpt_Width = selectWidth;
                    }];
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationDefult || self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationShortToLong) {
                    self.lgf_TitleLine.lgfpt_X = selectX;
                    self.lgf_TitleLine.lgfpt_Width = selectWidth;
                } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationCustomize) {
                    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_FreePTViewCustomizeClickLineAnimationConfig:selectX:selectWidth:unSelectX:unSelectWidth:unSelectTitle:selectTitle:line:duration:)]) {
                        [self.lgf_FreePTDelegate lgf_FreePTViewCustomizeClickLineAnimationConfig:self.lgf_Style selectX:selectX selectWidth:selectWidth unSelectX:unSelectX unSelectWidth:unSelectWidth unSelectTitle:unSelectTitle selectTitle:selectTitle line:self.lgf_TitleLine duration:animatedDuration];
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

#pragma mark - LGFFreePTLineDelegate
- (void)lgf_GetLineNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl {
    if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_GetNetImage:imageUrl:)]) {
        [self.lgf_FreePTDelegate lgf_GetNetImage:imageView imageUrl:imageUrl];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // setContentOffset 方法触发的不算数～
        if (self.lgf_PageView.isTracking || self.lgf_PageView.isDragging || self.lgf_PageView.isDecelerating) {
            self.lgf_FreePTViewEnabled = NO;
            [self lgf_ConvertToProgress:self.lgf_PageView.contentOffset.x < 0.0 ? 0.0 : self.lgf_PageView.contentOffset.x];
            if ((NSInteger)self.lgf_PageView.contentOffset.x % (NSInteger)self.lgf_PageView.lgfpt_Width == 0.0) {
                self.lgf_FreePTViewEnabled = YES;
                [self lgf_AutoScrollTitle];
            }
        }
    }
}

#pragma mark - 销毁
- (void)dealloc {
    if (self.lgf_PageView) [self.lgf_PageView removeObserver:self forKeyPath:@"contentOffset"];
    LGFPTLog(@"LGF的分页控件:LGFFreePT --- 已经释放");
}

#pragma mark - 懒加载
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
            view.panGestureRecognizer.view.userInteractionEnabled = YES;
        } else {
            view.scrollEnabled = NO;
            view.userInteractionEnabled = NO;
            view.panGestureRecognizer.view.userInteractionEnabled = NO;
        }
    }
}

- (void)setLgf_PageView:(UICollectionView *)lgf_PageView {
    _lgf_PageView = lgf_PageView;
    if (self.lgf_PageView) {
        LGFFreePTFlowLayout *layout = [[LGFFreePTFlowLayout alloc] init];
        layout.lgf_PVAnimationType = self.lgf_Style.lgf_PVAnimationType;
        [lgf_PageView setCollectionViewLayout:layout];
        [lgf_PageView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        lgf_PageView.pagingEnabled = YES;
        lgf_PageView.scrollsToTop = NO;
        lgf_PageView.tag = 333333;
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
