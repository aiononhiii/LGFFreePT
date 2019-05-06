//
//  LGFPopMenu.m
//  OptimalLive
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018年 QT. All rights reserved.
//

#import "LGFPopMenu.h"

@implementation LGFPopMenuStyle
lgf_ViewForM(LGFPopMenuStyle);
- (instancetype)init {
    self = [super init];
    self.lgf_Arbitrarily = nil;
    self.lgf_PopMenuDirection = lgf_BottomPopMenu;
    self.lgf_PopArrowOffset = 0.0;
    self.lgf_PopArrowCenter = 0.0;
    self.lgf_PopMenuCenter = 0.0;
    self.lgf_PopArrowSize = CGSizeMake(10.0, 10.0);
    self.lgf_PopMenuSize = CGSizeMake(100.0, 100.0);
    self.lgf_PopFromView = [UIApplication sharedApplication].keyWindow;
    self.lgf_PopMenuView = [[UIView alloc] init];
    self.lgf_PopAbsoluteRect = CGRectZero;
    self.lgf_PopMenuViewbackColor = [UIColor whiteColor];
    return self;
}
@end

@implementation LGFPopArrow
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = UIBezierPath.bezierPath;
    if (_style.lgf_PopMenuDirection == lgf_TopPopMenu) {
        [path moveToPoint: CGPointMake(0.0, 0.0)];
        [path addLineToPoint: CGPointMake(rect.size.width / 2, rect.size.height)];
        [path addLineToPoint: CGPointMake(rect.size.width, 0.0)];
    } else if (_style.lgf_PopMenuDirection == lgf_BottomPopMenu) {
        [path moveToPoint: CGPointMake(0.0, rect.size.height)];
        [path addLineToPoint: CGPointMake(rect.size.width / 2, 0.0)];
        [path addLineToPoint: CGPointMake(rect.size.width, rect.size.height)];
    } else if (_style.lgf_PopMenuDirection == lgf_LeftPopMenu) {
        [path moveToPoint: CGPointMake(0.0, 0.0)];
        [path addLineToPoint: CGPointMake(rect.size.width, rect.size.height / 2)];
        [path addLineToPoint: CGPointMake(0.0, rect.size.height)];
    } else if (_style.lgf_PopMenuDirection == lgf_RightPopMenu) {
        [path moveToPoint: CGPointMake(rect.size.width, 0.0)];
        [path addLineToPoint: CGPointMake(0.0, rect.size.height / 2)];
        [path addLineToPoint: CGPointMake(rect.size.width, rect.size.height)];
    }
    [[self.style.lgf_PopMenuViewbackColor colorWithAlphaComponent:1.0] setFill];
    [path fill];
}
@end

@implementation LGFPopMenu
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.frame = lgf_Application.keyWindow.frame;
    return self;
}

- (UIView *)lgf_MenuBackView {
    if (!_lgf_MenuBackView) {
        _lgf_MenuBackView = [[UIView alloc] init];
    }
    return _lgf_MenuBackView;
}

- (LGFPopArrow *)lgf_ArrowView {
    if (!_lgf_ArrowView) {
        _lgf_ArrowView = [[LGFPopArrow alloc] init];
        _lgf_ArrowView.backgroundColor = [UIColor clearColor];
    }
    return _lgf_ArrowView;
}

lgf_ViewForM(LGFPopMenu);

- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style {
    return [self lgf_ShowMenuWithStyle:style willDismiss:nil];
}
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willDismiss:(LGFPopMenuWillDismiss)willDismiss {
    return [self lgf_ShowMenuWithStyle:style willShow:nil willDismiss:willDismiss];
}
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style didDismiss:(LGFPopMenuDidDismiss)didDismiss {
    return [self lgf_ShowMenuWithStyle:style didShow:nil didDidmiss:didDismiss];
}
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willShow:(LGFPopMenuWillShow)willShow {
    return [self lgf_ShowMenuWithStyle:style willShow:willShow willDismiss:nil];
}
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style didShow:(LGFPopMenuDidShow)didShow {
    return [self lgf_ShowMenuWithStyle:style didShow:didShow didDidmiss:nil];
}
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willShow:(LGFPopMenuWillShow)willShow
                          willDismiss:(LGFPopMenuWillDismiss)willDismiss {
    return [self lgf_ShowMenuWithStyle:style willShow:willShow didShow:nil willDismiss:willDismiss didDismiss:nil];
}
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style  didShow:(LGFPopMenuDidShow)didShow didDidmiss:(LGFPopMenuDidDismiss)didDidmiss {
    return [self lgf_ShowMenuWithStyle:style willShow:nil didShow:didShow willDismiss:nil didDismiss:didDidmiss];
}

- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willShow:(LGFPopMenuWillShow)willShow didShow:(LGFPopMenuDidShow)didShow willDismiss:(LGFPopMenuWillDismiss)willDismiss didDismiss:(LGFPopMenuDidDismiss)didDismiss {
    
    if (didDismiss) {
        self.lgf_popMenuWillShow = willShow;
    }
    if (willDismiss) {
        self.lgf_popMenuWillDismiss = willDismiss;
    }
    if (didShow) {
        self.lgf_popMenuDidShow = didShow;
    }
    if (didDismiss) {
        self.lgf_popMenuDidDismiss = didDismiss;
    }
    self.style = style;
    self.lgf_ArrowView.style = style;
    self.style.lgf_PopAbsoluteRect = [style.lgf_PopFromView convertRect:style.lgf_PopFromView.bounds toView:lgf_Application.keyWindow];
    self.lgf_MenuBackView.backgroundColor = [UIColor clearColor];
    self.style.lgf_PopMenuView.backgroundColor = [self.style.lgf_PopMenuViewbackColor colorWithAlphaComponent:1.0];
    [lgf_Application.keyWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * _stop) {
        if ([obj isKindOfClass:[LGFPopMenu class]]) {
            [obj removeFromSuperview];
        }
    }];
    self.frame = lgf_Application.keyWindow.bounds;
    [lgf_Application.keyWindow addSubview:self];
    lgf_HaveBlock(self.lgf_popMenuWillShow, self);
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.05];
    if (self.style.lgf_PopMenuDirection == lgf_TopPopMenu) {
        self.lgf_MenuBackView.frame = CGRectMake(self.style.lgf_PopAbsoluteRect.origin.x - ((self.style.lgf_PopMenuSize.width - self.style.lgf_PopAbsoluteRect.size.width) / 2) + self.style.lgf_PopMenuCenter,
                                                 self.style.lgf_PopAbsoluteRect.origin.y - self.style.lgf_PopArrowSize.height - self.style.lgf_PopMenuSize.height - self.style.lgf_PopArrowOffset, self.style.lgf_PopMenuSize.width, self.style.lgf_PopMenuSize.height + self.style.lgf_PopArrowSize.height);
        self.style.lgf_PopMenuView.frame = CGRectMake(0.0,
                                                  0.0,
                                                  self.style.lgf_PopMenuSize.width,
                                                  self.style.lgf_PopMenuSize.height);
        self.lgf_ArrowView.frame = CGRectMake((self.style.lgf_PopMenuView.lgf_width / 2) - (self.style.lgf_PopArrowSize.width / 2) - self.style.lgf_PopArrowCenter,
                                              self.style.lgf_PopMenuSize.height - 0.5,
                                              self.style.lgf_PopArrowSize.width,
                                              self.style.lgf_PopArrowSize.height);
    } else if (self.style.lgf_PopMenuDirection == lgf_BottomPopMenu) {
        self.lgf_MenuBackView.frame = CGRectMake(self.style.lgf_PopAbsoluteRect.origin.x - ((self.style.lgf_PopMenuSize.width - self.style.lgf_PopAbsoluteRect.size.width) / 2) + self.style.lgf_PopMenuCenter,
                                                 self.style.lgf_PopAbsoluteRect.origin.y + self.style.lgf_PopAbsoluteRect.size.height + self.style.lgf_PopArrowOffset,
                                                 self.style.lgf_PopMenuSize.width,
                                                 self.style.lgf_PopMenuSize.height + self.style.lgf_PopArrowSize.height);
        self.style.lgf_PopMenuView.frame = CGRectMake(0.0,
                                                  self.style.lgf_PopArrowSize.height,
                                                  self.style.lgf_PopMenuSize.width,
                                                  self.style.lgf_PopMenuSize.height);
        self.lgf_ArrowView.frame = CGRectMake((self.style.lgf_PopMenuView.lgf_width / 2) - (self.style.lgf_PopArrowSize.width / 2) + self.style.lgf_PopArrowCenter,
                                              0.0,
                                              self.style.lgf_PopArrowSize.width,
                                              self.style.lgf_PopArrowSize.height + 0.5);
    } else if (self.style.lgf_PopMenuDirection == lgf_LeftPopMenu) {
        self.lgf_MenuBackView.frame = CGRectMake(self.style.lgf_PopAbsoluteRect.origin.x - self.style.lgf_PopArrowSize.height - self.style.lgf_PopMenuSize.width - self.style.lgf_PopArrowOffset,
                                                 self.style.lgf_PopAbsoluteRect.origin.y - ((self.style.lgf_PopMenuSize.height - self.style.lgf_PopAbsoluteRect.size.height) / 2) - self.style.lgf_PopMenuCenter,
                                                 self.style.lgf_PopMenuSize.width + self.style.lgf_PopArrowSize.height,
                                                 self.style.lgf_PopMenuSize.height);
        self.style.lgf_PopMenuView.frame = CGRectMake(0.0,
                                                  0.0,
                                                  self.style.lgf_PopMenuSize.width,
                                                  self.style.lgf_PopMenuSize.height);
        self.lgf_ArrowView.frame = CGRectMake(self.style.lgf_PopMenuSize.width - 0.5,
                                              (self.style.lgf_PopMenuView.lgf_height / 2) - (self.style.lgf_PopArrowSize.width / 2) + self.style.lgf_PopArrowCenter,
                                              self.style.lgf_PopArrowSize.height,
                                              self.style.lgf_PopArrowSize.width);
    } else if (self.style.lgf_PopMenuDirection == lgf_RightPopMenu) {
        self.lgf_MenuBackView.frame = CGRectMake(self.style.lgf_PopAbsoluteRect.origin.x + self.style.lgf_PopAbsoluteRect.size.width,
                                                 self.style.lgf_PopAbsoluteRect.origin.y - ((self.style.lgf_PopMenuSize.height - self.style.lgf_PopAbsoluteRect.size.height) / 2) - self.style.lgf_PopMenuCenter,
                                                 self.style.lgf_PopMenuSize.width + self.style.lgf_PopMenuSize.height,
                                                 self.style.lgf_PopMenuSize.height);
        self.style.lgf_PopMenuView.frame = CGRectMake(self.style.lgf_PopArrowOffset + self.style.lgf_PopArrowSize.height,
                                                  0.0,
                                                  self.style.lgf_PopMenuSize.width,
                                                  self.style.lgf_PopMenuSize.height);
        self.lgf_ArrowView.frame = CGRectMake(self.style.lgf_PopArrowOffset,
                                              (self.style.lgf_PopMenuView.lgf_height / 2) - (self.style.lgf_PopArrowSize.width / 2) + self.style.lgf_PopArrowCenter,
                                              self.style.lgf_PopArrowSize.height + 0.5,
                                              self.style.lgf_PopArrowSize.width);
    }
    self.lgf_MenuBackView.alpha = style.lgf_PopMenuViewbackColor.lgf_Alpha;
    [self addSubview:self.lgf_MenuBackView];
    [self.lgf_MenuBackView addSubview:self.lgf_ArrowView];
    [self.lgf_MenuBackView addSubview:self.style.lgf_PopMenuView];
    self.lgf_MenuBackView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.lgf_MenuBackView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        lgf_HaveBlock(self.lgf_popMenuDidShow, self);
    }];
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches anyObject].view == self) {
        [self lgf_Dismiss:nil];
    }
}

