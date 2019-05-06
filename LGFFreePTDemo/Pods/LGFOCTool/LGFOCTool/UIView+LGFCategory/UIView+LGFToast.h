//
//  UIView+lgf_Toast.h
//  lgf_OCTool
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

typedef NS_ENUM(NSUInteger, lgf_ToastPosition) {
    lgf_ToastCenter,
    lgf_ToastTop,
    lgf_ToastBottom,
};

typedef NS_ENUM(NSUInteger, lgf_ToastImagePosition) {
    lgf_ToastImageTop,
    lgf_ToastImageBottom,
    lgf_ToastImageLeft,
    lgf_ToastImageRight,
    lgf_ToastOnlyImage
};

@interface LGFToastStyle : NSObject
// Toast文字
@property (copy, nonatomic) NSString *lgf_ToastMessage;
// Toast文字字体
@property (nonatomic, strong) UIFont *lgf_ToastMessageFont;
// Toast文字颜色
@property (nonatomic, strong) UIColor *lgf_ToastMessageTextColor;
// Toast图片名字 可为gif
@property (nonatomic, copy) NSString *lgf_ToastImageName;
// Toast位置
@property (assign, nonatomic) lgf_ToastPosition lgf_ToastPosition;
// 图片相对于文字位置
@property (assign, nonatomic) lgf_ToastImagePosition lgf_ToastImagePosition;
// Toast背景色
@property (nonatomic, strong) UIColor *lgf_ToastBackColor;
// 边框颜色
@property (nonatomic, strong) UIColor *lgf_ToastBorderColor;
// 边框粗细
@property (assign, nonatomic) CGFloat lgf_ToastBorderWidth;
// Toast圆角
@property (assign, nonatomic) CGFloat lgf_ToastCornerRadius;
// Toast消失动画时间
@property (assign, nonatomic) NSTimeInterval lgf_DismissDuration;
// Toast停留时间
@property (assign, nonatomic) NSTimeInterval lgf_Duration;
// 图片文字间隔
@property (assign, nonatomic) CGFloat lgf_MessageImageSpacing;
// 四边距离
@property (assign, nonatomic) CGFloat lgf_ToastSpacing;
// Toast最大宽度
@property (assign, nonatomic) CGFloat lgf_MaxWidth;
// Toast最大高度
@property (assign, nonatomic) CGFloat lgf_MaxHeight;
// 是否阻挡父View手势
@property (assign, nonatomic) BOOL lgf_SuperEnabled;
// 是否阻挡父View手势
@property (nonatomic, assign) BOOL lgf_BackBtnEnabled;
// 是否有图片
@property (assign, nonatomic) BOOL lgf_ToastHaveIamge;
// 图片限定大小
@property (assign, nonatomic) CGSize lgf_ToastImageSize;
lgf_ViewForH;
- (CGFloat)lgf_HeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
- (CGFloat)lgf_WidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height;
@end

@interface LGFToastView : UIView
@property (nonatomic, strong) LGFToastStyle *style;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *message;
lgf_AllocOnceForH;
@end

@interface UIView (LGFToast)
- (void)lgf_ShowMessage:(NSString *)message
             completion:(void (^ __nullable)(void))completion;
- (void)lgf_ShowMessage:(NSString *)message
               animated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion;
- (void)lgf_ShowMessage:(NSString *)message
            maxDuration:(BOOL)maxDuration
               animated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion;
- (void)lgf_ShowMessageStyle:(LGFToastStyle *)style
                    animated:(BOOL)animated
                  completion:(void (^ __nullable)(void))completion;
- (void)lgf_HideMessage:(void (^ __nullable)(void))completion;
- (void)lgf_ShowToastActivity:(UIEdgeInsets)Insets isClearBack:(BOOL)isClearBack cornerRadius:(CGFloat)cornerRadius style:(UIActivityIndicatorViewStyle)style;
- (void)lgf_HideToastActivity;

#pragma mark - 覆盖全view的遮罩文字
- (void)lgf_ShowScreenMessage:(NSString *)message fontSize:(CGFloat)fontSize cr:(CGFloat)cr;
- (void)lgf_HideScreenMessage;
@end


