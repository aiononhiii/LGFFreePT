//
//  UIButton+LGFIndicator.m
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIButton+LGFIndicator.h"
#import <objc/runtime.h>

static NSString *const lgf_IndicatorViewKey = @"lgf_IndicatorViewKey";
static NSString *const lgf_ButtonTextObjectKey = @"lgf_ButtonTextObjectKey";
static NSString *const lgf_ButtonImageObjectKey = @"lgf_ButtonImageObjectKey";

@implementation UIButton (LGFIndicator)

#pragma mark - 按钮显示白色菊花

- (void)lgf_ShowWhiteIndicator {
    [self lgf_ShowIndicator:UIActivityIndicatorViewStyleWhite];
}

#pragma mark - 按钮显示灰色菊花

- (void)lgf_ShowGrayIndicator {
    [self lgf_ShowIndicator:UIActivityIndicatorViewStyleGray];
}

#pragma mark - 按钮隐藏菊花
- (void)lgf_HideIndicator {
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &lgf_IndicatorViewKey);
    [indicator removeFromSuperview];
    self.titleLabel.alpha = 1.0;
    self.imageView.alpha = 1.0;
    self.userInteractionEnabled = YES;
}

- (void)lgf_ShowIndicator:(UIActivityIndicatorViewStyle)style {
    self.userInteractionEnabled = NO;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    indicator.frame = self.bounds;
    [indicator startAnimating];
    [self addSubview:indicator];
    objc_setAssociatedObject(self, &lgf_IndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleLabel.alpha = 0.0;
    self.imageView.alpha = 0.0;
}

@end
