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
    // 注意：这个代理放在最下面，对一些 LGFFreePTStyle 配置的属性拥有最终修改权
    if (self.lgf_FreePTLineDelegate && [self.lgf_FreePTLineDelegate respondsToSelector:@selector(lgf_GetLine:style:)]) {
        [self.lgf_FreePTLineDelegate lgf_GetLine:self style:style];
    }
}

#pragma mark - 懒加载
- (void)setLgf_Style:(LGFFreePTStyle *)lgf_Style {
    _lgf_Style = lgf_Style;
    if (!lgf_Style.lgf_IsLineNetImage && lgf_Style.lgf_LineImageName.length > 0) NSAssert(lgf_Style.lgf_ImageBundel, @"为了获取正确的图片 - 请设置 (NSBundle *)style.lgf_ImageBundel");
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
    self.layer.cornerRadius = lgf_Style.lgf_LineCornerRadius;
    if (lgf_Style.lgf_LineImageName.length > 0 && self.subviews.count == 0) {
        if (lgf_Style.lgf_IsLineNetImage) {
            if (self.lgf_FreePTLineDelegate && [self.lgf_FreePTLineDelegate respondsToSelector:@selector(lgf_GetLineNetImage:imageUrl:)]) {
                [self.lgf_FreePTLineDelegate lgf_GetLineNetImage:self imageUrl:[NSURL URLWithString:lgf_Style.lgf_LineImageName]];
            } else {
                LGFPTLog(@"请添加（lgf_GetTitleNetImage:imageUrl:）代理方法");
            }
        } else {
            [self setImage:[UIImage imageNamed:lgf_Style.lgf_LineImageName inBundle:lgf_Style.lgf_ImageBundel compatibleWithTraitCollection:nil]];
        }
    }
}

@end
