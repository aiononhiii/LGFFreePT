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
        self.lgf_UnTitleSelectColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.lgf_TitleSelectColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.8 alpha:1.0];
        self.lgf_TitleSelectFont = [UIFont systemFontOfSize:14];
        self.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:14];
        self.lgf_SubTitleSelectColor = self.lgf_TitleSelectColor;
        self.lgf_UnSubTitleSelectColor = self.lgf_UnTitleSelectColor;
        self.lgf_SubTitleSelectFont = self.lgf_TitleSelectFont;
        self.lgf_UnSubTitleSelectFont = self.lgf_UnTitleSelectFont;
        self.lgf_TitleBigScale = 1.0;
        self.lgf_MainTitleBigScale = 1.0;
        self.lgf_SubTitleBigScale = 1.0;
        self.lgf_MainTitleUpDownScale = 0.0;
        self.lgf_SubTitleUpDownScale = 0.0;
        self.lgf_TitleHaveAnimation = YES;
        self.lgf_TitleBackgroundColor = [UIColor clearColor];
        self.lgf_TitleBorderColor = [UIColor whiteColor];
        self.lgf_IsShowLine = YES;
        self.lgf_LineColor = [UIColor blueColor];
        self.lgf_LineHeight = 1.0;
        self.lgf_LineAlpha = 1.0;
        self.lgf_LineBackImage = nil;
        self.lgf_LineAnimation = lgf_PageLineAnimationDefult;
        self.lgf_TitleScrollFollowType = lgf_TitleScrollFollowDefult;
        self.lgf_PVAnimationType = lgf_PageViewAnimationNone;
        self.lgf_LineWidthType = lgf_EqualTitleSTR;
        self.lgf_IsTitleCenter = NO;
        self.lgf_IsDoubleTitle = NO;
        self.lgf_SubTitleTopSpace = 0.0;
        self.lgf_TitleClickAnimationDuration = 0.2;
        self.lgf_TitleScrollToTheMiddleAnimationDuration = 0.25;
    }
    return self;
}

#pragma mark - 部分特殊默认设定
- (void)setLgf_LineWidthType:(lgf_FreeTitleLineWidthType)lgf_LineWidthType {
    _lgf_LineWidthType = lgf_LineWidthType;
    if (lgf_LineWidthType == lgf_EqualTitleSTRAndImage) {
        self.lgf_MainTitleBigScale = 1.0;
        LGFPTLog(@"lgf_LineWidthType == lgf_EqualTitleSTRAndImage 暂不支持设置标放大，将导致 UI 错位");
    }
}

- (void)setLgf_MainTitleBigScale:(CGFloat)lgf_MainTitleBigScale {
    _lgf_MainTitleBigScale = lgf_MainTitleBigScale;
    if (self.lgf_LineWidthType == lgf_EqualTitleSTRAndImage) {
        _lgf_MainTitleBigScale = 1.0;
        LGFPTLog(@"lgf_LineWidthType == lgf_EqualTitleSTRAndImage 暂不支持设置标放大，将导致 UI 错位");
    }
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
}

- (void)setLgf_UnSelectImageNames:(NSMutableArray *)lgf_UnSelectImageNames {
    _lgf_UnSelectImageNames = lgf_UnSelectImageNames;
    if (!_lgf_SelectImageNames || _lgf_SelectImageNames.count == 0) {
        _lgf_SelectImageNames = lgf_UnSelectImageNames;
    }
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
    if (!_lgf_TopImageWidth || _lgf_TopImageWidth == 0.0) {
        _lgf_TopImageWidth = lgf_TopImageHeight;
    }
}

- (void)setLgf_BottomImageHeight:(CGFloat)lgf_BottomImageHeight {
    _lgf_BottomImageHeight = lgf_BottomImageHeight;
    if (!_lgf_BottomImageWidth || _lgf_BottomImageWidth == 0.0) {
        _lgf_BottomImageWidth = lgf_BottomImageHeight;
    }
}

- (void)setLgf_LeftImageHeight:(CGFloat)lgf_LeftImageHeight {
    _lgf_LeftImageHeight = lgf_LeftImageHeight;
    if (!_lgf_LeftImageWidth || _lgf_LeftImageWidth == 0.0) {
        _lgf_LeftImageWidth = lgf_LeftImageHeight;
    }
}

- (void)setLgf_RightImageHeight:(CGFloat)lgf_RightImageHeight {
    _lgf_RightImageHeight = lgf_RightImageHeight;
    if (!_lgf_RightImageWidth || _lgf_RightImageWidth == 0.0) {
        _lgf_RightImageWidth = lgf_RightImageHeight;
    }
}

- (void)setLgf_TopImageWidth:(CGFloat)lgf_TopImageWidth {
    _lgf_TopImageWidth = lgf_TopImageWidth;
    if (!_lgf_TopImageHeight || _lgf_TopImageHeight == 0.0) {
        _lgf_TopImageHeight = lgf_TopImageWidth;
    }
}

- (void)setLgf_BottomImageWidth:(CGFloat)lgf_BottomImageWidth {
    _lgf_BottomImageWidth = lgf_BottomImageWidth;
    if (!_lgf_BottomImageHeight || _lgf_BottomImageHeight == 0.0) {
        _lgf_BottomImageHeight = lgf_BottomImageWidth;
    }
}

- (void)setLgf_LeftImageWidth:(CGFloat)lgf_LeftImageWidth {
    _lgf_LeftImageWidth = lgf_LeftImageWidth;
    if (!_lgf_LeftImageHeight || _lgf_LeftImageHeight == 0.0) {
        _lgf_LeftImageHeight = lgf_LeftImageWidth;
    }
}

- (void)setLgf_RightImageWidth:(CGFloat)lgf_RightImageWidth {
    _lgf_RightImageWidth = lgf_RightImageWidth;
    if (!_lgf_RightImageHeight || _lgf_RightImageHeight == 0.0) {
        _lgf_RightImageHeight = lgf_RightImageWidth;
    }
}

@end
