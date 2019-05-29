//
//  LGFImageAlertView.h
//  LGFOCTool
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

@interface LGFImageAlertViewStyle : NSObject
@property (strong, nonatomic) UIImage *lgf_AlertImage;
@property (strong, nonatomic) UIColor *lgf_AlertBackColor;
@property (nonatomic, assign) CGFloat lgf_AlertCornerRadius;
@property (nonatomic, copy) NSString *lgf_SureTitle;
@property (nonatomic, strong) UIColor *lgf_SureTitleColor;
@property (nonatomic, strong) UIColor *lgf_SureTitleBackColor;
@property (nonatomic, strong) UIFont *lgf_SureTitleFont;
@property (assign, nonatomic) CGFloat lgf_AlertWidth;
@property (assign, nonatomic) CGFloat lgf_AlertHeight;
@property (assign, nonatomic) CGFloat lgf_CenterLineHeight;
@property (copy, nonatomic) NSString *lgf_Message;
lgf_ViewForH;
@end

@interface LGFImageAlertView : UIView
typedef void(^LGFImageSureBlock) (void);
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIView *alertBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertHeight;
@property (weak, nonatomic) IBOutlet UIImageView *alertImageView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *centerLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLineHeight;
@property (nonatomic, weak) UIView *firstResponderView;
@property (nonatomic, copy) LGFImageSureBlock sureBlock;
@property (nonatomic, strong) LGFImageAlertViewStyle *style;
lgf_XibViewForH;
- (void)lgf_ShowImageAlertWithImage:(UIImage *)image message:(NSString *)message sure:(LGFImageSureBlock)sure;
- (void)lgf_ShowImageAlertWithStyle:(LGFImageAlertViewStyle *)style sure:(LGFImageSureBlock)sure;
@end
