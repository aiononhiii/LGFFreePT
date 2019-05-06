//
//  LGFFreePTView.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTView.h"
#import "LGFFreePTTitle.h"
#import "LGFFreePTLine.h"
#import "LGFFreePTFlowLayout.h"
#import "LGFFreePTMethod.h"
#import "UIView+LGFFreePT.h"

@interface LGFFreePTView () <UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView *lgf_PageView;// 外部分页控制器
@property (strong, nonatomic) LGFFreePTLine *lgf_TitleLine;// 底部滚动条
@property (strong, nonatomic) NSMutableArray <LGFFreePTTitle *> *lgf_TitleButtons;// 所有标数组
@property (assign, nonatomic) NSInteger lgf_SelectIndex;// 将要选中下标
@property (assign, nonatomic) NSInteger lgf_UnSelectIndex;// 前一个选中下标
@property (assign, nonatomic) BOOL lgf_IsSelectTitle;// 点击了顶部标
@property (assign, nonatomic) BOOL lgf_Enabled;// 操作中是否禁用手势
// 标字体渐变色用数组
@property (copy, nonatomic) NSArray *lgf_DeltaRGBA;
@property (copy, nonatomic) NSArray *lgf_SelectColorRGBA;
@property (copy, nonatomic) NSArray *lgf_UnSelectColorRGBA;
@property (copy, nonatomic) NSArray *lgf_SubDeltaRGBA;
@property (copy, nonatomic) NSArray *lgf_SubSelectColorRGBA;
@property (copy, nonatomic) NSArray *lgf_SubUnSelectColorRGBA;
@end
@implementation LGFFreePTView

