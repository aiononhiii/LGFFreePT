//
//  LGFFreePTTitle.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFFreePTStyle.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LGFFreePTTitleDelegate <NSObject>
@optional
#pragma mark - 加载 title 网络图片代理，具体加载框架我的 Demo 不做约束，请自己选择图片加载框架
/**
 @param imageView 要加载网络图片的 imageView
 @param imageUrl 网络图片的 Url
 */
- (void)lgf_GetTitleNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl;
@end
@interface LGFFreePTTitle : UIView
@property (weak, nonatomic) IBOutlet UILabel *lgf_Title;// 标
@property (weak, nonatomic) IBOutlet UILabel *lgf_SubTitle;// 子标
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TitleWidth;// 标宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TitleHeight;// 标高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_SubTitleTop;// 子标相对于标距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_SubTitleWidth;// 标宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_SubTitleHeight;// 子标高度（子标宽度暂时于标共享取两者MAX值）
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TitleCenterX;// 标中心X
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TitleCenterY;// 标中心Y

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TopImageSpace;// 标上图片相对于标距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_BottomImageSpace;// 标下图片相对于标距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_LeftImageSpace;// 标左图片相对于标距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_RightImageSpace;// 标右图片相对于标距离

@property (weak, nonatomic) IBOutlet UIImageView *lgf_TopImage;// 标上图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TopImageWidth;// 标上图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_TopImageHeight;// 标上图片高度

@property (weak, nonatomic) IBOutlet UIImageView *lgf_BottomImage;// 标下图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_BottomImageWidth;// 标下图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_BottomImageHeight;// 标下图片高度

@property (weak, nonatomic) IBOutlet UIImageView *lgf_LeftImage;// 标左图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_LeftImageWidth;// 标左图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_LeftImageHeight;// 标左图片高度

@property (weak, nonatomic) IBOutlet UIImageView *lgf_RightImage;// 标右图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_RightImageWidth;// 标右图片宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_RightImageHeight;// 标右图片高度

@property (strong, nonatomic) NSMutableArray *lgf_SelectImageNames;// 选中图片数组
@property (strong, nonatomic) NSMutableArray *lgf_UnSelectImageNames;// 未选中图片数组

@property (assign, nonatomic) BOOL lgf_IsHaveImage;// 是否有标图片
@property (strong, nonatomic) LGFFreePTStyle *lgf_Style;// 配置用模型
@property (assign, nonatomic) CGFloat lgf_CurrentTransformSX;// 放大缩小倍数
@property (assign, nonatomic) CGFloat lgf_MainTitleCurrentTransformSX;// 主标题放大缩小倍数
@property (assign, nonatomic) CGFloat lgf_MainTitleCurrentTransformTY;// 主标题上下位移
@property (assign, nonatomic) CGFloat lgf_MainTitleCurrentTransformTX;// 主标题左右位移
@property (assign, nonatomic) CGFloat lgf_SubTitleCurrentTransformSX;// 子标题放大缩小倍数
@property (assign, nonatomic) CGFloat lgf_SubTitleCurrentTransformTY;// 子标题上下位移
@property (assign, nonatomic) CGFloat lgf_SubTitleCurrentTransformTX;// 子标题左右位移

@property (weak, nonatomic) id<LGFFreePTTitleDelegate>lgf_FreePTTitleDelegate;

#pragma mark - 标整体状态改变 核心逻辑部分
/**
 @param progress 外部 progress
 @param isSelectTitle 是否是要选中的 LGFFreePTTitle
 @param selectIndex 选中的 index
 @param unselectIndex 未选中的 index
 */
- (void)lgf_SetMainTitleTransform:(CGFloat)progress isSelectTitle:(BOOL)isSelectTitle selectIndex:(NSInteger)selectIndex unselectIndex:(NSInteger)unselectIndex;

#pragma mark - 标初始化
/**
 @param titleText 标文字
 @param index 在 LGFFreePT 中的位置下标
 @param style 配置用模型
 @return LGFFreePTTitle
 */
+ (instancetype)lgf_AllocTitle:(NSString *)titleText index:(NSInteger)index style:(LGFFreePTStyle *)style delegate:(id<LGFFreePTTitleDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
