//
//  LGFPopMenu.h
//  OptimalLive
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

typedef NS_ENUM(NSUInteger, lgf_PopMenuDirection) {
    lgf_TopPopMenu,
    lgf_BottomPopMenu,
    lgf_LeftPopMenu,
    lgf_RightPopMenu,
};

@interface LGFPopMenuStyle : NSObject
lgf_ViewForH;
/**
 用于记录/传入/保存(tag,indexpath...)任意值 备注：该值会在 LGFPopMenu 走 DidDismiss 时回调出去
 */
@property (nonatomic, strong) id lgf_Arbitrarily;
/**
 菜单方向
 */
@property (nonatomic, assign) lgf_PopMenuDirection lgf_PopMenuDirection;
/**
 菜单 view
 */
@property (nonatomic, strong) UIView *lgf_PopMenuView;
/**
 菜单弹出 view
 */
@property (nonatomic, strong) UIView *lgf_PopFromView;
/**
 菜单大小
 */
@property (nonatomic, assign) CGSize lgf_PopMenuSize;
/**
 箭头大小
 */
@property (nonatomic, assign) CGSize lgf_PopArrowSize;
/**
 箭头相对于菜单 Center 位置
 */
@property (nonatomic, assign) CGFloat lgf_PopArrowCenter;
/**
 PopMenu相对于 PopFromView Center 位置
 */
@property (nonatomic, assign) CGFloat lgf_PopMenuCenter;
/**
 箭头尖尖相对于 lgf_PopFromView 的距离
 */
@property (nonatomic, assign) CGFloat lgf_PopArrowOffset;
/**
 绝对位置
 */
@property (nonatomic, assign) CGRect lgf_PopAbsoluteRect;
/**
 背景色
 */
@property (nonatomic, strong) UIColor *lgf_PopMenuViewbackColor;
@end

@interface LGFPopArrow : UIView
@property (nonatomic, strong) LGFPopMenuStyle *style;
@end

@interface LGFPopMenu : UIView
typedef void(^LGFPopMenuWillDismiss)(LGFPopMenu *popMenu);
typedef void(^LGFPopMenuWillShow)(LGFPopMenu *popMenu);
typedef void(^LGFPopMenuDidDismiss)(LGFPopMenu *popMenu);
typedef void(^LGFPopMenuDidShow)(LGFPopMenu *popMenu);
typedef void(^LGFPopMenuReturnArbitrarily)(id lgf_Arbitrarily);
// pop 菜单配置
@property (nonatomic, strong) LGFPopMenuStyle *style;
// pop 菜单背景 view
@property (nonatomic, strong) UIView *lgf_MenuBackView;
// pop 菜单箭头 view
@property (nonatomic, strong) LGFPopArrow *lgf_ArrowView;
// pop 菜单将要隐藏 block
@property (nonatomic, copy) LGFPopMenuWillDismiss lgf_popMenuWillDismiss;
// pop 菜单将要显示 block
@property (nonatomic, copy) LGFPopMenuWillShow lgf_popMenuWillShow;
// pop 菜单完全隐藏 block
@property (nonatomic, copy) LGFPopMenuDidDismiss lgf_popMenuDidDismiss;
// pop 菜单完全显示 block
@property (nonatomic, copy) LGFPopMenuDidShow lgf_popMenuDidShow;
lgf_ViewForH;
/**
 显示 pop 菜单
 @param style LGFPopMenu 配置信息 / willShow 将要显示 didShow 已经显示 willDismiss 将要隐藏 didDismiss 已经隐藏
 @return LGFPopMenu自己
 */
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willDismiss:(LGFPopMenuWillDismiss)willDismiss;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style didDismiss:(LGFPopMenuDidDismiss)didDismiss;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willShow:(LGFPopMenuWillShow)willShow;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style didShow:(LGFPopMenuDidShow)didShow;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willShow:(LGFPopMenuWillShow)willShow
                          willDismiss:(LGFPopMenuWillDismiss)willDismiss;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style didShow:(LGFPopMenuDidShow)didShow didDidmiss:(LGFPopMenuDidDismiss)didDidmiss;
- (instancetype)lgf_ShowMenuWithStyle:(LGFPopMenuStyle *)style willShow:(LGFPopMenuWillShow)willShow didShow:(LGFPopMenuDidShow)didShow willDismiss:(LGFPopMenuWillDismiss)willDismiss didDismiss:(LGFPopMenuDidDismiss)didDismiss;
/**
 隐藏 pop 菜单
 */
- (void)lgf_Dismiss;
/**
 隐藏 pop 菜单
 @param lgf_Arbitrarily 之前由 LGFPopMenuStyle 保存的任意值
 */
- (void)lgf_Dismiss:(LGFPopMenuReturnArbitrarily)lgf_Arbitrarily;
@end
