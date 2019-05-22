//
//  LGFFreePTStyle.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTStyle.h"
#import "UIView+LGFFreePT.h"
#import "LGFFreePTMethod.h"

@implementation LGFFreePTStyle

+ (instancetype)lgf {
    LGFFreePTStyle *style = [[LGFFreePTStyle alloc] init];
    return style;
}

#pragma mark - 赋默认值
- (instancetype)init {
    if (self = [super init]) {
        self.lgf_Titles = [NSArray new];
        // 标配置
        self.lgf_TitleClickAnimationDuration = 0.3;
        self.lgf_TitleScrollToTheMiddleAnimationDuration = 0.25;
        self.lgf_TitleBackgroundColor = [UIColor clearColor];
        self.lgf_TitleLeftRightSpace = 0.0;
        self.lgf_TitleCornerRadius = 0.0;
        self.lgf_TitleFixedWidth = 0.0;
        self.lgf_TitleTransformSX = 1.0;
        self.lgf_IsTitleCenter = NO;
        self.lgf_TitleHaveAnimation = YES;
        self.lgf_TitleBorderColor = [UIColor whiteColor];
        self.lgf_TitleBorderWidth = 0.0;
        
        // 标 title 配置
        self.lgf_TitleSelectColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.8 alpha:1.0];
        self.lgf_UnTitleSelectColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.lgf_TitleSelectFont = [UIFont systemFontOfSize:14.0];
        self.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:14.0];
        self.lgf_MainTitleTransformSX = 1.0;
        self.lgf_MainTitleTransformTY = 0.0;
        self.lgf_MainTitleTransformTX = 0.0;
        
        // 副标 title 配置
        self.lgf_IsDoubleTitle = NO;
        self.lgf_IsLineAlignSubTitle = NO;
        self.lgf_SubTitleSelectColor = self.lgf_TitleSelectColor;
        self.lgf_UnSubTitleSelectColor = self.lgf_UnTitleSelectColor;
        self.lgf_SubTitleSelectFont = self.lgf_TitleSelectFont;
        self.lgf_UnSubTitleSelectFont = self.lgf_UnTitleSelectFont;
        self.lgf_SubTitleTopSpace = 0.0;
        self.lgf_SubTitleTransformSX = 1.0;
        self.lgf_SubTitleTransformTY = 0.0;
        self.lgf_SubTitleTransformTX = 0.0;
        
        // line 配置
        self.lgf_IsShowLine = YES;
        self.lgf_LineCornerRadius = 0.0;
        self.lgf_LineColor = [UIColor blueColor];
        self.lgf_LineWidth = 0.0;
        self.lgf_LineHeight = 1.0;
        self.lgf_LineBottom = 0.0;
        self.lgf_LineAlpha = 1.0;
        self.lgf_LineImageName = @"";
        self.lgf_IsLineNetImage = NO;
        self.lgf_LineImageContentMode = UIViewContentModeScaleToFill;
        
        // 标上下左右图片配置
        self.lgf_SelectImageNames = [NSMutableArray new];
        self.lgf_UnSelectImageNames = [NSMutableArray new];
        self.lgf_TopImageSpace = 0.0;
        self.lgf_TopImageWidth = 0.0;
        self.lgf_TopImageHeight = 0.0;
        self.lgf_BottomImageSpace = 0.0;
        self.lgf_BottomImageWidth = 0.0;
        self.lgf_BottomImageHeight = 0.0;
        self.lgf_LeftImageSpace = 0.0;
        self.lgf_LeftImageWidth = 0.0;
        self.lgf_LeftImageHeight = 0.0;
        self.lgf_RightImageSpace = 0.0;
        self.lgf_RightImageWidth = 0.0;
        self.lgf_RightImageHeight = 0.0;
        self.lgf_IsNetImage = NO;
        self.lgf_TitleImageContentMode = UIViewContentModeScaleToFill;
        
        // 枚举配置
        self.lgf_LineAnimation = lgf_PageLineAnimationDefult;
        self.lgf_TitleScrollFollowType = lgf_TitleScrollFollowDefult;
        self.lgf_PVAnimationType = lgf_PageViewAnimationDefult;
        self.lgf_LineWidthType = lgf_EqualTitleSTR;
        
        // 其他配置
        self.lgf_StartDebug = NO;
        self.lgf_PVTitleViewBackgroundColor = [UIColor clearColor];
        self.lgf_PageLeftRightSpace = 0.0;
    }
    return self;
}

