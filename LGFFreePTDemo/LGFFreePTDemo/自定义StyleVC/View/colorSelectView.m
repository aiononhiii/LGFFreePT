//
//  colorSelectView.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/14.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "colorSelectView.h"

@interface colorSelectView()
@property (strong, nonatomic) UIImage *image;
@end
@implementation colorSelectView

lgf_XibViewForM(colorSelectView, @"colorSelectView");

- (void)lgf_ShowColorSelectView:(UIViewController *)VC selectColor:(NSString *)selectColor {
    self.frame = VC.view.bounds;
    [VC.view addSubview:self];
    self.colorImage.layer.cornerRadius = (lgf_ScreenWidth * 0.8 - 40) / 2.0;
    self.image = [UIImage imageNamed:@"colorSelect.png"];
    self.hexLabel.text = selectColor;
    self.selectColorView.backgroundColor = lgf_HexColor(selectColor);
    self.colorAlphaSelect.value = lgf_HexColor(selectColor).lgf_Alpha;
    self.alphaLabel.text = [NSString stringWithFormat:@"透明度:%.1f", lgf_HexColor(selectColor).lgf_Alpha];
    
    @lgf_Weak(self);
    self.colorImage.lgf_CurrentColorBlock = ^(UIColor * _Nonnull color, NSString * _Nonnull colorHexString) {
        @lgf_Strong(self);
        self.selectColorView.backgroundColor = [color colorWithAlphaComponent:self.colorAlphaSelect.value];
        self.hexLabel.text = [self.selectColorView.backgroundColor lgf_HexStringWithAlpha];
    };
}

- (IBAction)finish:(UIButton *)sender {
    lgf_HaveBlock(self.lgf_CurrentColorBlock, self.hexLabel.text);
    [self removeFromSuperview];
}

- (IBAction)alphaSet:(UISlider *)sender {
    self.selectColorView.backgroundColor = [self.selectColorView.backgroundColor colorWithAlphaComponent:sender.value];
    self.alphaLabel.text = [NSString stringWithFormat:@"透明度:%.1f", sender.value];
    self.hexLabel.text = [self.selectColorView.backgroundColor lgf_HexStringWithAlpha];
}

- (IBAction)darkSet:(UISlider *)sender {
    self.colorImage.image = [self.image lgf_ImageToDark:sender.value];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches anyObject].view == self) {
        [self removeFromSuperview];
    }
}

@end
