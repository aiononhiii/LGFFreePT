//
//  LGFFreePTStyleCenter.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/4/29.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "LGFFreePTStyleCenter.h"
#import "specialTitle.h"
#import "specialImageTitle.h"

@implementation LGFFreePTStyleCenter

+ (LGFFreePTStyle *)one {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_IsTitleCenter = YES;// title 少的时候默认居中
    style.lgf_TitleFixedWidth = 80.0;
    style.lgf_LineWidth = 80.0;
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_LineHeight = 4.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    return style;
}

+ (LGFFreePTStyle *)two {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTR;// 底部线对准字
    style.lgf_TitleLeftRightSpace = 20.0;
    style.lgf_PageLeftRightSpace = 20.0;
    style.lgf_LineHeight = 4.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleBigScale = 1.5;// 控制放大缩小
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    return style;
}

+ (LGFFreePTStyle *)three {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitle;// 底部线对准 title 宽
    style.lgf_TitleLeftRightSpace = 20.0;
    style.lgf_PageLeftRightSpace = 20.0;
    style.lgf_TitleBigScale = 1.5;// 控制放大缩小
    style.lgf_LineHeight = 2.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;// 毛毛虫效果
    return style;
}

+ (LGFFreePTStyle *)four {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_TitleFixedWidth = 80.0;
    style.lgf_LineWidth = 10.0;
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_TitleCornerRadius = 3.0;
    style.lgf_LineHeight = 4.0;
    style.lgf_LineBottom = 0.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;// 毛毛虫效果
    return style;
}

+ (LGFFreePTStyle *)five {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTR;// 底部线对准字
    style.lgf_TitleCornerRadius = 3.0;
    style.lgf_TitleLeftRightSpace = 20.0;
    style.lgf_PageLeftRightSpace = 20.0;
    style.lgf_LineHeight = 4.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;// 毛毛虫效果
    return style;
}
+ (LGFFreePTStyle *)six {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTR;
    style.lgf_TitleLeftRightSpace = 20.0;
    style.lgf_PageLeftRightSpace = 20.0;
    style.lgf_TitleBigScale = 1.5;// 控制放大缩小
    style.lgf_LineHeight = 4.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;// 毛毛虫效果
    return style;
}
+ (LGFFreePTStyle *)seven {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTR;// 底部线对准字
    style.lgf_TitleLeftRightSpace = 10.0;
    style.lgf_PageLeftRightSpace = 10.0;
    style.lgf_TitleCornerRadius = 3.0;
    style.lgf_LineHeight = 4.0;
    style.lgf_LineBottom = 0.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleBigScale = 0.5;// 控制放大缩小
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:18];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:18];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;// 毛毛虫效果
    // 添加左边图片 距离文字 5
    style.lgf_SelectImageNames = @[@"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian"].mutableCopy;
    style.lgf_UnSelectImageNames = @[@"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un"].mutableCopy;
    style.lgf_TitleImageBundel = lgf_Bundle(@"LGFFreePTDemo");
    style.lgf_LeftImageWidth = 25.0;
    style.lgf_LeftImageSpace = 5.0;
    return style;
}
+ (LGFFreePTStyle *)eight {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTRAndImage;// 底部线对准字和图片
    style.lgf_TitleLeftRightSpace = 10.0;
    style.lgf_PageLeftRightSpace = 5.0;
    style.lgf_TitleCornerRadius = 3.0;
    style.lgf_LineHeight = 44.0;
    style.lgf_LineBottom = 0.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleBigScale = 1.3;// 控制放大缩小
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_LineColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    // 添加左边图片 距离文字 5
    style.lgf_SelectImageNames = @[@"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian"].mutableCopy;
    style.lgf_UnSelectImageNames = @[@"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un"].mutableCopy;
    style.lgf_TitleImageBundel = lgf_Bundle(@"LGFFreePTDemo");
    style.lgf_LeftImageWidth = 10.0;
    style.lgf_RightImageWidth = 10.0;
    style.lgf_TopImageWidth = 6.0;
    style.lgf_BottomImageWidth = 6.0;
    style.lgf_LeftImageSpace = 5.0;
    style.lgf_RightImageSpace = 5.0;
    style.lgf_TopImageSpace = 1.0;
    style.lgf_BottomImageSpace = 1.0;
    return style;
}
+ (LGFFreePTStyle *)nine {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_TitleFixedWidth = 90.0;
    style.lgf_LineWidth = 90.0;
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_LineHeight = 44.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"333333");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    return style;
}
+ (LGFFreePTStyle *)ten {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTR;
    style.lgf_TitleLeftRightSpace = 10.0;
    style.lgf_PageLeftRightSpace = 10.0;
    style.lgf_TitleCornerRadius = 1.0;
    style.lgf_LineHeight = 2.0;
    style.lgf_LineBottom = 0.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:20];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:20];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"B50000");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;
    // 副标题配置
    style.lgf_SubTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_UnSubTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_SubTitleSelectColor = LGFPTHexColor(@"666666");
    style.lgf_UnSubTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_IsDoubleTitle = YES;
    style.lgf_SubTitleTopSpace = -1;
    return style;
}

