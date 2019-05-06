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

@implementation LGFFreePTTitle

+ (instancetype)lgf_AllocTitle:(NSString *)titleText index:(NSInteger)index style:(LGFFreePTStyle *)style {
    
    // 初始化标
    LGFFreePTTitle *title = [LGFPTBundle loadNibNamed:NSStringFromClass([LGFFreePTTitle class]) owner:self options:nil].firstObject;
    title.tag = index;
    title.lgf_Style = style;
    
    // 需要显示子标题
    if (title.lgf_Style.lgf_IsDoubleTitle) {
        title.lgf_Title.text = [titleText componentsSeparatedByString:@"/"].firstObject;
        title.lgf_SubTitle.text = [titleText componentsSeparatedByString:@"/"].lastObject;
    } else {
        title.lgf_Title.text = titleText;
    }
    
    // 获取字体宽度
    CGSize titleSize = [LGFFreePTMethod lgf_SizeWithString:title.lgf_Title.text font:title.lgf_Style.lgf_TitleSelectFont maxSize:CGSizeMake(CGFLOAT_MAX, title.lgf_Style.lgf_PVTitleView.lgfpt_Height)];
    CGSize subTitleSize = CGSizeZero;
    if (title.lgf_Style.lgf_IsDoubleTitle) {
        subTitleSize = [LGFFreePTMethod lgf_SizeWithString:title.lgf_SubTitle.text font:title.lgf_Style.lgf_SubTitleSelectFont maxSize:CGSizeMake(CGFLOAT_MAX, title.lgf_Style.lgf_PVTitleView.lgfpt_Height)];
        title.lgf_SubTitleHeight.constant = subTitleSize.height;
        title.lgf_TitleCenterY.constant = title.lgf_TitleCenterY.constant - subTitleSize.height / 2.0;
        title.lgf_SubTitleTop.constant = title.lgf_Style.lgf_SubTitleTopSpace;
        CGFloat maxWidth = MAX(titleSize.width, subTitleSize.width) * 1.01;
        title.lgf_SubTitleWidth.constant = maxWidth;
    }
    CGFloat maxWidth = MAX(titleSize.width, subTitleSize.width) * 1.01;
    title.lgf_TitleWidth.constant = maxWidth;
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
    CGFloat titleWidth = title.lgf_Style.lgf_TitleFixedWidth > 0.0 ? title.lgf_Style.lgf_TitleFixedWidth : (maxWidth + (style.lgf_TitleLeftRightSpace * 2.0) + title.lgf_Style.lgf_LeftImageWidth + title.lgf_Style.lgf_RightImageWidth + title.lgf_Style.lgf_LeftImageSpace + title.lgf_Style.lgf_RightImageSpace);
    
    title.frame = CGRectMake(titleX,
                             0.0,
                             titleWidth,
                             title.lgf_Style.lgf_PVTitleView.lgfpt_Height);
    
    [title.lgf_Style.lgf_PVTitleView addSubview:title];
    
    // 根据特殊 title 数组 和 特殊 title 的 tag 判断某个 index 是否要替换特殊 title
    if (style.lgf_FreePTSpecialTitleArray.count > 0) {
        for (UIView *specialTitle in style.lgf_FreePTSpecialTitleArray) {
            if (index == specialTitle.tag) {
                [title.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                specialTitle.frame = title.bounds;
                [title addSubview:specialTitle];
            }
        }
    }
    return title;
}

#pragma mark - 懒加载

- (void)setLgf_Style:(LGFFreePTStyle *)lgf_Style {
    _lgf_Style = lgf_Style;
    
    // 标 Label 配置
    self.lgf_Title.textColor = lgf_Style.lgf_UnTitleSelectColor;
    self.lgf_Title.font = lgf_Style.lgf_UnTitleSelectFont;
    self.lgf_Title.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = lgf_Style.lgf_TitleBackgroundColor;
    
    // 副标 Label 配置
    if (lgf_Style.lgf_IsDoubleTitle) {
        self.lgf_SubTitle.textColor = lgf_Style.lgf_UnSubTitleSelectColor;
        self.lgf_SubTitle.font = lgf_Style.lgf_UnSubTitleSelectFont;
        self.lgf_SubTitle.textAlignment = NSTextAlignmentCenter;
    }
    
    // 设置标边框
    if (lgf_Style.lgf_TitleBorderWidth > 0.0) {
        self.layer.borderWidth = lgf_Style.lgf_TitleBorderWidth;
        self.layer.borderColor = lgf_Style.lgf_TitleBorderColor.CGColor;
        self.clipsToBounds = YES;
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
        self.lgf_TopImageHeight.constant = 0.0;
        self.lgf_BottomImageHeight.constant = 0.0;
        self.lgf_LeftImageWidth.constant = 0.0;
        self.lgf_RightImageWidth.constant = 0.0;
        self.lgf_TopImageSpace.constant = 0.0;
        self.lgf_BottomImageSpace.constant = 0.0;
        self.lgf_LeftImageSpace.constant = 0.0;
        self.lgf_RightImageSpace.constant = 0.0;
        self.lgf_TopImage = nil;
        self.lgf_BottomImage = nil;
        self.lgf_LeftImage = nil;
        self.lgf_RightImage = nil;
        return;
    }
    
    self.lgf_IsHaveImage = YES;
    
    NSAssert(lgf_Style.lgf_TitleImageBundel, @"为了获取正确的图片 - 请设置 (NSBundle *)style.title_image_bundel");
    
    // 只要有宽度，允许设置左图片
    if (lgf_Style.lgf_LeftImageWidth > 0.0) {
        self.lgf_LeftImageSpace.constant = lgf_Style.lgf_LeftImageSpace;
        self.lgf_LeftImageWidth.constant = MIN(lgf_Style.lgf_LeftImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        self.lgf_LeftImageHeight.constant = MIN(lgf_Style.lgf_LeftImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        [self.lgf_LeftImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
        self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageWidth / 2);
        if (lgf_Style.lgf_LeftImageSpace > 0.0) {
            self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant + (lgf_Style.lgf_LeftImageSpace / 2);
        }
    } else {
        LGFPTLog(@"如果要显示左边图标，请给 left_image_width 赋值");
    }
    
    // 只要有宽度，允许设置右图片
    if (lgf_Style.lgf_RightImageWidth > 0.0) {
        self.lgf_RightImageSpace.constant = lgf_Style.lgf_RightImageSpace;
        self.lgf_RightImageWidth.constant = MIN(lgf_Style.lgf_RightImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        self.lgf_RightImageHeight.constant = MIN(lgf_Style.lgf_RightImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        [self.lgf_RightImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
        self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageWidth / 2.0);
        if (lgf_Style.lgf_RightImageSpace > 0.0) {
            self.lgf_TitleCenterX.constant = self.lgf_TitleCenterX.constant - (lgf_Style.lgf_RightImageSpace / 2.0);
        }
    } else {
        LGFPTLog(@"如果要显示右边图标，请给 right_image_width 赋值");
    }
    
    // 只要有高度，允许设置上图片
    if (lgf_Style.lgf_TopImageHeight > 0.0) {
        self.lgf_TopImageSpace.constant = lgf_Style.lgf_TopImageSpace;
        self.lgf_TopImageWidth.constant = MIN(lgf_Style.lgf_TopImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Width);
        self.lgf_TopImageHeight.constant = MIN(lgf_Style.lgf_TopImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        [self.lgf_TopImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
        self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageHeight / 2.0);
        if (lgf_Style.lgf_TopImageSpace > 0.0) {
            self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant + (lgf_Style.lgf_TopImageSpace / 2.0);
        }
    } else {
        LGFPTLog(@"如果要显示顶部图标，请给 top_image_height 赋值");
    }
    
    // 只要有高度，允许设置下图片
    if (lgf_Style.lgf_BottomImageHeight > 0.0) {
        self.lgf_BottomImageSpace.constant = lgf_Style.lgf_BottomImageSpace;
        self.lgf_BottomImageWidth.constant = MIN(lgf_Style.lgf_BottomImageWidth ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Width);
        self.lgf_BottomImageHeight.constant = MIN(lgf_Style.lgf_BottomImageHeight ?: 0.0, lgf_Style.lgf_PVTitleView.lgfpt_Height);
        [self.lgf_BottomImage setImage:[UIImage imageNamed:lgf_Style.lgf_UnSelectImageNames[self.tag] inBundle:lgf_Style.lgf_TitleImageBundel compatibleWithTraitCollection:nil]];
        self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageHeight / 2.0);
        if (lgf_Style.lgf_BottomImageSpace > 0.0) {
            self.lgf_TitleCenterY.constant = self.lgf_TitleCenterY.constant - (lgf_Style.lgf_BottomImageSpace / 2.0);
        }
    } else {
        LGFPTLog(@"如果要显示底部图标，请给 bottom_image_height 赋值");
    }
}

- (void)setLgf_CurrentTransformSX:(CGFloat)lgf_CurrentTransformSX {
    _lgf_CurrentTransformSX = lgf_CurrentTransformSX;
    self.transform = CGAffineTransformMakeScale(lgf_CurrentTransformSX, lgf_CurrentTransformSX);
}

- (void)setLgf_MainTitleCurrentTransformSX:(CGFloat)lgf_MainTitleCurrentTransformSX {
    _lgf_MainTitleCurrentTransformSX = lgf_MainTitleCurrentTransformSX;
    self.lgf_Title.transform = CGAffineTransformMakeScale(lgf_MainTitleCurrentTransformSX, lgf_MainTitleCurrentTransformSX);
}

- (void)setLgf_SubTitleCurrentTransformSX:(CGFloat)lgf_SubTitleCurrentTransformSX {
    _lgf_SubTitleCurrentTransformSX = lgf_SubTitleCurrentTransformSX;
    self.lgf_SubTitle.transform = CGAffineTransformMakeScale(lgf_SubTitleCurrentTransformSX, lgf_SubTitleCurrentTransformSX);
}

- (void)setLgf_MainTitleCurrentTransformTY:(CGFloat)lgf_MainTitleCurrentTransformTY {
    _lgf_MainTitleCurrentTransformTY = lgf_MainTitleCurrentTransformTY;
    self.lgf_Title.transform = CGAffineTransformTranslate(self.lgf_Title.transform, 0, lgf_MainTitleCurrentTransformTY);
}

- (void)setLgf_SubTitleCurrentTransformTY:(CGFloat)lgf_SubTitleCurrentTransformTY {
    _lgf_SubTitleCurrentTransformTY = lgf_SubTitleCurrentTransformTY;
    self.lgf_SubTitle.transform = CGAffineTransformTranslate(self.lgf_SubTitle.transform, 0, lgf_SubTitleCurrentTransformTY);
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

@end