#pragma mark - 初始化
+ (instancetype)lgf {
    LGFFreePTView *freePT = [LGFPTBundle loadNibNamed:NSStringFromClass([LGFFreePTView class]) owner:self options:nil].firstObject;
    freePT.delegate = freePT;
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
    self.backgroundColor = SV.backgroundColor;
    if (@available(iOS 11.0, *)) {
        if (self.lgf_PageView) self.lgf_PageView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        SVC.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 是否有点击动画
    if (!self.lgf_Style.lgf_TitleHaveAnimation && self.lgf_PageView) {
        self.lgf_PageView.scrollEnabled = NO;
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

#pragma mark - 添加所有标
- (void)lgf_ReloadTitle {
    [self lgf_ReloadTitleAndSelectIndex:self.lgf_SelectIndex];
}
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)index {
    if (self.lgf_Style.lgf_Titles.count == 0 || !self.lgf_Style.lgf_Titles) {
        return;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lgf_TitleLine removeFromSuperview];
    [self.lgf_TitleButtons removeAllObjects];
    if (self.lgf_PageView) [self.lgf_PageView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 初始化选中值
        self.lgf_UnSelectIndex = 0;
        self.lgf_SelectIndex = index;
        // 配置标
        [self lgf_AddTitles];
        // 添加底部滚动线
        [self lgf_AddLine];
        // 默认选中
        [self lgf_AdjustUIWhenBtnOnClickWithAnimate:NO];
    });
}

#pragma mark - 添加标
- (void)lgf_AddTitles {
    __block CGFloat contentWidth = 0.0;
    [self.lgf_Style.lgf_Titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull titleText, NSUInteger idx, BOOL * _Nonnull stop) {
        LGFFreePTTitle *title = [LGFFreePTTitle lgf_AllocTitle:titleText index:idx style:self.lgf_Style];
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
    [self lgf_AdjustUIWhenBtnOnClickWithAnimate:YES];
}

#pragma mark - 标自动滚动
- (void)lgf_AutoScrollTitle {
    NSInteger nowSelectIndex = (self.lgf_PageView.contentOffset.x / (NSInteger)self.lgf_PageView.lgfpt_Width);
    if (self.lgf_SelectIndex == nowSelectIndex) {
        return;
    }
    self.lgf_UnSelectIndex = self.lgf_SelectIndex;
    self.lgf_SelectIndex = nowSelectIndex;
    [self LGF_TitleAutoScrollToTheMiddle:self.lgf_SelectIndex animated:YES];
}

#pragma mark - 调整title位置 使其滚动到中间
- (void)LGF_TitleAutoScrollToTheMiddle:(NSInteger)selectIndex animated:(BOOL)animated {
    if (self.lgf_SelectIndex > self.lgf_TitleButtons.count - 1 || self.lgf_TitleButtons.count == 0) { return;
    }
    if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowDefult) {
        LGFFreePTTitle *select_title = (LGFFreePTTitle *)self.lgf_TitleButtons[selectIndex];
        CGFloat offSetx = select_title.center.x - self.lgfpt_Width * 0.5;
        if (offSetx < 0.0) { offSetx = 0.0; }
        CGFloat maxOffSetX = self.contentSize.width - self.lgfpt_Width;
        if (maxOffSetX < 0.0) { maxOffSetX = 0.0; }
        if (offSetx > maxOffSetX) { offSetx = maxOffSetX; }
        [self setContentOffset:CGPointMake(offSetx, 0.0) animated:animated];
        if (self.lgf_FreePTDelegate && [self.lgf_FreePTDelegate respondsToSelector:@selector(lgf_SelectFreePTTitle:)]) {
            LGFPTLog(@"当前选中:%@", self.lgf_Style.lgf_Titles[self.lgf_SelectIndex]);
            [self.lgf_FreePTDelegate lgf_SelectFreePTTitle:self.lgf_SelectIndex];
        }
    } else if (self.lgf_Style.lgf_TitleScrollFollowType == lgf_TitleScrollFollowLeftRight) {
        NSAssert(self.lgf_Style.lgf_TitleScrollFollowType != lgf_TitleScrollFollowDefult, @"LGFTitleScrollFollowLeftRight -- 改方法暂时未实现功能 现不可用");
    }
}

#pragma mark -  外层分页控制器 contentOffset 转化
- (void)lgf_ConvertToProgress:(CGFloat)contentOffsetX {
    if (contentOffsetX < 0) { return; }
    CGFloat tempProgress = contentOffsetX / self.lgf_PageView.lgfpt_Width;
    CGFloat progress = tempProgress - floor(tempProgress);
    CGPoint delta = [self.lgf_PageView.panGestureRecognizer translationInView:self.lgf_PageView.superview];
    NSInteger selectIndex;
    NSInteger unselectIndex;
    NSInteger tempIndex = tempProgress;
    if (delta.x > 0.0) {
        selectIndex = tempIndex + 1;
        unselectIndex = tempIndex;
    } else if (delta.x < 0.0) {
        progress = 1.0 - progress;
        unselectIndex = tempIndex + 1;
        selectIndex = tempIndex;
    } else {
        return;
    }
    if (unselectIndex > self.lgf_TitleButtons.count - 1 || selectIndex > self.lgf_TitleButtons.count - 1 || self.lgf_TitleButtons.count == 0) {
        return;
    }
    [self lgf_AdjustUIWithProgress:progress unselectIndex:unselectIndex selectIndex:selectIndex];
}

#pragma mark - 更新标view的UI(用于滚动外部分页控制器的时候)
- (void)lgf_AdjustUIWithProgress:(CGFloat)progress unselectIndex:(NSInteger)unselectIndex selectIndex:(NSInteger)selectIndex {
    // 取得 前一个选中的标 和将要选中的标
    LGFFreePTTitle *unSelectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[unselectIndex];
    LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[selectIndex];
    // 标颜色渐变
    if (self.lgf_Style.lgf_TitleSelectColor != self.lgf_Style.lgf_UnTitleSelectColor) {
        unSelectTitle.lgf_Title.textColor = [UIColor
                                           colorWithRed:[self.lgf_SelectColorRGBA[0] floatValue] + [self.lgf_DeltaRGBA[0] floatValue] * progress
                                           green:[self.lgf_SelectColorRGBA[1] floatValue] + [self.lgf_DeltaRGBA[1] floatValue] * progress
                                           blue:[self.lgf_SelectColorRGBA[2] floatValue] + [self.lgf_DeltaRGBA[2] floatValue] * progress
                                           alpha:[self.lgf_SelectColorRGBA[3] floatValue] + [self.lgf_DeltaRGBA[3] floatValue] * progress];
        selectTitle.lgf_Title.textColor = [UIColor
                                        colorWithRed:[self.lgf_UnSelectColorRGBA[0] floatValue] - [self.lgf_DeltaRGBA[0] floatValue] * progress
                                        green:[self.lgf_UnSelectColorRGBA[1] floatValue] - [self.lgf_DeltaRGBA[1] floatValue] * progress
                                        blue:[self.lgf_UnSelectColorRGBA[2] floatValue] - [self.lgf_DeltaRGBA[2] floatValue] * progress
                                        alpha:[self.lgf_UnSelectColorRGBA[3] floatValue] - [self.lgf_DeltaRGBA[3] floatValue] * progress];
    }
    if (self.lgf_Style.lgf_IsDoubleTitle && self.lgf_Style.lgf_SubTitleSelectColor != self.lgf_Style.lgf_UnSubTitleSelectColor) {
        unSelectTitle.lgf_SubTitle.textColor = [UIColor
                                              colorWithRed:[self.lgf_SubSelectColorRGBA[0] floatValue] + [self.lgf_SubDeltaRGBA[0] floatValue] * progress
                                              green:[self.lgf_SubSelectColorRGBA[1] floatValue] + [self.lgf_SubDeltaRGBA[1] floatValue] * progress
                                              blue:[self.lgf_SubSelectColorRGBA[2] floatValue] + [self.lgf_SubDeltaRGBA[2] floatValue] * progress
                                              alpha:[self.lgf_SubSelectColorRGBA[3] floatValue] + [self.lgf_SubDeltaRGBA[3] floatValue] * progress];
        selectTitle.lgf_SubTitle.textColor = [UIColor
                                           colorWithRed:[self.lgf_SubUnSelectColorRGBA[0] floatValue] - [self.lgf_SubDeltaRGBA[0] floatValue] * progress
                                           green:[self.lgf_SubUnSelectColorRGBA[1] floatValue] - [self.lgf_SubDeltaRGBA[1] floatValue] * progress
                                           blue:[self.lgf_SubUnSelectColorRGBA[2] floatValue] - [self.lgf_SubDeltaRGBA[2] floatValue] * progress
                                           alpha:[self.lgf_SubUnSelectColorRGBA[3] floatValue] - [self.lgf_SubDeltaRGBA[3] floatValue] * progress];
    }
    // 字体改变
    if (![self.lgf_Style.lgf_TitleSelectFont isEqual:self.lgf_Style.lgf_UnTitleSelectFont]) {
        if (progress > 0.5) {
            unSelectTitle.lgf_Title.font = self.lgf_Style.lgf_UnTitleSelectFont;
            selectTitle.lgf_Title.font = self.lgf_Style.lgf_TitleSelectFont ?: self.lgf_Style.lgf_UnTitleSelectFont;
        } else {
            unSelectTitle.lgf_Title.font = self.lgf_Style.lgf_TitleSelectFont ?: self.lgf_Style.lgf_UnTitleSelectFont;
            selectTitle.lgf_Title.font = self.lgf_Style.lgf_UnTitleSelectFont;
        }
    }
    if (self.lgf_Style.lgf_IsDoubleTitle) {
        if (![self.lgf_Style.lgf_SubTitleSelectFont isEqual:self.lgf_Style.lgf_UnSubTitleSelectFont]) {
            if (progress > 0.5) {
                unSelectTitle.lgf_SubTitle.font = self.lgf_Style.lgf_UnSubTitleSelectFont;
                selectTitle.lgf_SubTitle.font = self.lgf_Style.lgf_SubTitleSelectFont ?: self.lgf_Style.lgf_UnSubTitleSelectFont;
            } else {
                unSelectTitle.lgf_SubTitle.font = self.lgf_Style.lgf_SubTitleSelectFont ?: self.lgf_Style.lgf_UnSubTitleSelectFont;
                selectTitle.lgf_SubTitle.font = self.lgf_Style.lgf_UnSubTitleSelectFont;
            }
        }
    }
    // 左边图标选中
    if (self.lgf_Style.lgf_LeftImageWidth > 0.0) {
        if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
            if (progress > 0.5) {
                [unSelectTitle.lgf_LeftImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_LeftImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            } else {
                [unSelectTitle.lgf_LeftImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_LeftImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 右边图标选中
    if (self.lgf_Style.lgf_RightImageWidth > 0.0) {
        if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
            if (progress > 0.5) {
                [unSelectTitle.lgf_RightImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_RightImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            } else {
                [unSelectTitle.lgf_RightImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_RightImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 顶部图标选中
    if (self.lgf_Style.lgf_TopImageHeight > 0.0) {
        if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
            if (progress > 0.5) {
                [unSelectTitle.lgf_TopImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_TopImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            } else {
                [unSelectTitle.lgf_TopImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_TopImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 底部图标选中
    if (self.lgf_Style.lgf_BottomImageHeight > 0.0) {
        if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
            if (progress > 0.5) {
                [unSelectTitle.lgf_BottomImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_BottomImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            } else {
                [unSelectTitle.lgf_BottomImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[unselectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_BottomImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[selectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 标缩放大小改变
    CGFloat deltaScale = self.lgf_Style.lgf_TitleBigScale - 1.0;
    unSelectTitle.lgf_CurrentTransformSX = self.lgf_Style.lgf_TitleBigScale - deltaScale * progress;
    selectTitle.lgf_CurrentTransformSX = 1.0 + deltaScale * progress;
    
    CGFloat mainTitleDeltaScale = self.lgf_Style.lgf_MainTitleBigScale - 1.0;
    unSelectTitle.lgf_MainTitleCurrentTransformSX = self.lgf_Style.lgf_MainTitleBigScale - mainTitleDeltaScale * progress;
    selectTitle.lgf_MainTitleCurrentTransformSX = 1.0 + mainTitleDeltaScale * progress;
    
    CGFloat subTitleDeltaScale = self.lgf_Style.lgf_SubTitleBigScale - 1.0;
    unSelectTitle.lgf_SubTitleCurrentTransformSX = self.lgf_Style.lgf_SubTitleBigScale - subTitleDeltaScale * progress;
    selectTitle.lgf_SubTitleCurrentTransformSX = 1.0 + subTitleDeltaScale * progress;
    
    unSelectTitle.lgf_MainTitleCurrentTransformTY = self.lgf_Style.lgf_MainTitleUpDownScale - self.lgf_Style.lgf_MainTitleUpDownScale * progress;
    selectTitle.lgf_MainTitleCurrentTransformTY = self.lgf_Style.lgf_MainTitleUpDownScale * progress;
    
    unSelectTitle.lgf_SubTitleCurrentTransformTY = self.lgf_Style.lgf_SubTitleUpDownScale - self.lgf_Style.lgf_SubTitleUpDownScale * progress;
    selectTitle.lgf_SubTitleCurrentTransformTY = self.lgf_Style.lgf_SubTitleUpDownScale * progress;
    
    // 标底部滚动条 更新位置
    if (self.lgf_TitleLine && self.lgf_Style.lgf_IsShowLine) {
        if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationDefult) {
            if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitle) {
                CGFloat xDistance = selectTitle.lgfpt_X - unSelectTitle.lgfpt_X;
                CGFloat wDistance = (selectTitle.lgf_Title.lgfpt_Width - unSelectTitle.lgf_Title.lgfpt_Width) * self.lgf_Style.lgf_TitleBigScale;
                self.lgf_TitleLine.lgfpt_X = unSelectTitle.lgfpt_X + xDistance * progress;
                self.lgf_TitleLine.lgfpt_Width = unSelectTitle.lgfpt_Width + wDistance * progress;
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTRAndImage) {
                CGFloat xDistance = selectTitle.lgfpt_X - unSelectTitle.lgfpt_X;
                CGFloat wDistance = (selectTitle.lgf_Title.lgfpt_Width - unSelectTitle.lgf_Title.lgfpt_Width) * self.lgf_Style.lgf_TitleBigScale;
                self.lgf_TitleLine.lgfpt_X = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? unSelectTitle.lgfpt_X + xDistance * progress : (self.lgf_Style.lgf_TitleLeftRightSpace * self.lgf_Style.lgf_TitleBigScale + unSelectTitle.lgfpt_X + xDistance * progress);
                self.lgf_TitleLine.lgfpt_Width = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? unSelectTitle.lgfpt_Width + (selectTitle.lgfpt_Width - unSelectTitle.lgfpt_Width) * progress : ((unSelectTitle.lgf_Title.lgfpt_Width + self.lgf_Style.lgf_LeftImageSpace + self.lgf_Style.lgf_RightImageSpace + self.lgf_Style.lgf_LeftImageWidth + self.lgf_Style.lgf_RightImageWidth) * self.lgf_Style.lgf_TitleBigScale + wDistance * progress);
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTR) {
                CGFloat space = (selectTitle.lgf_TitleWidth.constant * self.lgf_Style.lgf_MainTitleBigScale - selectTitle.lgf_TitleWidth.constant) * self.lgf_Style.lgf_TitleBigScale / 2;
                CGFloat xDistance = selectTitle.lgfpt_X - unSelectTitle.lgfpt_X - space;
                CGFloat wDistance = (selectTitle.lgf_Title.lgfpt_Width - unSelectTitle.lgf_Title.lgfpt_Width) * self.lgf_Style.lgf_TitleBigScale;
                self.lgf_TitleLine.lgfpt_X = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? unSelectTitle.lgfpt_X + xDistance * progress : (unSelectTitle.lgf_Title.lgfpt_X) * self.lgf_Style.lgf_TitleBigScale + unSelectTitle.lgfpt_X + xDistance * progress;
                self.lgf_TitleLine.lgfpt_Width = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? unSelectTitle.lgfpt_Width + (selectTitle.lgfpt_Width - unSelectTitle.lgfpt_Width) * progress : (unSelectTitle.lgf_Title.lgfpt_Width * self.lgf_Style.lgf_TitleBigScale) + wDistance * progress;
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_FixedWith) {
                CGFloat select_title_x = selectTitle.lgfpt_X + ((selectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0);
                CGFloat un_select_title_x = unSelectTitle.lgfpt_X + ((unSelectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0);
                CGFloat xDistance = select_title_x - un_select_title_x;
                CGFloat xxDistance = selectTitle.lgfpt_X - unSelectTitle.lgfpt_X;
                CGFloat wDistance = selectTitle.lgfpt_Width - unSelectTitle.lgfpt_Width;
                self.lgf_TitleLine.lgfpt_X = self.lgf_Style.lgf_LineWidth > unSelectTitle.lgfpt_Width + wDistance * progress ? unSelectTitle.lgfpt_X + xxDistance * progress : un_select_title_x + xDistance * progress;
                self.lgf_TitleLine.lgfpt_Width = MIN(self.lgf_Style.lgf_LineWidth, unSelectTitle.lgfpt_Width + wDistance * progress);
            }
        } else if (self.lgf_Style.lgf_LineAnimation == lgf_PageLineAnimationSmallToBig) {
            CGFloat selectX = 0.0;
            CGFloat selectWidth = 0.0;
            CGFloat unSelectX = 0.0;
            CGFloat unSelectWidth = 0.0;
            if (self.lgf_Style.lgf_TitleFixedWidth > 0.0) {
                self.lgf_Style.lgf_LineWidthType = lgf_FixedWith;
                self.lgf_Style.lgf_LineWidth = self.lgf_Style.lgf_LineWidth > 0.0 ? self.lgf_Style.lgf_LineWidth : self.lgf_Style.lgf_TitleFixedWidth;
            }
            if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitle) {
                selectX = selectTitle.lgfpt_X;
                selectWidth = selectTitle.lgfpt_Width;
                unSelectX = unSelectTitle.lgfpt_X;
                unSelectWidth = unSelectTitle.lgfpt_Width;
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTRAndImage) {
                selectX = selectTitle.lgfpt_X + self.lgf_Style.lgf_TitleLeftRightSpace * selectTitle.lgf_CurrentTransformSX;
                selectWidth = (self.lgf_Style.lgf_LeftImageWidth + self.lgf_Style.lgf_LeftImageSpace + selectTitle.lgf_Title.lgfpt_Width + self.lgf_Style.lgf_RightImageSpace + self.lgf_Style.lgf_RightImageWidth) * selectTitle.lgf_CurrentTransformSX;
                unSelectX = unSelectTitle.lgfpt_X + self.lgf_Style.lgf_TitleLeftRightSpace * unSelectTitle.lgf_CurrentTransformSX;
                unSelectWidth = (self.lgf_Style.lgf_LeftImageWidth + self.lgf_Style.lgf_LeftImageSpace + unSelectTitle.lgf_Title.lgfpt_Width + self.lgf_Style.lgf_RightImageSpace + self.lgf_Style.lgf_RightImageWidth) * unSelectTitle.lgf_CurrentTransformSX;
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTR) {
                selectX = selectTitle.lgfpt_X + (selectTitle.lgf_Title.lgfpt_X) * selectTitle.lgf_CurrentTransformSX;
                selectWidth = selectTitle.lgf_Title.lgfpt_Width * selectTitle.lgf_CurrentTransformSX;
                unSelectX = unSelectTitle.lgfpt_X + (unSelectTitle.lgf_Title.lgfpt_X) * unSelectTitle.lgf_CurrentTransformSX;
                unSelectWidth = unSelectTitle.lgf_Title.lgfpt_Width * unSelectTitle.lgf_CurrentTransformSX;
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_FixedWith) {
                selectX = selectTitle.lgfpt_X + (selectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0;
                selectWidth = self.lgf_Style.lgf_LineWidth;
                unSelectX = unSelectTitle.lgfpt_X + (unSelectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0;
                unSelectWidth = self.lgf_Style.lgf_LineWidth;
            }
            CGFloat space = self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTR ? ((selectTitle.lgf_TitleWidth.constant * self.lgf_Style.lgf_MainTitleBigScale - selectTitle.lgf_TitleWidth.constant) / 2 - (unSelectTitle.lgf_TitleWidth.constant * self.lgf_Style.lgf_MainTitleBigScale - unSelectTitle.lgf_TitleWidth.constant) / 2) : 0.0;
            CGFloat scaleWidth = ((selectTitle.lgfpt_Width - selectTitle.lgfpt_Width / selectTitle.lgf_CurrentTransformSX)) + ((unSelectTitle.lgfpt_Width - unSelectTitle.lgfpt_Width / unSelectTitle.lgf_CurrentTransformSX));
            
            CGFloat differenceWidth = self.lgf_Style.lgf_LineWidthType == lgf_FixedWith ? (unSelectTitle.lgfpt_Width - selectTitle.lgfpt_Width) : 0.0;
            if (progress > 0.5) {
                if (unselectIndex < selectIndex) {
                    self.lgf_TitleLine.lgfpt_X = selectX - (unSelectTitle.lgfpt_Width * 2 - scaleWidth - differenceWidth - space) * (1.0 - progress);
                } else {
                    self.lgf_TitleLine.lgfpt_X = selectX;
                }
            } else {
                if (unselectIndex > selectIndex) {
                    self.lgf_TitleLine.lgfpt_X = unSelectX - (selectTitle.lgfpt_Width * 2 - scaleWidth + differenceWidth + space) * progress;
                } else {
                    self.lgf_TitleLine.lgfpt_X = unSelectX;
                }
            }
            if (progress > 0.5) {
                self.lgf_TitleLine.lgfpt_Width = selectWidth + (unSelectTitle.lgfpt_Width * 2 - scaleWidth - differenceWidth - space) * (1.0 - progress);
            } else {
                self.lgf_TitleLine.lgfpt_Width = unSelectWidth + (selectTitle.lgfpt_Width * 2 - scaleWidth + differenceWidth + space) * progress;
            }
        }
    }
}

#pragma mark - 更新标view的UI(用于点击标的时候)
- (void)lgf_AdjustUIWhenBtnOnClickWithAnimate:(BOOL)animated {
    self.lgf_IsSelectTitle = YES;
    self.lgf_Enabled = NO;
    if (self.lgf_Style.lgf_TitleHaveAnimation && self.lgf_PageView) self.lgf_PageView.scrollEnabled = NO;
    // 外部分页控制器 滚动到对应下标
    if (self.lgf_PageView) [self.lgf_PageView setContentOffset:CGPointMake(self.lgf_PageView.lgfpt_Width * self.lgf_SelectIndex, 0)];
    // 取得 前一个选中的标 和 将要选中的标
    LGFFreePTTitle *unSelectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[self.lgf_UnSelectIndex];
    LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)self.lgf_TitleButtons[self.lgf_SelectIndex];
    // 动画时间
    CGFloat animatedTime = self.lgf_Style.lgf_TitleHaveAnimation ? animated ? 0.3 : 0.0 : 0.0;
    [UIView animateWithDuration:animatedTime animations:^{
        // 标缩放大小改变
        unSelectTitle.lgf_CurrentTransformSX = 1.0;
        selectTitle.lgf_CurrentTransformSX = self.lgf_Style.lgf_TitleBigScale;
        unSelectTitle.lgf_MainTitleCurrentTransformSX = 1.0;
        selectTitle.lgf_MainTitleCurrentTransformSX = self.lgf_Style.lgf_MainTitleBigScale;
        unSelectTitle.lgf_SubTitleCurrentTransformSX = 1.0;
        selectTitle.lgf_SubTitleCurrentTransformSX = self.lgf_Style.lgf_SubTitleBigScale;
        unSelectTitle.lgf_MainTitleCurrentTransformTY = 0.0;
        selectTitle.lgf_MainTitleCurrentTransformTY = self.lgf_Style.lgf_MainTitleUpDownScale;
        unSelectTitle.lgf_SubTitleCurrentTransformTY = 0.0;
        selectTitle.lgf_SubTitleCurrentTransformTY = self.lgf_Style.lgf_SubTitleUpDownScale;
        

        // 标颜色渐变
        unSelectTitle.lgf_Title.textColor = self.lgf_Style.lgf_UnTitleSelectColor;
        selectTitle.lgf_Title.textColor = self.lgf_Style.lgf_TitleSelectColor;
        if (self.lgf_Style.lgf_IsDoubleTitle) {
            unSelectTitle.lgf_SubTitle.textColor = self.lgf_Style.lgf_UnSubTitleSelectColor;
            selectTitle.lgf_SubTitle.textColor = self.lgf_Style.lgf_SubTitleSelectColor;
        }
        // 字体改变
        if (![self.lgf_Style.lgf_TitleSelectFont isEqual:self.lgf_Style.lgf_UnTitleSelectFont]) {
            unSelectTitle.lgf_Title.font = self.lgf_Style.lgf_UnTitleSelectFont;
            selectTitle.lgf_Title.font = self.lgf_Style.lgf_TitleSelectFont ?: self.lgf_Style.lgf_UnTitleSelectFont;
            if (self.lgf_Style.lgf_IsDoubleTitle) {
                unSelectTitle.lgf_SubTitle.font = self.lgf_Style.lgf_UnSubTitleSelectFont;
                selectTitle.lgf_SubTitle.font = self.lgf_Style.lgf_SubTitleSelectFont ?: self.lgf_Style.lgf_UnSubTitleSelectFont;
            }
        }
        // 左边图标选中
        if (self.lgf_Style.lgf_LeftImageWidth > 0.0) {
            if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
                [unSelectTitle.lgf_LeftImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[self.lgf_UnSelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_LeftImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[self.lgf_SelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        // 右边图标选中
        if (self.lgf_Style.lgf_RightImageWidth > 0.0) {
            if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
                [unSelectTitle.lgf_RightImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[self.lgf_UnSelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_RightImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[self.lgf_SelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        // 顶部图标选中
        if (self.lgf_Style.lgf_TopImageHeight > 0.0) {
            if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
                [unSelectTitle.lgf_TopImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[self.lgf_UnSelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_TopImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[self.lgf_SelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        // 底部图标选中
        if (self.lgf_Style.lgf_BottomImageHeight > 0.0) {
            if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
                [unSelectTitle.lgf_BottomImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_UnSelectImageNames[self.lgf_UnSelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
                [selectTitle.lgf_BottomImage setImage:[UIImage imageNamed:self.lgf_Style.lgf_SelectImageNames[self.lgf_SelectIndex] inBundle:self.lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        // 标底部滚动条 更新位置
        if (self.lgf_TitleLine && self.lgf_Style.lgf_IsShowLine) {
            if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitle) {
                self.lgf_TitleLine.lgfpt_X = selectTitle.lgfpt_X;
                self.lgf_TitleLine.lgfpt_Width = selectTitle.lgfpt_Width;
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTRAndImage) {
                self.lgf_TitleLine.lgfpt_X = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? selectTitle.lgfpt_X : (self.lgf_Style.lgf_TitleLeftRightSpace * self.lgf_Style.lgf_TitleBigScale + selectTitle.lgfpt_X);
                self.lgf_TitleLine.lgfpt_Width = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? selectTitle.lgfpt_Width : ((self.lgf_Style.lgf_LeftImageSpace + self.lgf_Style.lgf_LeftImageWidth + selectTitle.lgf_Title.lgfpt_Width + self.lgf_Style.lgf_RightImageWidth + self.lgf_Style.lgf_RightImageSpace) * self.lgf_Style.lgf_TitleBigScale);
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_EqualTitleSTR) {
                CGFloat space = (selectTitle.lgf_TitleWidth.constant * self.lgf_Style.lgf_MainTitleBigScale - selectTitle.lgf_TitleWidth.constant) * self.lgf_Style.lgf_TitleBigScale / 2;
                self.lgf_TitleLine.lgfpt_X = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? selectTitle.lgfpt_X : ((self.lgf_Style.lgf_TitleLeftRightSpace + self.lgf_Style.lgf_LeftImageSpace + self.lgf_Style.lgf_LeftImageWidth) * self.lgf_Style.lgf_TitleBigScale - space + selectTitle.lgfpt_X);
                self.lgf_TitleLine.lgfpt_Width = self.lgf_Style.lgf_TitleFixedWidth > 0.0 ? selectTitle.lgfpt_Width : (selectTitle.lgf_Title.lgfpt_Width * self.lgf_Style.lgf_TitleBigScale);
            } else if (self.lgf_Style.lgf_LineWidthType == lgf_FixedWith){
                self.lgf_TitleLine.lgfpt_X = self.lgf_Style.lgf_LineWidth > selectTitle.lgfpt_Width ? selectTitle.lgfpt_X : selectTitle.lgfpt_X + ((selectTitle.lgfpt_Width - self.lgf_Style.lgf_LineWidth) / 2.0);
                self.lgf_TitleLine.lgfpt_Width = MIN(self.lgf_Style.lgf_LineWidth, selectTitle.lgfpt_Width);
            }
        }
    } completion:^(BOOL finished) {
        [self LGF_TitleAutoScrollToTheMiddle:self.lgf_SelectIndex animated:YES];
        self.lgf_IsSelectTitle = NO;
        self.lgf_Enabled = YES;
    }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.lgf_Enabled = NO;
        if (!self.lgf_IsSelectTitle) {
            [self lgf_ConvertToProgress:self.lgf_PageView.contentOffset.x];
        }
        if ((NSInteger)self.lgf_PageView.contentOffset.x % (NSInteger)self.lgf_PageView.lgfpt_Width == 0) {
            self.lgf_Enabled = YES;
            [self lgf_AutoScrollTitle];
        }
    }
}

#pragma mark - 销毁
- (void)dealloc {
    if (self.lgf_PageView) [self.lgf_PageView removeObserver:self forKeyPath:@"contentOffset"];
    LGFPTLog(@"LGF的分页控件:LGFFreePT --- 已经释放");
}

#pragma mark - 懒加载
- (void)setLgf_Enabled:(BOOL)lgf_Enabled {
    _lgf_Enabled = lgf_Enabled;
    if (self.lgf_PageView){
        if (lgf_Enabled) {
            self.userInteractionEnabled = YES;
            if (self.lgf_Style.lgf_TitleHaveAnimation) self.lgf_PageView.scrollEnabled = YES;
            self.lgf_PageView.userInteractionEnabled = YES;
            self.lgf_PageView.panGestureRecognizer.view.userInteractionEnabled = YES;
        } else {
            self.userInteractionEnabled = NO;
            self.lgf_PageView.userInteractionEnabled = NO;
            self.lgf_PageView.panGestureRecognizer.view.userInteractionEnabled = NO;
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
        lgf_PageView.tag = 333333;
    }
}

- (LGFFreePTLine *)lgf_TitleLine {
    if (!_lgf_TitleLine) {
        _lgf_TitleLine = [LGFFreePTLine lgf_AllocLine:self.lgf_Style];
    }
    return _lgf_TitleLine;
}

- (NSArray *)lgf_UnSelectColorRGBA {
    if (!_lgf_UnSelectColorRGBA) {
        NSArray *unSelectColorRGBA = [LGFFreePTMethod lgf_GetColorRGBA:self.lgf_Style.lgf_UnTitleSelectColor];
        NSAssert(unSelectColorRGBA, @"设置普通状态的文字颜色时 请使用RGBA空间的颜色值");
        _lgf_UnSelectColorRGBA = unSelectColorRGBA;
    }
    return  _lgf_UnSelectColorRGBA;
}

- (NSArray *)lgf_SelectColorRGBA {
    if (!_lgf_SelectColorRGBA) {
        NSArray *selectColorRGBA = [LGFFreePTMethod lgf_GetColorRGBA:self.lgf_Style.lgf_TitleSelectColor];
        NSAssert(selectColorRGBA, @"设置选中状态的文字颜色时 请使用RGBA空间的颜色值");
        _lgf_SelectColorRGBA = selectColorRGBA;
    }
    return  _lgf_SelectColorRGBA;
}

- (NSArray *)lgf_DeltaRGBA {
    if (_lgf_DeltaRGBA == nil) {
        NSArray *delta;
        if (self.lgf_UnSelectColorRGBA && self.lgf_SelectColorRGBA) {
            CGFloat deltaR = [self.lgf_UnSelectColorRGBA[0] floatValue] - [self.lgf_SelectColorRGBA[0] floatValue];
            CGFloat deltaG = [self.lgf_UnSelectColorRGBA[1] floatValue] - [self.lgf_SelectColorRGBA[1] floatValue];
            CGFloat deltaB = [self.lgf_UnSelectColorRGBA[2] floatValue] - [self.lgf_SelectColorRGBA[2] floatValue];
            CGFloat deltaA = [self.lgf_UnSelectColorRGBA[3] floatValue] - [self.lgf_SelectColorRGBA[3] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
            _lgf_DeltaRGBA = delta;
        }
    }
    return _lgf_DeltaRGBA;
}

- (NSArray *)lgf_SubUnSelectColorRGBA {
    if (!_lgf_SubUnSelectColorRGBA) {
        NSArray *subUnSelectColorRGBA = [LGFFreePTMethod lgf_GetColorRGBA:self.lgf_Style.lgf_UnSubTitleSelectColor];
        NSAssert(subUnSelectColorRGBA, @"设置普通状态的文字颜色时 请使用RGBA空间的颜色值");
        _lgf_SubUnSelectColorRGBA = subUnSelectColorRGBA;
    }
    return  _lgf_SubUnSelectColorRGBA;
}

- (NSArray *)lgf_SubSelectColorRGBA {
    if (!_lgf_SubSelectColorRGBA) {
        NSArray *subSelectColorRGBA = [LGFFreePTMethod lgf_GetColorRGBA:self.lgf_Style.lgf_SubTitleSelectColor];
        NSAssert(subSelectColorRGBA, @"设置选中状态的文字颜色时 请使用RGBA空间的颜色值");
        _lgf_SubSelectColorRGBA = subSelectColorRGBA;
    }
    return  _lgf_SubSelectColorRGBA;
}

- (NSArray *)lgf_SubDeltaRGBA {
    if (_lgf_SubDeltaRGBA == nil) {
        NSArray *subDelta;
        if (self.lgf_SubUnSelectColorRGBA && self.lgf_SubSelectColorRGBA) {
            CGFloat subDeltaR = [self.lgf_SubUnSelectColorRGBA[0] floatValue] - [self.lgf_SubSelectColorRGBA[0] floatValue];
            CGFloat subDeltaG = [self.lgf_SubUnSelectColorRGBA[1] floatValue] - [self.lgf_SubSelectColorRGBA[1] floatValue];
            CGFloat subDeltaB = [self.lgf_SubUnSelectColorRGBA[2] floatValue] - [self.lgf_SubSelectColorRGBA[2] floatValue];
            CGFloat subDeltaA = [self.lgf_SubUnSelectColorRGBA[3] floatValue] - [self.lgf_SubSelectColorRGBA[3] floatValue];
            subDelta = [NSArray arrayWithObjects:@(subDeltaR), @(subDeltaG), @(subDeltaB), @(subDeltaA), nil];
            _lgf_SubDeltaRGBA = subDelta;
        }
    }
    return _lgf_SubDeltaRGBA;
}

- (NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons {
    if (!_lgf_TitleButtons) {
        _lgf_TitleButtons = [NSMutableArray new];
    }
    return _lgf_TitleButtons;
}
@end