+ (LGFFreePTStyle *)eleven {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitleSTRAndImage;
    // 添加左边图片 距离文字 5
    style.lgf_SelectImageNames = @[@"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian", @"tupian"].mutableCopy;
    style.lgf_UnSelectImageNames = @[@"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un", @"tupian_un"].mutableCopy;
    style.lgf_TitleImageBundel = lgf_Bundle(@"LGFFreePTDemo");
    style.lgf_LeftImageWidth = 10;
    style.lgf_TitleLeftRightSpace = 10.0;
    style.lgf_PageLeftRightSpace = 10.0;
    style.lgf_TitleCornerRadius = 1.0;
    style.lgf_LineHeight = 2.0;
    style.lgf_LineBottom = 0.0;
    style.lgf_LineCornerRadius = 2.0;
    style.lgf_SubTitleBigScale = 0.7;
    style.lgf_TitleBigScale = 1.3;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:20];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:20];
    style.lgf_LineColor = LGFPTHexColor(@"fr134f");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"B50000");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    // 副标题配置
    style.lgf_SubTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_UnSubTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_SubTitleSelectColor = LGFPTHexColor(@"666666");
    style.lgf_UnSubTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_IsDoubleTitle = YES;
    style.lgf_SubTitleTopSpace = -1;
    return style;
}

+ (LGFFreePTStyle *)twelve {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_IsShowLine = NO;
    style.lgf_TitleLeftRightSpace = 15.0;
    style.lgf_PageLeftRightSpace = 15.0;
    style.lgf_TitleCornerRadius = 1.0;
    style.lgf_MainTitleBigScale = 1.8;
    style.lgf_SubTitleBigScale = 0.0;
    style.lgf_MainTitleUpDownScale = 4.0;
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:20];
    style.lgf_UnTitleSelectFont = [UIFont boldSystemFontOfSize:20];
    style.lgf_LineColor = LGFPTHexColor(@"333333");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"8656E3");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;
    // 副标题配置
    style.lgf_SubTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_UnSubTitleSelectFont = [UIFont boldSystemFontOfSize:12];
    style.lgf_SubTitleSelectColor = LGFPTHexColor(@"666666");
    style.lgf_UnSubTitleSelectColor = LGFPTHexColor(@"f0f0f0");
    style.lgf_IsDoubleTitle = YES;
    style.lgf_SubTitleTopSpace = -1;
    return style;
}


+ (LGFFreePTStyle *)thirteen {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_TitleFixedWidth = 120.0;
    style.lgf_LineWidth = 120.0;
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_LineHeight = 44.0;
    style.lgf_LineBackImage = lgf_Image(@"line_image");
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"8656E3");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"F0F0F0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    return style;
}


+ (LGFFreePTStyle *)fourteen {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_EqualTitle;
    style.lgf_TitleLeftRightSpace = 15.0;
    style.lgf_PageLeftRightSpace = 10.0;
    style.lgf_LineHeight = 44.0;
    style.lgf_LineBackImage = lgf_Image(@"line_maomaochong");
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"8656E3");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"F0F0F0");
    style.lgf_LineAnimation = lgf_PageLineAnimationSmallToBig;
    return style;
}

+ (LGFFreePTStyle *)fifteen {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_TitleFixedWidth = (lgf_ScreenWidth - 40) / 4;
    style.lgf_LineWidth = style.lgf_TitleFixedWidth;
    style.lgf_LineHeight = 44.0;
    style.lgf_LineColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_TitleBorderColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_TitleBorderWidth = 0.5;
    style.lgf_PVTitleViewBackgroundColor = LGFPTHexColor(@"8656E3");
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:14];
    style.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:14];
    style.lgf_LineColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_TitleSelectColor = LGFPTHexColor(@"8656E3");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"F0F0F0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    style.lgf_TitleHaveAnimation = NO;
    return style;
}

+ (LGFFreePTStyle *)sixteen {
    LGFFreePTStyle *style = [LGFFreePTStyle lgf];
    specialTitle * sviewOne = [specialTitle lgf];
    sviewOne.tag = 2;
    specialImageTitle * sviewTwo = [specialImageTitle lgf];
    sviewTwo.tag = 5;
    style.lgf_FreePTSpecialTitleArray = @[sviewOne, sviewTwo];
    style.lgf_LineWidthType = lgf_FixedWith;
    style.lgf_LineWidth = 10.0;
    style.lgf_TitleLeftRightSpace = 20.0;
    style.lgf_PageLeftRightSpace = 15.0;
    style.lgf_LineHeight = 10.0;
    style.lgf_LineBottom = -5;
    style.lgf_LineCornerRadius = 5.0;
    style.lgf_TitleBigScale = 1.1;
    style.lgf_LineColor = LGFPTHexColor(@"FF2A52");
    style.lgf_PVTitleViewBackgroundColor = LGFPTHexColor(@"FFFFFF");
    style.lgf_TitleSelectFont = [UIFont boldSystemFontOfSize:16];
    style.lgf_UnTitleSelectFont = [UIFont systemFontOfSize:16];
    style.lgf_TitleSelectColor = LGFPTHexColor(@"8656E3");
    style.lgf_UnTitleSelectColor = LGFPTHexColor(@"F0F0F0");
    style.lgf_LineAnimation = lgf_PageLineAnimationDefult;
    return style;
}

@end
