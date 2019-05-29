//
//  NSString+LGFString.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIView+LGFTopBarMessage.h"
#import <objc/runtime.h>

@implementation LGFTopMessageView

lgf_AllocOnceForM(LGFTopMessageView);

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.messageLabel];
        self.messageIcon = [[UIImageView alloc] init];
        self.messageIcon.clipsToBounds = YES;
        self.messageIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.messageIcon];
        // 添加轻扫手势
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUp];
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        
        // 添加轻击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNow)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapNow {
    // 点击了message
    [self dismiss];
    if (self.tapHandler) {
        self.tapHandler();
    }
}

- (void)dismiss {
    // 隐藏 LGFTopMessageView
    if (!CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity)) {
        [UIView animateWithDuration:self.style.lgf_AnimateDuration animations:^{
            for (UIView *view in self.superview.subviews) {
                if (![view isKindOfClass:[LGFTopMessageView class]]) {
                    if (self.style.lgf_MessageMode == lgf_Resize) {
                        view.transform = CGAffineTransformIdentity;
                    }
                } else {
                    view.transform = CGAffineTransformIdentity;
                }
            }
        } completion:^(BOOL finished) {
            for (UIView *view in self.superview.subviews) {
                view.userInteractionEnabled = YES;
            }
            [self removeFromSuperview];
        }];
    }
}

- (void)setStyle:(LGFTopMessageStyle *)style {
    _style = style;
    [self resetViews];
}

- (void)resetViews {
    // 控件赋值
    self.messageLabel.numberOfLines = self.style.lgf_LabelMaxLine;
    self.messageLabel.text = self.style.lgf_Message;
    self.backgroundColor = self.style.lgf_MessageBackColor;
    self.messageLabel.textColor = self.style.lgf_MessageTextColor;
    self.messageIcon.image = self.style.lgf_MessageIcon;
    self.messageLabel.font = self.style.lgf_MessageLabelFont;
    self.messageIcon.layer.cornerRadius = self.style.lgf_IconCornerRadius;
}

- (void)layoutSubviews {
    // 根据文字获取动态高度
    CGFloat labelWidth = self.lgf_width - (self.style.lgf_BetweenIconAndMessage * 3 + self.style.lgf_IconWidth);
    CGFloat labelHeight = MIN([self.style.lgf_Message lgf_HeightWithFont:self.style.lgf_MessageLabelFont constrainedToWidth:labelWidth], [@"" lgf_HeightWithFont:self.style.lgf_MessageLabelFont constrainedToWidth:labelWidth] * self.style.lgf_LabelMaxLine);
    if (!self.style.lgf_MessageIcon) {
        self.style.lgf_IconWidth = 0.0;
    }
    self.messageIcon.frame = CGRectMake(self.style.lgf_BetweenIconAndMessage, MAX(0, (self.lgf_height - self.style.lgf_IconWidth) / 2), self.style.lgf_IconWidth, self.style.lgf_IconWidth);
    self.messageLabel.frame = CGRectMake(self.style.lgf_IconWidth + self.style.lgf_BetweenIconAndMessage * 2, MAX(0, (self.lgf_height - labelHeight) / 2), self.lgf_width - (self.style.lgf_BetweenIconAndMessage * 3 + self.messageIcon.lgf_width), labelHeight);
}

@end

@implementation UIView (LGFTopBarMessage)

static char TopMessageKey;

- (void)lgf_ShowTopMessage:(NSString *)message {
    LGFTopMessageStyle *style = [LGFTopMessageStyle lgf];
    style.lgf_Message = message;
    [self lgf_ShowTopMessageWithStyle:style withTapBlock:nil];
}

- (void)lgf_ShowTopMessageWithStyle:(LGFTopMessageStyle *)style withTapBlock:(dispatch_block_t)tapHandler {
    // 首先判断 self 是否已经全部加载完毕
    [self showMessageWithStyle:style withTapBlock:tapHandler];
}

