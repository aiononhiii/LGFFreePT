//
//  LGFLightTextLabel.m
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFLightTextLabel.h"

@implementation LGFLightTextLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.lgf_LightTextDuration = 2.5;
    self.lgf_LightTextColor = [UIColor whiteColor];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 程序进入前台，并处于活动状态
    self.gradientLayer = [CAGradientLayer layer];
    [self.superview.layer addSublayer:self.gradientLayer];
    self.gradientLayer.frame = self.frame;
    self.gradientLayer.colors = @[(__bridge id)self.textColor.CGColor, (__bridge id)self.lgf_LightTextColor.CGColor, (__bridge id)self.textColor.CGColor];
    self.gradientLayer.locations = @[@0.25, @0.5, @0.75];
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint = CGPointMake(1, 0.5);
    [self.layer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@0, @0, @0.25];
    animation.toValue = @[@0.75, @1, @1];
    animation.duration = self.lgf_LightTextDuration;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    [self.gradientLayer addAnimation:animation forKey:nil];
}

- (void)dealloc {
    [self.gradientLayer removeAllAnimations];
    [self.gradientLayer removeFromSuperlayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.gradientLayer.mask) {
        self.gradientLayer.mask = self.layer;
        self.layer.frame = self.gradientLayer.bounds;
    }
}

@end
