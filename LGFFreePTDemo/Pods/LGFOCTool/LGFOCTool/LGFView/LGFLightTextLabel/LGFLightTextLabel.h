//
//  LGFLightTextLabel.h
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

@interface LGFLightTextLabel : UILabel
@property (strong, nonatomic) IBInspectable UIColor *lgf_LightTextColor;
@property (nonatomic, assign) IBInspectable CGFloat lgf_LightTextDuration;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end
