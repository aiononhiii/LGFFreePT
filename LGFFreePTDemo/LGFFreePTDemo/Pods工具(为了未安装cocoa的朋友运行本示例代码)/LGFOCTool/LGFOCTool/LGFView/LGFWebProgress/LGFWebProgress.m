//
//  LGFWebProgress.m
//  OptimalLive
//
//  Created by apple on 2018/12/10.
//  Copyright © 2018年 QT. All rights reserved.
//

#import "LGFWebProgress.h"

@interface LGFWebProgress ()
@property (assign, nonatomic) BOOL isFinishLoad;
@property (strong, nonatomic) UIView *progressLine;
@end
@implementation LGFWebProgress

lgf_XibViewForM(LGFWebProgress, @"LGFOCTool");

- (void)lgf_ShowLGFWebProgress:(UIView *)SV top:(CGFloat)top height:(CGFloat)height color:(UIColor *)color {
    [self.progressLine removeFromSuperview];
    [self removeFromSuperview];
    self.frame = CGRectMake(0, top, SV.lgf_width, height);
    self.clipsToBounds = YES;
    self.alpha = 1.0;
    self.isFinishLoad = NO;
    [SV addSubview:self];
    self.progressLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    self.progressLine.backgroundColor = color;
    [self addSubview:self.progressLine];
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.progressLine.lgf_width = self.lgf_width * 0.8;
    } completion:^(BOOL finished) {
    }];
}

- (void)finishLoad {
    if (!self.isFinishLoad) {
        [UIView animateWithDuration:0.2 + 0.8 * self.progressLine.lgf_width / self.lgf_width animations:^{
            self.progressLine.lgf_width = self.lgf_width;
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.lgf_height = 0.0;
                } completion:^(BOOL finished) {
                    [self.progressLine removeFromSuperview];
                    [self removeFromSuperview];
                }];
            }
        }];
    }
    self.isFinishLoad = YES;
}

@end