- (void)lgf_Dismiss {
    [self lgf_Dismiss:nil];
}

- (void)lgf_Dismiss:(LGFPopMenuReturnArbitrarily)lgf_Arbitrarily {
    lgf_HaveBlock(self.lgf_popMenuWillDismiss, self);
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    }];
    self.lgf_MenuBackView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3 animations:^{
        if (self.style.lgf_PopMenuDirection == lgf_TopPopMenu) {
            self.lgf_MenuBackView.transform = CGAffineTransformMakeTranslation(0, 4);
        } else if (self.style.lgf_PopMenuDirection == lgf_BottomPopMenu) {
            self.lgf_MenuBackView.transform = CGAffineTransformMakeTranslation(0, -4);
        } else if (self.style.lgf_PopMenuDirection == lgf_LeftPopMenu) {
            self.lgf_MenuBackView.transform = CGAffineTransformMakeTranslation(4, 0);
        } else if (self.style.lgf_PopMenuDirection == lgf_RightPopMenu) {
            self.lgf_MenuBackView.transform = CGAffineTransformMakeTranslation(-4, 0);
        }
        self.lgf_MenuBackView.alpha = 0.0;
    } completion:^(BOOL finished) {
        lgf_HaveBlock(self.lgf_popMenuDidDismiss, self);
        lgf_HaveBlock(lgf_Arbitrarily, self.style.lgf_Arbitrarily)
        [self.lgf_MenuBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
@end
