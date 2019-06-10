//
//  LGFFreePTTitle.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTTitle.h"
#import "UIView+LGFFreePT.h"
#import "LGFFreePTMethod.h"

@interface LGFFreePTTitle()
@end
@implementation LGFFreePTTitle

+ (instancetype)lgf_AllocTitle:(NSString *)titleText index:(NSInteger)index style:(LGFFreePTStyle *)style delegate:(id<LGFFreePTTitleDelegate>)delegate {
    // 初始化标
    LGFFreePTTitle *title = [LGFPTBundle loadNibNamed:NSStringFromClass([LGFFreePTTitle class]) owner:self options:nil].firstObject;
    title.tag = index;
    title.lgf_FreePTTitleDelegate = delegate;
    title.lgf_Style = style;
    
    // 开启调试模式所有背景将设置随机颜色方便调试
    if (title.lgf_Style.lgf_StartDebug) {
        title.backgroundColor = LGFPTRandomColor;
        title.lgf_Title.backgroundColor = LGFPTRandomColor;
        title.lgf_SubTitle.backgroundColor = LGFPTRandomColor;
        title.lgf_LeftImage.backgroundColor = LGFPTRandomColor;
        title.lgf_RightImage.backgroundColor = LGFPTRandomColor;
        title.lgf_TopImage.backgroundColor = LGFPTRandomColor;
        title.lgf_BottomImage.backgroundColor = LGFPTRandomColor;
    }
    
    // 需要显示子标题
    if (title.lgf_Style.lgf_IsDoubleTitle) {
        title.lgf_Title.text = [titleText componentsSeparatedByString:@"~~~"].firstObject;
        title.lgf_SubTitle.text = [titleText componentsSeparatedByString:@"~~~"].lastObject;
    } else {
        title.lgf_Title.text = titleText;
    }
    
    // 获取字体宽度
    title.lgf_Title.adjustsFontSizeToFitWidth = YES;
    CGSize titleSize = [LGFFreePTMethod lgf_SizeWithString:title.lgf_Title.text font:(title.lgf_Style.lgf_TitleSelectFont.pointSize > title.lgf_Style.lgf_UnTitleSelectFont.pointSize ? title.lgf_Style.lgf_TitleSelectFont : title.lgf_Style.lgf_UnTitleSelectFont) maxSize:CGSizeMake(CGFLOAT_MAX, title.lgf_Style.lgf_PVTitleView.lgfpt_Height)];
    CGSize subTitleSize = CGSizeZero;
    if (title.lgf_Style.lgf_IsDoubleTitle) {
        title.lgf_SubTitle.adjustsFontSizeToFitWidth = YES;
        subTitleSize = [LGFFreePTMethod lgf_SizeWithString:title.lgf_SubTitle.text font:(title.lgf_Style.lgf_SubTitleSelectFont.pointSize > title.lgf_Style.lgf_UnSubTitleSelectFont.pointSize ? title.lgf_Style.lgf_SubTitleSelectFont : title.lgf_Style.lgf_UnSubTitleSelectFont) maxSize:CGSizeMake(CGFLOAT_MAX, title.lgf_Style.lgf_PVTitleView.lgfpt_Height)];
        title.lgf_SubTitleHeight.constant = subTitleSize.height;
        title.lgf_TitleCenterY.constant = title.lgf_TitleCenterY.constant - subTitleSize.height / 2.0 - title.lgf_Style.lgf_SubTitleTopSpace / 2.0;
        title.lgf_SubTitleTop.constant = title.lgf_Style.lgf_SubTitleTopSpace;
        title.lgf_SubTitleWidth.constant = subTitleSize.width;
    }
    title.lgf_TitleWidth.constant = titleSize.width;
    title.lgf_TitleHeight.constant = titleSize.height;
    
    // 标 X
    CGFloat titleX = 0.0;
    if (index > 0) {
        UIView *subview = title.lgf_Style.lgf_PVTitleView.subviews[index - 1];
        titleX = subview.lgfpt_X + subview.lgfpt_Width;
    } else {
        titleX = title.lgf_Style.lgf_PageLeftRightSpace;
    }
    
    // 标宽度
    CGFloat maxWidth = MAX(titleSize.width, subTitleSize.width) * 1.05;
    CGFloat titleWidth = title.lgf_Style.lgf_TitleFixedWidth > 0.0 ? title.lgf_Style.lgf_TitleFixedWidth : (maxWidth + (style.lgf_TitleLeftRightSpace * 2.0) + title.lgf_Style.lgf_LeftImageWidth + title.lgf_Style.lgf_RightImageWidth + title.lgf_Style.lgf_LeftImageSpace + title.lgf_Style.lgf_RightImageSpace);
    
    title.frame = CGRectMake(titleX,
                             0.0,
                             titleWidth,
                             title.lgf_Style.lgf_PVTitleView.lgfpt_Height);
    
    [title.lgf_Style.lgf_PVTitleView addSubview:title];
    
    // 根据特殊 title 数组 和 特殊 title 的 tag 判断某个 index 是否要替换特殊 title
    if (style.lgf_FreePTSpecialTitleArray.count > 0) {
        for (UIView *specialTitle in style.lgf_FreePTSpecialTitleArray) {
            NSArray *propertyArray = [specialTitle.lgf_FreePTSpecialTitleProperty componentsSeparatedByString:@"~~~"];
            NSInteger specialTitleIndex = [propertyArray.firstObject integerValue];
            if (index == specialTitleIndex) {
                [title.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                title.lgfpt_Width = [propertyArray.lastObject floatValue];
                specialTitle.frame = title.bounds;
                [title addSubview:specialTitle];
            }
        }
    }
    
    // 注意：这个代理放在最下面，对一些 LGFFreePTStyle 配置的属性拥有最终修改权
    if (title.lgf_FreePTTitleDelegate && [title.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitle:index:style:)]) {
        [title.lgf_FreePTTitleDelegate lgf_GetTitle:title index:index style:style];
    }
    return title;
}

