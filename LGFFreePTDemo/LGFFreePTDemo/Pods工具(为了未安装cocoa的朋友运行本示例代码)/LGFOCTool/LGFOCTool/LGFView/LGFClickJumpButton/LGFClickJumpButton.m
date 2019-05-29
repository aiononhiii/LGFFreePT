//
//  LGFClickJumpButton.m
//  OptimalLive
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 QT. All rights reserved.
//

#import "LGFClickJumpButton.h"

@implementation LGFClickJumpButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(lgf_ClickJumpButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(lgf_ClickJumpButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)lgf_ClickJumpButtonTouchUpInside:(UIButton *)sender {
    UIViewAnimationOptions option = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut;
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.9 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:option animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