#pragma mark - 部分特殊默认设定

- (void)setLgf_IsLineAlignSubTitle:(BOOL)lgf_IsLineAlignSubTitle {
    if (self.lgf_IsDoubleTitle) {
        _lgf_IsLineAlignSubTitle = lgf_IsLineAlignSubTitle;
    } else {
        _lgf_IsLineAlignSubTitle = NO;
    }
}

- (void)setLgf_TitleTransformSX:(CGFloat)lgf_TitleTransformSX {
    _lgf_TitleTransformSX = lgf_TitleTransformSX == 0.0 ? 0.00001 : lgf_TitleTransformSX;
}

- (void)setLgf_SubTitleTransformSX:(CGFloat)lgf_SubTitleTransformSX {
    _lgf_SubTitleTransformSX = lgf_SubTitleTransformSX == 0.0 ? 0.00001 : lgf_SubTitleTransformSX;
}

- (void)setLgf_MainTitleTransformSX:(CGFloat)lgf_MainTitleTransformSX {
    _lgf_MainTitleTransformSX = lgf_MainTitleTransformSX == 0.0 ? 0.00001 : lgf_MainTitleTransformSX;
}

- (void)setLgf_SubTitleSelectColor:(UIColor *)lgf_SubTitleSelectColor {
    if ([LGFFreePTMethod lgf_GetColorRGBA:lgf_SubTitleSelectColor]) {
        _lgf_SubTitleSelectColor = lgf_SubTitleSelectColor;
    } else {
        NSAssert(NO, @"请用 HEX/RGB 设置 lgf_SubTitleSelectColor 颜色");
    }
}

- (void)setLgf_UnSubTitleSelectColor:(UIColor *)lgf_UnSubTitleSelectColor {
    if ([LGFFreePTMethod lgf_GetColorRGBA:lgf_UnSubTitleSelectColor]) {
        _lgf_UnSubTitleSelectColor = lgf_UnSubTitleSelectColor;
    } else {
        NSAssert(NO, @"请用 HEX/RGB 设置 lgf_UnSubTitleSelectColor 颜色");
    }
}

- (void)setLgf_TitleSelectColor:(UIColor *)lgf_TitleSelectColor {
    if ([LGFFreePTMethod lgf_GetColorRGBA:lgf_TitleSelectColor]) {
        _lgf_TitleSelectColor = lgf_TitleSelectColor;
    } else {
        NSAssert(NO, @"请用 HEX/RGB 设置 lgf_TitleSelectColor 颜色");
    }
}

- (void)setLgf_UnTitleSelectColor:(UIColor *)lgf_UnTitleSelectColor {
    if ([LGFFreePTMethod lgf_GetColorRGBA:lgf_UnTitleSelectColor]) {
        _lgf_UnTitleSelectColor = lgf_UnTitleSelectColor;
    } else {
        NSAssert(NO, @"请用 HEX/RGB 设置 lgf_UnTitleSelectColor 颜色");
    }
}

- (void)setLgf_LineColor:(UIColor *)lgf_LineColor {
    if ([LGFFreePTMethod lgf_GetColorRGBA:lgf_LineColor]) {
        _lgf_LineColor = lgf_LineColor;
    } else {
        NSAssert(NO, @"请用 HEX/RGB 设置 lgf_LineColor 颜色");
    }
}

- (void)setLgf_SelectImageNames:(NSMutableArray *)lgf_SelectImageNames {
    _lgf_SelectImageNames = lgf_SelectImageNames;
    if (!_lgf_UnSelectImageNames || _lgf_UnSelectImageNames.count == 0) {
        _lgf_UnSelectImageNames = lgf_SelectImageNames;
    }
    if (lgf_SelectImageNames.count == 0 || lgf_SelectImageNames.count != self.lgf_Titles.count) {
        [self lgf_HaveNoImage];
    }
}

