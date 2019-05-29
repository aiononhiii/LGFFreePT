//
//  LGFImageAlertView.m
//  LGFOCTool
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFImageAlertView.h"

@implementation LGFImageAlertViewStyle
lgf_ViewForM(LGFImageAlertViewStyle);
- (instancetype)init {
    self = [super init];
    self.lgf_AlertBackColor = [UIColor whiteColor];
    self.lgf_AlertImage = [UIImage imageNamed:@""];
    self.lgf_SureTitle = @"我知道了";
    self.lgf_SureTitleColor = [UIColor lgf_ColorWithHexString:@"333333"];
    self.lgf_SureTitleBackColor = [UIColor whiteColor];
    self.lgf_SureTitleFont = [UIFont boldSystemFontOfSize:16];
    self.lgf_AlertCornerRadius = 13.0;
    self.lgf_AlertWidth = lgf_ScreenWidth * 0.6;
    self.lgf_AlertHeight = lgf_ScreenWidth * 0.5;
    self.lgf_CenterLineHeight = 1.0;
    return self;
}
@end

@implementation LGFImageAlertView

lgf_XibViewForM(LGFImageAlertView, @"LGFOCTool");

- (void)lgf_ShowImageAlertWithImage:(UIImage *)image message:(NSString *)message sure:(LGFImageSureBlock)sure {
    LGFImageAlertViewStyle *style = [LGFImageAlertViewStyle lgf];
    style.lgf_AlertImage = image;
    style.lgf_Message = message;
    [self lgf_ShowImageAlertWithStyle:style sure:sure];
}

- (void)lgf_ShowImageAlertWithStyle:(LGFImageAlertViewStyle *)style sure:(LGFImageSureBlock)sure {
    self.firstResponderView = (UIView *)[LGFAllMethod lgf_CurrentFirstResponder];
    [lgf_Application.windows.lastObject.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LGFImageAlertView class]]) {
            [obj removeFromSuperview];
        }
    }];
    [lgf_Application.windows.firstObject endEditing:YES];
    self.frame = lgf_Application.windows.firstObject.bounds;
    [lgf_Application.windows.firstObject addSubview:self];
    if (style) {
        self.centerLineHeight.constant = style.lgf_CenterLineHeight;
        self.alertBackView.layer.cornerRadius = style.lgf_AlertCornerRadius;
        self.alertBackView.backgroundColor = style.lgf_AlertBackColor;
        [self.alertImageView setImage:style.lgf_AlertImage];
        self.alertWidth.constant = style.lgf_AlertWidth;
        self.alertHeight.constant = style.lgf_AlertHeight;
        [self.sureButton setTitle:style.lgf_SureTitle forState:UIControlStateNormal];
        [self.sureButton setTitleColor:style.lgf_SureTitleColor forState:UIControlStateNormal];
        [self.sureButton setBackgroundColor:style.lgf_SureTitleBackColor];
        self.sureButton.titleLabel.font = style.lgf_SureTitleFont;
        self.message.text = style.lgf_Message;
    }
    
    self.sureBlock = sure;
    
    // 动画
    self.alertBackView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    }];
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alertBackView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (IBAction)sure:(UIButton *)sender {
    [self selfRemove];
    lgf_HaveBlock(self.sureBlock);
}

- (void)selfRemove {
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    }];
    [UIView animateWithDuration:0.1 animations:^{
        self.alertBackView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.firstResponderView becomeFirstResponder];
    }];
}

@end
