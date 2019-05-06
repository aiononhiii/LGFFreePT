//
//  QTAlertView.h
//  OptimalLive
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

@interface LGFAlertViewStyle : NSObject
@property (strong, nonatomic) UIColor *lgf_AlertBackColor;
@property (nonatomic, assign) CGFloat lgf_AlertCornerRadius;
@property (nonatomic, copy) NSString *lgf_CancelTitle;
@property (nonatomic, strong) UIColor *lgf_CancelTitleColor;
@property (nonatomic, strong) UIColor *lgf_CancelBackColor;
@property (nonatomic, strong) UIFont *lgf_CancelTitleFont;
@property (nonatomic, copy) NSString *lgf_ConfirmTitle;
@property (nonatomic, strong) UIColor *lgf_ConfirmTitleColor;
@property (nonatomic, strong) UIColor *lgf_ConfirmBackColor;
@property (nonatomic, strong) UIFont *lgf_ConfirmTitleFont;
@property (nonatomic, copy) NSString *lgf_SureTitle;
@property (nonatomic, strong) UIColor *lgf_SureTitleColor;
@property (nonatomic, strong) UIColor *lgf_SureTitleBackColor;
@property (nonatomic, strong) UIFont *lgf_SureTitleFont;
@property (nonatomic, copy) NSString *lgf_HighColorTitle;
@property (nonatomic, strong) UIColor *lgf_HighColor;
@property (nonatomic, strong) UIFont *lgf_MessageFont;
@property (assign, nonatomic) CGFloat lgf_CenterLineHeight;
lgf_ViewForH;
@end

@interface LGFAlertView : UIView
typedef void(^LGFCancelBlock) (void);
typedef void(^LGFConfirmBlock) (void);
typedef void(^LGFSureBlock) (void);
@property (weak, nonatomic) IBOutlet UIView *alertBackView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *centerLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLineHeight;
@property (nonatomic, weak) UIView *firstResponderView;
@property (nonatomic, copy) LGFCancelBlock cancelBlock;
@property (nonatomic, copy) LGFConfirmBlock confirmBlock;
@property (nonatomic, copy) LGFSureBlock sureBlock;
@property (nonatomic, strong) LGFAlertViewStyle *style;
lgf_XibViewForH;
- (void)lgf_ShowAlertWithMessage:(NSString *)message sure:(LGFSureBlock)sure;
- (void)lgf_ShowAlertWithMessage:(NSString *)message cancel:(LGFCancelBlock)cancel confirm:(LGFConfirmBlock)confirm;
- (void)lgf_ShowAlertWithStyle:(LGFAlertViewStyle *)style message:(NSString *)message sure:(LGFSureBlock)sure;
- (void)lgf_ShowAlertWithStyle:(LGFAlertViewStyle *)style message:(NSString *)message cancel:(LGFCancelBlock)cancel confirm:(LGFConfirmBlock)confirm;
@end
