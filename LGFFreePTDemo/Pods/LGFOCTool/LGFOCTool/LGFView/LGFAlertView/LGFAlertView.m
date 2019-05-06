//
//  QTAlertView.m
//  OptimalLive
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 QT. All rights reserved.
//

#import "LGFAlertView.h"

@implementation LGFAlertViewStyle
lgf_ViewForM(LGFAlertViewStyle);
- (instancetype)init {
    self = [super init];
    self.lgf_AlertBackColor = [UIColor whiteColor];
    self.lgf_CancelTitle = @"取消";
    self.lgf_CancelTitleColor = [UIColor lgf_ColorWithHexString:@"333333"];
    self.lgf_CancelTitleFont = [UIFont boldSystemFontOfSize:16];
    self.lgf_CancelBackColor = [UIColor whiteColor];
    self.lgf_ConfirmTitle = @"确定";
    self.lgf_ConfirmTitleColor = [UIColor lgf_ColorWithHexString:@"333333"];
    self.lgf_ConfirmTitleFont = [UIFont boldSystemFontOfSize:16];
    self.lgf_ConfirmBackColor = [UIColor whiteColor];
    self.lgf_SureTitle = @"我知道了";
    self.lgf_SureTitleColor = [UIColor lgf_ColorWithHexString:@"333333"];
    self.lgf_SureTitleBackColor = [UIColor whiteColor];
    self.lgf_SureTitleFont = [UIFont boldSystemFontOfSize:16];
    self.lgf_HighColorTitle = @"";
    self.lgf_AlertCornerRadius = 13.0;
    self.lgf_MessageFont = [UIFont boldSystemFontOfSize:16];
    self.lgf_CenterLineHeight = 1.0;
    return self;
}
@end

@implementation LGFAlertView

lgf_XibViewForM(LGFAlertView, @"LGFOCTool");

- (void)lgf_ShowAlertWithMessage:(NSString *)message sure:(LGFSureBlock)sure {
    [self lgf_ShowAlertWithStyle:[LGFAlertViewStyle lgf] message:message sure:sure];
}

- (void)lgf_ShowAlertWithMessage:(NSString *)message cancel:(LGFCancelBlock)cancel confirm:(LGFConfirmBlock)confirm {
    [self lgf_ShowAlertWithStyle:[LGFAlertViewStyle lgf] message:message cancel:cancel confirm:confirm];
}

- (void)lgf_ShowAlertWithStyle:(LGFAlertViewStyle *)style message:(NSString *)message sure:(LGFSureBlock)sure {
    self.sureButton.hidden = NO;
    self.cancelButton.hidden = YES;
    self.confirmButton.hidden = YES;
    self.centerLine.hidden = YES;
    [self lgf_ShowAlertWithStyle:style message:message sure:sure cancel:nil confirm:nil];
}

- (void)lgf_ShowAlertWithStyle:(LGFAlertViewStyle *)style message:(NSString *)message cancel:(LGFCancelBlock)cancel confirm:(LGFConfirmBlock)confirm {
    self.sureButton.hidden = YES;
    self.cancelButton.hidden = NO;
    self.confirmButton.hidden = NO;
    self.centerLine.hidden = NO;
    [self lgf_ShowAlertWithStyle:style message:message sure:nil cancel:cancel confirm:confirm];
}

- (void)lgf_ShowAlertWithStyle:(LGFAlertViewStyle *)style message:(NSString *)message sure:(LGFSureBlock)sure cancel:(LGFCancelBlock)cancel confirm:(LGFConfirmBlock)confirm {
    self.firstResponderView = (UIView *)[LGFAllMethod lgf_CurrentFirstResponder];
    [lgf_Application.windows.lastObject.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LGFAlertView class]]) {
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
        [self.cancelButton setTitle:style.lgf_CancelTitle forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:style.lgf_CancelTitleColor forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:style.lgf_CancelBackColor];
        self.cancelButton.titleLabel.font = style.lgf_CancelTitleFont;
        [self.confirmButton setTitle:style.lgf_ConfirmTitle forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:style.lgf_ConfirmTitleColor forState:UIControlStateNormal];
        [self.confirmButton setBackgroundColor:style.lgf_ConfirmBackColor];
        self.confirmButton.titleLabel.font = style.lgf_CancelTitleFont;
        [self.sureButton setTitle:style.lgf_SureTitle forState:UIControlStateNormal];
        [self.sureButton setTitleColor:style.lgf_SureTitleColor forState:UIControlStateNormal];
        [self.sureButton setBackgroundColor:style.lgf_SureTitleBackColor];
        self.sureButton.titleLabel.font = style.lgf_SureTitleFont;
        if (message.length > 0) {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:message];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            if (style.lgf_HighColorTitle && style.lgf_HighColor) {
                NSRange range = [[attrStr string] rangeOfString:style.lgf_HighColorTitle];
                [attrStr addAttribute:NSForegroundColorAttributeName value:style.lgf_HighColor range:range];
            }
            paragraphStyle.lineSpacing = 5;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrStr.string.length)];
            self.title.font = style.lgf_MessageFont;
            self.title.attributedText = attrStr;
        }
    }
    
    self.sureBlock = sure;
    self.cancelBlock = cancel;
    self.confirmBlock = confirm;
    
    // 动画
    self.alertBackView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    }];
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alertBackView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (IBAction)cancel:(UIButton *)sender {
    [self selfRemove];
    lgf_HaveBlock(self.cancelBlock);
}

- (IBAction)confirm:(UIButton *)sender {
    [self selfRemove];
    lgf_HaveBlock(self.confirmBlock);
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
