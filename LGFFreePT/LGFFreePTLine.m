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

+ (instancetype)lgf_AllocLine:(LGFFreePTStyle *)style {
    LGFFreePTLine *line = [LGFPTBundle loadNibNamed:NSStringFromClass([LGFFreePTLine class]) owner:self options:nil].firstObject;
    line.clipsToBounds = YES;
    line.lgf_Style = style;
    return line;
}

#pragma mark - 懒加载
- (void)setLgf_Style:(LGFFreePTStyle *)lgf_Style {
    _lgf_Style = lgf_Style;
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
    if (lgf_Style.lgf_LineBackImage && self.subviews.count == 0) {
        [self setImage:lgf_Style.lgf_LineBackImage];
    }
}

@end