- (void)setLgf_UnSelectImageNames:(NSMutableArray *)lgf_UnSelectImageNames {
    _lgf_UnSelectImageNames = lgf_UnSelectImageNames;
    if (!_lgf_SelectImageNames || _lgf_SelectImageNames.count == 0) {
        _lgf_SelectImageNames = lgf_UnSelectImageNames;
    }
    if (lgf_UnSelectImageNames.count == 0 || lgf_UnSelectImageNames.count != self.lgf_Titles.count) {
        [self lgf_HaveNoImage];
    }
}

- (void)lgf_HaveNoImage {
    self.lgf_TopImageSpace = 0.0;
    self.lgf_TopImageWidth = 0.0;
    self.lgf_TopImageHeight = 0.0;
    self.lgf_BottomImageSpace = 0.0;
    self.lgf_BottomImageWidth = 0.0;
    self.lgf_BottomImageHeight = 0.0;
    self.lgf_LeftImageSpace = 0.0;
    self.lgf_LeftImageWidth = 0.0;
    self.lgf_LeftImageHeight = 0.0;
    self.lgf_RightImageSpace = 0.0;
    self.lgf_RightImageWidth = 0.0;
    self.lgf_RightImageHeight = 0.0;
}

- (void)setLgf_SameSelectImageName:(NSString *)lgf_SameSelectImageName {
    _lgf_SameSelectImageName = lgf_SameSelectImageName;
    if (!_lgf_SameUnSelectImageName || _lgf_SameUnSelectImageName.length == 0) {
        _lgf_SameUnSelectImageName = lgf_SameSelectImageName;
    }
}

- (void)setLgf_SameUnSelectImageName:(NSString *)lgf_SameUnSelectImageName {
    _lgf_SameUnSelectImageName = lgf_SameUnSelectImageName;
    if (!_lgf_SameSelectImageName || _lgf_SameSelectImageName.length == 0) {
        _lgf_SameSelectImageName = lgf_SameUnSelectImageName;
    }
}

- (void)setLgf_TopImageHeight:(CGFloat)lgf_TopImageHeight {
    _lgf_TopImageHeight = lgf_TopImageHeight;
    if (_lgf_TopImageWidth == 0.0) {
        _lgf_TopImageWidth = lgf_TopImageHeight;
    }
}

- (void)setLgf_BottomImageHeight:(CGFloat)lgf_BottomImageHeight {
    _lgf_BottomImageHeight = lgf_BottomImageHeight;
    if (_lgf_BottomImageWidth == 0.0) {
        _lgf_BottomImageWidth = lgf_BottomImageHeight;
    }
}

- (void)setLgf_LeftImageHeight:(CGFloat)lgf_LeftImageHeight {
    if (lgf_LeftImageHeight == 0.0) {
        _lgf_LeftImageHeight = self.lgf_LeftImageWidth;
    } else {
        _lgf_LeftImageHeight = lgf_LeftImageHeight;
    }
}

- (void)setLgf_RightImageHeight:(CGFloat)lgf_RightImageHeight {
    _lgf_RightImageHeight = lgf_RightImageHeight;
    if (_lgf_RightImageWidth == 0.0) {
        _lgf_RightImageWidth = lgf_RightImageHeight;
    }
}

- (void)setLgf_TopImageWidth:(CGFloat)lgf_TopImageWidth {
    _lgf_TopImageWidth = lgf_TopImageWidth;
    if (_lgf_TopImageHeight == 0.0) {
        _lgf_TopImageHeight = lgf_TopImageWidth;
    }
}

- (void)setLgf_BottomImageWidth:(CGFloat)lgf_BottomImageWidth {
    _lgf_BottomImageWidth = lgf_BottomImageWidth;
    if (_lgf_BottomImageHeight == 0.0) {
        _lgf_BottomImageHeight = lgf_BottomImageWidth;
    }
}

- (void)setLgf_LeftImageWidth:(CGFloat)lgf_LeftImageWidth {
    if (lgf_LeftImageWidth == 0.0) {
        _lgf_LeftImageWidth = self.lgf_LeftImageHeight;
    } else {
        _lgf_LeftImageWidth = lgf_LeftImageWidth;
    }
}

- (void)setLgf_RightImageWidth:(CGFloat)lgf_RightImageWidth {
    _lgf_RightImageWidth = lgf_RightImageWidth;
    if (_lgf_RightImageHeight == 0.0) {
        _lgf_RightImageHeight = lgf_RightImageWidth;
    }
}

@end