#pragma mark - 标整体状态改变 核心逻辑部分
- (void)lgf_SetMainTitleTransform:(CGFloat)progress isSelectTitle:(BOOL)isSelectTitle selectIndex:(NSInteger)selectIndex unselectIndex:(NSInteger)unselectIndex {
    CGFloat deltaScale = self.lgf_Style.lgf_TitleTransformSX - 1.0;
    CGFloat mainTitleDeltaScale = self.lgf_Style.lgf_MainTitleTransformSX - 1.0;
    CGFloat subTitleDeltaScale = self.lgf_Style.lgf_SubTitleTransformSX - 1.0;
    
    if (isSelectTitle) {
        self.lgf_CurrentTransformSX = 1.0 + deltaScale * progress;
        self.lgf_MainTitleCurrentTransformSX = 1.0 + mainTitleDeltaScale * progress;
        self.lgf_MainTitleCurrentTransformTY = self.lgf_Style.lgf_MainTitleTransformTY * progress;
        self.lgf_MainTitleCurrentTransformTX = self.lgf_Style.lgf_MainTitleTransformTX * progress;
        self.lgf_SubTitleCurrentTransformSX = 1.0 + subTitleDeltaScale * progress;
        self.lgf_SubTitleCurrentTransformTY = self.lgf_Style.lgf_SubTitleTransformTY * progress;
        self.lgf_SubTitleCurrentTransformTX = self.lgf_Style.lgf_SubTitleTransformTX * progress;
    } else {
        self.lgf_CurrentTransformSX = self.lgf_Style.lgf_TitleTransformSX - deltaScale * progress;
        self.lgf_MainTitleCurrentTransformSX = self.lgf_Style.lgf_MainTitleTransformSX - mainTitleDeltaScale * progress;
        self.lgf_MainTitleCurrentTransformTY = self.lgf_Style.lgf_MainTitleTransformTY - self.lgf_Style.lgf_MainTitleTransformTY * progress;
        self.lgf_MainTitleCurrentTransformTX = self.lgf_Style.lgf_MainTitleTransformTX - self.lgf_Style.lgf_MainTitleTransformTX * progress;
        self.lgf_SubTitleCurrentTransformSX = self.lgf_Style.lgf_SubTitleTransformSX - subTitleDeltaScale * progress;
        self.lgf_SubTitleCurrentTransformTY = self.lgf_Style.lgf_SubTitleTransformTY - self.lgf_Style.lgf_SubTitleTransformTY * progress;
        self.lgf_SubTitleCurrentTransformTX = self.lgf_Style.lgf_SubTitleTransformTX - self.lgf_Style.lgf_SubTitleTransformTX * progress;
    }
    
    self.transform = CGAffineTransformMakeScale(self.lgf_CurrentTransformSX, self.lgf_CurrentTransformSX);
    self.lgf_Title.transform = CGAffineTransformIdentity;
    self.lgf_Title.transform = CGAffineTransformMakeScale(self.lgf_MainTitleCurrentTransformSX, self.lgf_MainTitleCurrentTransformSX);
    self.lgf_Title.transform = CGAffineTransformTranslate(self.lgf_Title.transform, self.lgf_MainTitleCurrentTransformTX, self.lgf_MainTitleCurrentTransformTY);
    
    self.lgf_SubTitle.transform = CGAffineTransformIdentity;
    self.lgf_SubTitle.transform = CGAffineTransformMakeScale(self.lgf_SubTitleCurrentTransformSX, self.lgf_SubTitleCurrentTransformSX);
    self.lgf_SubTitle.transform = CGAffineTransformTranslate(self.lgf_SubTitle.transform, self.lgf_SubTitleCurrentTransformTX, self.lgf_SubTitleCurrentTransformTY);
    
    // 标颜色渐变
    if (self.lgf_Style.lgf_TitleSelectColor != self.lgf_Style.lgf_UnTitleSelectColor) {
        NSArray *colors = isSelectTitle ? self.lgf_UnSelectColorRGBA : self.lgf_SelectColorRGBA;
        self.lgf_Title.textColor = [UIColor
                                    colorWithRed:[colors[0] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[0] floatValue] : -[self.lgf_DeltaRGBA[0] floatValue]) * progress
                                    green:[colors[1] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[1] floatValue] : -[self.lgf_DeltaRGBA[1] floatValue]) * progress
                                    blue:[colors[2] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[2] floatValue] : -[self.lgf_DeltaRGBA[2] floatValue]) * progress
                                    alpha:[colors[3] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[3] floatValue] : -[self.lgf_DeltaRGBA[3] floatValue]) * progress];
    }
    if (self.lgf_Style.lgf_IsDoubleTitle && self.lgf_Style.lgf_SubTitleSelectColor != self.lgf_Style.lgf_UnSubTitleSelectColor) {
        NSArray *colors = isSelectTitle ? self.lgf_SubUnSelectColorRGBA : self.lgf_SubSelectColorRGBA;
        self.lgf_SubTitle.textColor = [UIColor
                                       colorWithRed:[colors[0] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[0] floatValue] : -[self.lgf_SubDeltaRGBA[0] floatValue]) * progress
                                       green:[colors[1] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[1] floatValue] : -[self.lgf_SubDeltaRGBA[1] floatValue]) * progress
                                       blue:[colors[2] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[2] floatValue] : -[self.lgf_SubDeltaRGBA[2] floatValue]) * progress
                                       alpha:[colors[3] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[3] floatValue] : -[self.lgf_SubDeltaRGBA[3] floatValue]) * progress];
    }
    
    // 字体改变
    if (![self.lgf_Style.lgf_TitleSelectFont isEqual:self.lgf_Style.lgf_UnTitleSelectFont]) {
        self.lgf_Title.font = (isSelectTitle == progress > 0.5) ? self.lgf_Style.lgf_TitleSelectFont : self.lgf_Style.lgf_UnTitleSelectFont;
    }
    if (self.lgf_Style.lgf_IsDoubleTitle) {
        if (![self.lgf_Style.lgf_SubTitleSelectFont isEqual:self.lgf_Style.lgf_UnSubTitleSelectFont]) {
            self.lgf_SubTitle.font = (isSelectTitle == progress > 0.5) ? self.lgf_Style.lgf_SubTitleSelectFont : self.lgf_Style.lgf_UnSubTitleSelectFont;
        }
    }
    
    // 图标选中
    if (self.lgf_Style.lgf_SelectImageNames && self.lgf_Style.lgf_SelectImageNames.count > 0 && self.lgf_Style.lgf_UnSelectImageNames && self.lgf_Style.lgf_UnSelectImageNames.count > 0) {
        NSString *ssImageName = self.lgf_Style.lgf_SelectImageNames[selectIndex];
        NSString *uuImageName = self.lgf_Style.lgf_UnSelectImageNames[unselectIndex];
        NSString *usImageName = self.lgf_Style.lgf_UnSelectImageNames[selectIndex];
        NSString *suImageName = self.lgf_Style.lgf_SelectImageNames[unselectIndex];
        if (self.lgf_Style.lgf_LeftImageWidth > 0.0 && self.lgf_Style.lgf_LeftImageHeight > 0.0) {
            if (self.lgf_Style.lgf_IsNetImage) {
                if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_LeftImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [self.lgf_LeftImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:self.lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        if (self.lgf_Style.lgf_RightImageWidth > 0.0 && self.lgf_Style.lgf_RightImageHeight > 0.0) {
            if (self.lgf_Style.lgf_IsNetImage) {
                if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_RightImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [self.lgf_RightImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:self.lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        if (self.lgf_Style.lgf_TopImageHeight > 0.0 && self.lgf_Style.lgf_TopImageWidth > 0.0) {
            if (self.lgf_Style.lgf_IsNetImage) {
                if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_TopImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [self.lgf_TopImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:self.lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        if (self.lgf_Style.lgf_BottomImageHeight > 0.0 && self.lgf_Style.lgf_BottomImageWidth > 0.0) {
            if (self.lgf_Style.lgf_IsNetImage) {
                if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_BottomImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [self.lgf_BottomImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:self.lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
    }
}

#pragma mark - 懒加载
- (void)setLgf_Style:(LGFFreePTStyle *)lgf_Style {
    _lgf_Style = lgf_Style;
    
    // 非主要属性配置
    if (lgf_Style.lgf_TitleCornerRadius > 0.0) {
        self.layer.cornerRadius = lgf_Style.lgf_TitleCornerRadius;
        if (!self.clipsToBounds) self.clipsToBounds = YES;
    }
    if (lgf_Style.lgf_TitleBorderWidth > 0.0) {
        self.layer.borderWidth = lgf_Style.lgf_TitleBorderWidth;
        self.layer.borderColor = lgf_Style.lgf_TitleBorderColor.CGColor;
        if (!self.clipsToBounds) self.clipsToBounds = YES;
    }
    
    // 标 Label 配置
    self.lgf_Title.textColor = lgf_Style.lgf_UnTitleSelectColor;
    self.lgf_Title.font = lgf_Style.lgf_UnTitleSelectFont;
    self.lgf_Title.textAlignment = NSTextAlignmentCenter;
    
    // 副标 Label 配置
    if (lgf_Style.lgf_IsDoubleTitle) {
        self.lgf_SubTitle.textColor = lgf_Style.lgf_UnSubTitleSelectColor;
        self.lgf_SubTitle.font = lgf_Style.lgf_UnSubTitleSelectFont;
        self.lgf_SubTitle.textAlignment = NSTextAlignmentCenter;
    }
    
    // 如果设置了都是相同标图片, 那么就强制转成全部相同图片
    if (lgf_Style.lgf_SameSelectImageName && lgf_Style.lgf_SameSelectImageName.length > 0 && lgf_Style.lgf_SameUnSelectImageName && lgf_Style.lgf_SameUnSelectImageName.length > 0) {
        [lgf_Style.lgf_Titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.lgf_SelectImageNames addObject:lgf_Style.lgf_SameSelectImageName];
            [self.lgf_UnSelectImageNames addObject:lgf_Style.lgf_SameUnSelectImageName];
        }];
        lgf_Style.lgf_SelectImageNames = self.lgf_SelectImageNames;
        lgf_Style.lgf_UnSelectImageNames = self.lgf_UnSelectImageNames;
    }
    
    // 是否需要显示标图片
    if (!lgf_Style.lgf_SelectImageNames || (lgf_Style.lgf_SelectImageNames.count < lgf_Style.lgf_Titles.count) || !lgf_Style.lgf_UnSelectImageNames || (lgf_Style.lgf_UnSelectImageNames.count < lgf_Style.lgf_Titles.count)) {
        self.lgf_IsHaveImage = NO;
        [self.lgf_TopImage removeFromSuperview];
        [self.lgf_BottomImage removeFromSuperview];
        [self.lgf_LeftImage removeFromSuperview];
        [self.lgf_RightImage removeFromSuperview];
        self.lgf_TopImageHeight.constant = 0.0;
        self.lgf_BottomImageHeight.constant = 0.0;
        self.lgf_LeftImageWidth.constant = 0.0;
        self.lgf_RightImageWidth.constant = 0.0;
        self.lgf_TopImageSpace.constant = 0.0;
        self.lgf_BottomImageSpace.constant = 0.0;
        self.lgf_LeftImageSpace.constant = 0.0;
        self.lgf_RightImageSpace.constant = 0.0;
        return;
    }
    
    self.lgf_IsHaveImage = YES;
    
    if (!lgf_Style.lgf_IsNetImage) NSAssert(lgf_Style.lgf_ImageBundel, @"为了获取正确的图片 - 请设置 (NSBundle *)style.lgf_ImageBundel");
    
    // 只要有宽度，允许设置左图片
    if (lgf_Style.lgf_LeftImageWidth > 0.0) {
        self.lgf_LeftImage.hidden = NO;
        self.lgf_LeftImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        self.lgf_LeftImageSpace.constant = lgf_Style.lgf_LeftImageSpace;
        self.lgf_LeftImageWidth.constant = MIN(lgf_Style.lgf_LeftImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        self.lgf_LeftImageHeight.constant = MIN(lgf_Style.lgf_LeftImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_LeftImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [self.lgf_LeftImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageWidth / 2);
        if (lgf_Style.lgf_LeftImageSpace > 0.0) {
            self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageSpace / 2);
        }
    } else {
        [self.lgf_LeftImage removeFromSuperview];
        LGFPTLog(@"如果要显示左边图标，请给 left_image_width 赋值");
    }
    
    // 只要有宽度，允许设置右图片
    if (lgf_Style.lgf_RightImageWidth > 0.0) {
        self.lgf_RightImage.hidden = NO;
        self.lgf_RightImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        self.lgf_RightImageSpace.constant = lgf_Style.lgf_RightImageSpace;
        self.lgf_RightImageWidth.constant = MIN(lgf_Style.lgf_RightImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        self.lgf_RightImageHeight.constant = MIN(lgf_Style.lgf_RightImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_RightImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [self.lgf_RightImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageWidth / 2.0);
        if (lgf_Style.lgf_RightImageSpace > 0.0) {
            self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageSpace / 2.0);
        }
    } else {
        [self.lgf_RightImage removeFromSuperview];
        LGFPTLog(@"如果要显示右边图标，请给 right_image_width 赋值");
    }
    
    // 只要有高度，允许设置上图片
    if (lgf_Style.lgf_TopImageHeight > 0.0) {
        self.lgf_TopImage.hidden = NO;
        self.lgf_TopImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        self.lgf_TopImageSpace.constant = lgf_Style.lgf_TopImageSpace;
        self.lgf_TopImageWidth.constant = MIN(lgf_Style.lgf_TopImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Width);
        self.lgf_TopImageHeight.constant = MIN(lgf_Style.lgf_TopImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_TopImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [self.lgf_TopImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageHeight / 2.0);
        if (lgf_Style.lgf_TopImageSpace > 0.0) {
            self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageSpace / 2.0);
        }
    } else {
        [self.lgf_TopImage removeFromSuperview];
        LGFPTLog(@"如果要显示顶部图标，请给 top_image_height 赋值");
    }
    
    // 只要有高度，允许设置下图片
    if (lgf_Style.lgf_BottomImageHeight > 0.0) {
        self.lgf_BottomImage.hidden = NO;
        self.lgf_BottomImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        self.lgf_BottomImageSpace.constant = lgf_Style.lgf_BottomImageSpace;
        self.lgf_BottomImageWidth.constant = MIN(lgf_Style.lgf_BottomImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Width);
        self.lgf_BottomImageHeight.constant = MIN(lgf_Style.lgf_BottomImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (self.lgf_FreePTTitleDelegate && [self.lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [self.lgf_FreePTTitleDelegate lgf_GetTitleNetImage:self.lgf_BottomImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [self.lgf_BottomImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageHeight / 2.0);
        if (lgf_Style.lgf_BottomImageSpace > 0.0) {
            self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageSpace / 2.0);
        }
    } else {
        [self.lgf_BottomImage removeFromSuperview];
        LGFPTLog(@"如果要显示底部图标，请给 bottom_image_height 赋值");
    }
}

- (NSMutableArray *)lgf_SelectImageNames {
    if (!_lgf_SelectImageNames) {
        _lgf_SelectImageNames = [NSMutableArray new];
    }
    return _lgf_SelectImageNames;
}

- (NSMutableArray *)lgf_UnSelectImageNames {
    if (!_lgf_UnSelectImageNames) {
        _lgf_UnSelectImageNames = [NSMutableArray new];
    }
    return _lgf_UnSelectImageNames;
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

@end
