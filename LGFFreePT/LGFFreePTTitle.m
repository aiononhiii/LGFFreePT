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
    CGFloat maxWidth = MAX(titleSize.width, subTitleSize.width);
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
    CGFloat deltaScale = _lgf_Style.lgf_TitleTransformSX - 1.0;
    CGFloat mainTitleDeltaScale = _lgf_Style.lgf_MainTitleTransformSX - 1.0;
    CGFloat subTitleDeltaScale = _lgf_Style.lgf_SubTitleTransformSX - 1.0;
    
    if (isSelectTitle) {
        _lgf_CurrentTransformSX = 1.0 + deltaScale * progress;
        _lgf_MainTitleCurrentTransformSX = 1.0 + mainTitleDeltaScale * progress;
        _lgf_MainTitleCurrentTransformTY = _lgf_Style.lgf_MainTitleTransformTY * progress;
        _lgf_MainTitleCurrentTransformTX = _lgf_Style.lgf_MainTitleTransformTX * progress;
        _lgf_SubTitleCurrentTransformSX = 1.0 + subTitleDeltaScale * progress;
        _lgf_SubTitleCurrentTransformTY = _lgf_Style.lgf_SubTitleTransformTY * progress;
        _lgf_SubTitleCurrentTransformTX = _lgf_Style.lgf_SubTitleTransformTX * progress;
    } else {
        _lgf_CurrentTransformSX = _lgf_Style.lgf_TitleTransformSX - deltaScale * progress;
        _lgf_MainTitleCurrentTransformSX = _lgf_Style.lgf_MainTitleTransformSX - mainTitleDeltaScale * progress;
        _lgf_MainTitleCurrentTransformTY = _lgf_Style.lgf_MainTitleTransformTY - _lgf_Style.lgf_MainTitleTransformTY * progress;
        _lgf_MainTitleCurrentTransformTX = _lgf_Style.lgf_MainTitleTransformTX - _lgf_Style.lgf_MainTitleTransformTX * progress;
        _lgf_SubTitleCurrentTransformSX = _lgf_Style.lgf_SubTitleTransformSX - subTitleDeltaScale * progress;
        _lgf_SubTitleCurrentTransformTY = _lgf_Style.lgf_SubTitleTransformTY - _lgf_Style.lgf_SubTitleTransformTY * progress;
        _lgf_SubTitleCurrentTransformTX = _lgf_Style.lgf_SubTitleTransformTX - _lgf_Style.lgf_SubTitleTransformTX * progress;
    }
    
    self.transform = CGAffineTransformMakeScale(_lgf_CurrentTransformSX, _lgf_CurrentTransformSX);
    _lgf_Title.transform = CGAffineTransformIdentity;
    _lgf_Title.transform = CGAffineTransformMakeScale(_lgf_MainTitleCurrentTransformSX, _lgf_MainTitleCurrentTransformSX);
    _lgf_Title.transform = CGAffineTransformTranslate(_lgf_Title.transform, _lgf_MainTitleCurrentTransformTX, _lgf_MainTitleCurrentTransformTY);
    
    _lgf_SubTitle.transform = CGAffineTransformIdentity;
    _lgf_SubTitle.transform = CGAffineTransformMakeScale(_lgf_SubTitleCurrentTransformSX, _lgf_SubTitleCurrentTransformSX);
    _lgf_SubTitle.transform = CGAffineTransformTranslate(_lgf_SubTitle.transform, _lgf_SubTitleCurrentTransformTX, _lgf_SubTitleCurrentTransformTY);
    
    // 标颜色渐变
    if (_lgf_Style.lgf_TitleSelectColor != _lgf_Style.lgf_UnTitleSelectColor) {
        NSArray *colors = isSelectTitle ? self.lgf_UnSelectColorRGBA : self.lgf_SelectColorRGBA;
        _lgf_Title.textColor = [UIColor
                                colorWithRed:[colors[0] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[0] floatValue] : -[self.lgf_DeltaRGBA[0] floatValue]) * progress
                                green:[colors[1] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[1] floatValue] : -[self.lgf_DeltaRGBA[1] floatValue]) * progress
                                blue:[colors[2] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[2] floatValue] : -[self.lgf_DeltaRGBA[2] floatValue]) * progress
                                alpha:[colors[3] floatValue] - (isSelectTitle ? [self.lgf_DeltaRGBA[3] floatValue] : -[self.lgf_DeltaRGBA[3] floatValue]) * progress];
    }
    if (_lgf_Style.lgf_IsDoubleTitle && _lgf_Style.lgf_SubTitleSelectColor != _lgf_Style.lgf_UnSubTitleSelectColor) {
        NSArray *colors = isSelectTitle ? self.lgf_SubUnSelectColorRGBA : self.lgf_SubSelectColorRGBA;
        _lgf_SubTitle.textColor = [UIColor
                                   colorWithRed:[colors[0] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[0] floatValue] : -[self.lgf_SubDeltaRGBA[0] floatValue]) * progress
                                   green:[colors[1] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[1] floatValue] : -[self.lgf_SubDeltaRGBA[1] floatValue]) * progress
                                   blue:[colors[2] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[2] floatValue] : -[self.lgf_SubDeltaRGBA[2] floatValue]) * progress
                                   alpha:[colors[3] floatValue] - (isSelectTitle ? [self.lgf_SubDeltaRGBA[3] floatValue] : -[self.lgf_SubDeltaRGBA[3] floatValue]) * progress];
    }
    
    // 字体改变
    if (![_lgf_Style.lgf_TitleSelectFont isEqual:_lgf_Style.lgf_UnTitleSelectFont]) {
        _lgf_Title.font = (isSelectTitle == progress > 0.5) ? _lgf_Style.lgf_TitleSelectFont : _lgf_Style.lgf_UnTitleSelectFont;
    }
    if (_lgf_Style.lgf_IsDoubleTitle) {
        if (![_lgf_Style.lgf_SubTitleSelectFont isEqual:_lgf_Style.lgf_UnSubTitleSelectFont]) {
            _lgf_SubTitle.font = (isSelectTitle == progress > 0.5) ? _lgf_Style.lgf_SubTitleSelectFont : _lgf_Style.lgf_UnSubTitleSelectFont;
        }
    }
    
    // 图标选中
    if (_lgf_Style.lgf_SelectImageNames && _lgf_Style.lgf_SelectImageNames.count > 0 && _lgf_Style.lgf_UnSelectImageNames && _lgf_Style.lgf_UnSelectImageNames.count > 0) {
        NSString *ssImageName = _lgf_Style.lgf_SelectImageNames[selectIndex];
        NSString *uuImageName = _lgf_Style.lgf_UnSelectImageNames[unselectIndex];
        NSString *usImageName = _lgf_Style.lgf_UnSelectImageNames[selectIndex];
        NSString *suImageName = _lgf_Style.lgf_SelectImageNames[unselectIndex];
        if (_lgf_Style.lgf_LeftImageWidth > 0.0 && _lgf_Style.lgf_LeftImageHeight > 0.0) {
            if (_lgf_Style.lgf_IsNetImage) {
                if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_LeftImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [_lgf_LeftImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:_lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        if (_lgf_Style.lgf_RightImageWidth > 0.0 && _lgf_Style.lgf_RightImageHeight > 0.0) {
            if (_lgf_Style.lgf_IsNetImage) {
                if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_RightImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [_lgf_RightImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:_lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        if (_lgf_Style.lgf_TopImageHeight > 0.0 && _lgf_Style.lgf_TopImageWidth > 0.0) {
            if (_lgf_Style.lgf_IsNetImage) {
                if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_TopImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [_lgf_TopImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:_lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
            }
        }
        if (_lgf_Style.lgf_BottomImageHeight > 0.0 && _lgf_Style.lgf_BottomImageWidth > 0.0) {
            if (_lgf_Style.lgf_IsNetImage) {
                if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                    [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_BottomImage imageUrl:[NSURL URLWithString:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName))]];
                } else {
                    LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
                }
            } else {
                [_lgf_BottomImage setImage:[UIImage imageNamed:(isSelectTitle ? (progress > 0.5 ? ssImageName : usImageName) : (progress > 0.5 ? uuImageName : suImageName)) inBundle:_lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
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
    _lgf_Title.textColor = lgf_Style.lgf_UnTitleSelectColor;
    _lgf_Title.font = lgf_Style.lgf_UnTitleSelectFont;
    _lgf_Title.textAlignment = NSTextAlignmentCenter;
    
    // 副标 Label 配置
    if (lgf_Style.lgf_IsDoubleTitle) {
        _lgf_SubTitle.textColor = lgf_Style.lgf_UnSubTitleSelectColor;
        _lgf_SubTitle.font = lgf_Style.lgf_UnSubTitleSelectFont;
        _lgf_SubTitle.textAlignment = NSTextAlignmentCenter;
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
        _lgf_IsHaveImage = NO;
        _lgf_TopImage.hidden = YES;
        _lgf_BottomImage.hidden = YES;
        _lgf_LeftImage.hidden = YES;
        _lgf_RightImage.hidden = YES;
        _lgf_TopImageHeight.constant = 0.0;
        _lgf_BottomImageHeight.constant = 0.0;
        _lgf_LeftImageWidth.constant = 0.0;
        _lgf_RightImageWidth.constant = 0.0;
        _lgf_TopImageSpace.constant = 0.0;
        _lgf_BottomImageSpace.constant = 0.0;
        _lgf_LeftImageSpace.constant = 0.0;
        _lgf_RightImageSpace.constant = 0.0;
        return;
    }
    
    _lgf_IsHaveImage = YES;
    
    if (!lgf_Style.lgf_IsNetImage) NSAssert(lgf_Style.lgf_ImageBundel, @"为了获取正确的图片 - 请设置 (NSBundle *)style.lgf_ImageBundel");
    
    // 只要有宽度，允许设置左图片
    if (lgf_Style.lgf_LeftImageWidth > 0.0) {
        _lgf_LeftImage.hidden = NO;
        _lgf_LeftImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        _lgf_LeftImageSpace.constant = lgf_Style.lgf_LeftImageSpace;
        _lgf_LeftImageWidth.constant = MIN(lgf_Style.lgf_LeftImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        _lgf_LeftImageHeight.constant = MIN(lgf_Style.lgf_LeftImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_LeftImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [_lgf_LeftImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        _lgf_TitleCenterX.constant = _lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageWidth / 2);
        if (lgf_Style.lgf_LeftImageSpace > 0.0) {
            _lgf_TitleCenterX.constant = _lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageSpace / 2);
        }
    } else {
        LGFPTLog(@"如果要显示左边图标，请给 left_image_width 赋值");
    }
    
    // 只要有宽度，允许设置右图片
    if (lgf_Style.lgf_RightImageWidth > 0.0) {
        _lgf_RightImage.hidden = NO;
        _lgf_RightImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        _lgf_RightImageSpace.constant = lgf_Style.lgf_RightImageSpace;
        _lgf_RightImageWidth.constant = MIN(lgf_Style.lgf_RightImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        _lgf_RightImageHeight.constant = MIN(lgf_Style.lgf_RightImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_RightImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [_lgf_RightImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        _lgf_TitleCenterX.constant = _lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageWidth / 2.0);
        if (lgf_Style.lgf_RightImageSpace > 0.0) {
            _lgf_TitleCenterX.constant = _lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageSpace / 2.0);
        }
    } else {
        LGFPTLog(@"如果要显示右边图标，请给 right_image_width 赋值");
    }
    
    // 只要有高度，允许设置上图片
    if (lgf_Style.lgf_TopImageHeight > 0.0) {
        _lgf_TopImage.hidden = NO;
        _lgf_TopImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        _lgf_TopImageSpace.constant = lgf_Style.lgf_TopImageSpace;
        _lgf_TopImageWidth.constant = MIN(lgf_Style.lgf_TopImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Width);
        _lgf_TopImageHeight.constant = MIN(lgf_Style.lgf_TopImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_TopImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [_lgf_TopImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        _lgf_TitleCenterY.constant = _lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageHeight / 2.0);
        if (lgf_Style.lgf_TopImageSpace > 0.0) {
            _lgf_TitleCenterY.constant = _lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageSpace / 2.0);
        }
    } else {
        LGFPTLog(@"如果要显示顶部图标，请给 top_image_height 赋值");
    }
    
    // 只要有高度，允许设置下图片
    if (lgf_Style.lgf_BottomImageHeight > 0.0) {
        _lgf_BottomImage.hidden = NO;
        _lgf_BottomImage.contentMode = lgf_Style.lgf_TitleImageContentMode;
        _lgf_BottomImageSpace.constant = lgf_Style.lgf_BottomImageSpace;
        _lgf_BottomImageWidth.constant = MIN(lgf_Style.lgf_BottomImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Width);
        _lgf_BottomImageHeight.constant = MIN(lgf_Style.lgf_BottomImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        if (lgf_Style.lgf_IsNetImage) {
            if (_lgf_FreePTTitleDelegate && [_lgf_FreePTTitleDelegate respondsToSelector:@selector(lgf_GetTitleNetImage:imageUrl:)]) {
                [_lgf_FreePTTitleDelegate lgf_GetTitleNetImage:_lgf_BottomImage imageUrl:[NSURL URLWithString:lgf_Style.lgf_UnSelectImageNames[self.tag]]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [_lgf_BottomImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
        _lgf_TitleCenterY.constant = _lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageHeight / 2.0);
        if (lgf_Style.lgf_BottomImageSpace > 0.0) {
            _lgf_TitleCenterY.constant = _lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageSpace / 2.0);
        }
    } else {
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
