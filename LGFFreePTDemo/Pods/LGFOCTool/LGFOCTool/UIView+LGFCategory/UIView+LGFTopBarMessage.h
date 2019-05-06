//
//  NSString+LGFString.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

typedef NS_ENUM(NSUInteger, lgf_TopBarMessageMode) {
    lgf_Overlay,// //视图不下移 默认
    lgf_Resize,// 视图下移 (设置此项将取消手势隐藏 LGFTopMessageView 和 LGFTopMessageView 点击事件)
};

#pragma mark - 提示view style

@interface LGFTopMessageStyle : NSObject
lgf_ViewForH;
// 提示框左右边距
@property (assign, nonatomic) CGFloat lgf_LeftRightSpacing;
// 提示框上边距
@property (assign, nonatomic) CGFloat lgf_TopSpacing;
// 提示框圆角
@property (assign, nonatomic) CGFloat lgf_CornerRadius;
// 提示文本
@property (copy, nonatomic) NSString *lgf_Message;
// 文本最多显示行数
@property (assign, nonatomic) NSInteger lgf_LabelMaxLine;
// 文本字体
@property (strong, nonatomic) UIFont *lgf_MessageLabelFont;
// 文本颜色
@property (strong, nonatomic) UIColor *lgf_MessageTextColor;
// 图片
@property (strong, nonatomic) UIImage *lgf_MessageIcon;
// 图片宽度
@property (assign, nonatomic) CGFloat lgf_IconWidth;
// 图片宽度
@property (assign, nonatomic) CGFloat lgf_IconCornerRadius;
// 图片与文本与边框间距
@property (assign, nonatomic) CGFloat lgf_BetweenIconAndMessage;
// 显示滞留时间 设置 0.0 为无限
@property (assign, nonatomic) CGFloat lgf_DimissDelay;
// 动画时间
@property (assign, nonatomic) CGFloat lgf_AnimateDuration;
// TopBar中间 label 距离顶部和底部两边边距
@property (assign, nonatomic) CGFloat lgf_TopBarSpacingHeight;
// 背景颜色
@property (strong, nonatomic) UIColor *lgf_MessageBackColor;
// 视图是否下移
@property (assign, nonatomic) lgf_TopBarMessageMode lgf_MessageMode;
@end

#pragma mark - 提示view

@interface LGFTopMessageView : UIView
@property (strong, nonatomic) LGFTopMessageStyle *style;
@property (nonatomic, strong) UIImageView *messageIcon;
@property (nonatomic, strong) UILabel *messageLabel;
// 点击回调 Block
@property (nonatomic, copy) dispatch_block_t tapHandler;
lgf_AllocOnceForH;
@end

#pragma mark - 提示view UIViewController 分类结合

@interface UIView (LGFTopBarMessage)

/**
 展示顶部警报条
 @param style        参数设置
 @param tapHandler   点击顶部条回调 lgf_TopBarMessageMode 为 lgf_Resize 该项无效
 */
- (void)lgf_ShowTopMessageWithStyle:(LGFTopMessageStyle *)style withTapBlock:(dispatch_block_t)tapHandler;

/**
 展示顶部提示条
 @param message      提示文字
 */
- (void)lgf_ShowTopMessage:(NSString *)message;

/**
 隐藏弹出视图
 */
- (void)lgf_DismissTopMessage;

@end