- (void)showMessageWithStyle:(LGFTopMessageStyle *)style withTapBlock:(dispatch_block_t)tapHandler {
    self.clipsToBounds = YES;
    // 动态加载 LGFTopMessageView 防止其他视图控制器添加无用属性
    LGFTopMessageView *topMessageV = objc_getAssociatedObject(self, &TopMessageKey);
    if (topMessageV.transform.ty != 0.0) { return; }
    // 获取 label 的高度 LGFTopMessageView 的高度等于 label的高度 + lgf_topBarSpacingHeight
    CGFloat labelWidth = self.lgf_width - (style.lgf_BetweenIconAndMessage * 3 + style.lgf_IconWidth);
    CGFloat labelHeight = MIN([style.lgf_Message lgf_HeightWithFont:style.lgf_MessageLabelFont constrainedToWidth:labelWidth], [@"" lgf_HeightWithFont:style.lgf_MessageLabelFont constrainedToWidth:labelWidth] * style.lgf_LabelMaxLine);
    if (!topMessageV) {
        topMessageV = [LGFTopMessageView lgf_Once];
        objc_setAssociatedObject(self, &TopMessageKey, topMessageV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    topMessageV.layer.cornerRadius = style.lgf_CornerRadius;
    topMessageV.layer.shadowColor = [UIColor blackColor].CGColor;
    topMessageV.layer.shadowRadius = 5;
    topMessageV.layer.shadowOpacity = 0.2;
    topMessageV.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    topMessageV.frame = CGRectMake(style.lgf_LeftRightSpacing, -(style.lgf_TopBarSpacingHeight + MAX(labelHeight, style.lgf_IconWidth)), CGRectGetWidth(self.bounds) - style.lgf_LeftRightSpacing * 2, style.lgf_TopBarSpacingHeight + MAX(labelHeight, style.lgf_IconWidth));
    topMessageV.tapHandler = tapHandler;
    topMessageV.style = style;
    [self addSubview:topMessageV];
    
    // 隐藏之前取消延迟
    [NSObject cancelPreviousPerformRequestsWithTarget:topMessageV];
    
    // 延迟隐藏
    [topMessageV performSelector:@selector(dismiss) withObject:nil afterDelay:MAX(1, style.lgf_DimissDelay) + style.lgf_AnimateDuration];
    // 执行显示动画
    [UIView animateWithDuration:style.lgf_AnimateDuration animations:^{
        
        for (UIView *view in self.subviews) {
            if (![view isKindOfClass:[LGFTopMessageView class]]) {
                if (style.lgf_MessageMode == lgf_Resize) {
                    view.transform = CGAffineTransformMakeTranslation(0, topMessageV.lgf_height + style.lgf_TopSpacing);
                }
                view.userInteractionEnabled = NO;
            } else {
                view.transform = CGAffineTransformMakeTranslation(0, topMessageV.lgf_height + style.lgf_TopSpacing);
            }
        }
    }];
}

- (void)lgf_DismissTopMessage {
    NSArray *subViews = self.subviews;
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[LGFTopMessageView class]]) {
            LGFTopMessageView *view = (LGFTopMessageView *)subView;
            [view dismiss];
        }
    }
}

@end

@implementation LGFTopMessageStyle

lgf_ViewForM(LGFTopMessageStyle);

- (instancetype)init {
    self = [super init];
    // 默认配置
    self.lgf_LeftRightSpacing = 0.0;
    self.lgf_TopSpacing = 0.0;
    self.lgf_CornerRadius = 0.0;
    self.lgf_MessageBackColor = [UIColor lgf_ColorWithHexString:@"FBF9FA"];
    self.lgf_MessageTextColor = [UIColor blackColor];
    self.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
    self.lgf_MessageIcon = nil;
    self.lgf_LabelMaxLine = 1;
    self.lgf_MessageMode = lgf_Overlay;
    self.lgf_DimissDelay = 2.0;
    self.lgf_Message = @"";
    self.lgf_IconWidth = 20.0;
    self.lgf_IconCornerRadius = 0.0;
    self.lgf_BetweenIconAndMessage = 10.0;
    self.lgf_AnimateDuration = 0.5;
    self.lgf_TopBarSpacingHeight = 20.0;
    return self;
}

@end
