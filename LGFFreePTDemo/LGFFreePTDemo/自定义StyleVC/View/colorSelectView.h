//
//  colorSelectView.h
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/14.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFColorSelectImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface colorSelectView : UIView
@property (weak, nonatomic) IBOutlet LGFColorSelectImageView *colorImage;
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;
@property (weak, nonatomic) IBOutlet UIView *selectColorView;
@property (weak, nonatomic) IBOutlet UISlider *colorAlphaSelect;
@property (weak, nonatomic) IBOutlet UISlider *colorDarkSelect;
@property (weak, nonatomic) IBOutlet UILabel *alphaLabel;
@property (copy, nonatomic) void(^lgf_CurrentColorBlock)(NSString *colorHexString);
lgf_XibViewForH;
- (void)lgf_ShowColorSelectView:(UIViewController *)VC selectColor:(NSString *)selectColor;
@end

NS_ASSUME_NONNULL_END
