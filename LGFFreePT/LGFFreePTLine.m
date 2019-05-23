//
//  LGFFreePTLine.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTLine.h"
#import "UIView+LGFFreePT.h"
#import "LGFFreePTMethod.h"

@implementation LGFFreePTLine

+ (instancetype)lgf {
    LGFFreePTLine *line = [LGFPTBundle loadNibNamed:NSStringFromClass([LGFFreePTLine class]) owner:self options:nil].firstObject;
    return line;
}

- (void)lgf_AllocLine:(LGFFreePTStyle *)style delegate:(id<LGFFreePTLineDelegate>)delegate {
    self.clipsToBounds = YES;
    self.lgf_FreePTLineDelegate = delegate;
    self.lgf_Style = style;
}

#pragma mark - 懒加载
- (void)setLgf_Style:(LGFFreePTStyle *)lgf_Style {
    _lgf_Style = lgf_Style;
    if (!lgf_Style.lgf_IsLineNetImage && lgf_Style.lgf_LineImageName.length > 0) NSAssert(lgf_Style.lgf_ImageBundel, @"为了获取正确的图片 - 请设置 (NSBundle *)style.lgf_ImageBundel");
    // 设置标边框
    if (lgf_Style.lgf_LineBorderWidth > 0.0) {
        self.layer.borderWidth = lgf_Style.lgf_LineBorderWidth;
        self.layer.borderColor = lgf_Style.lgf_LineBorderColor.CGColor;
        self.clipsToBounds = YES;
    }
    self.contentMode = lgf_Style.lgf_LineImageContentMode;
    self.backgroundColor = lgf_Style.lgf_LineColor;
    CGFloat Y = lgf_Style.lgf_PVTitleView.lgfpt_Height - ((lgf_Style.lgf_LineHeight + lgf_Style.lgf_LineBottom) > lgf_Style.lgf_PVTitleView.lgfpt_Height ? lgf_Style.lgf_PVTitleView.lgfpt_Height : (lgf_Style.lgf_LineHeight + lgf_Style.lgf_LineBottom));
    CGFloat H = (lgf_Style.lgf_LineHeight + lgf_Style.lgf_LineBottom) > lgf_Style.lgf_PVTitleView.lgfpt_Height ? (lgf_Style.lgf_PVTitleView.lgfpt_Height - lgf_Style.lgf_LineBottom) : lgf_Style.lgf_LineHeight;
    if (lgf_Style.lgf_LineWidthType == lgf_FixedWith) {
        self.lgfpt_Width = lgf_Style.lgf_LineWidth;
    } else if (lgf_Style.lgf_LineWidthType == lgf_EqualTitle) {
        self.lgfpt_Width = lgf_Style.lgf_TitleFixedWidth;
    }
    self.lgfpt_Y = Y;
    self.lgfpt_Height = H;
    self.alpha = lgf_Style.lgf_LineAlpha;
    self.layer.cornerRadius = lgf_Style.lgf_LineCornerRadius;
    if (lgf_Style.lgf_LineImageName.length > 0 && self.subviews.count == 0) {
        if (lgf_Style.lgf_IsLineNetImage) {
            if (self.lgf_FreePTLineDelegate && [self.lgf_FreePTLineDelegate respondsToSelector:@selector(lgf_GetLineNetImage:imageUrl:)]) {
                [self.lgf_FreePTLineDelegate lgf_GetLineNetImage:self imageUrl:[NSURL URLWithString:lgf_Style.lgf_LineImageName]];
            }
        } else {
            [self setImage:[UIImage imageNamed:lgf_Style.lgf_LineImageName inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
    }
}

@end
