//
//  UIScreen+LGFScreen.h
//  LGFOCTool
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (LGFScreen)

#pragma mark - 主屏幕的比例
/**
   @return 屏幕的比例
 */
+ (CGFloat)lgf_ScreenScale;

#pragma mark - 返回当前设备方向的屏幕边界
/**
   @return 指示屏幕边界的矩形。
   @see boundsForOrientation：
 */
- (CGRect)lgf_CurrentBounds NS_EXTENSION_UNAVAILABLE_IOS("");

#pragma mark - 返回给定设备方向的屏幕边界
/**
   `UIScreen`的`bounds`方法总是返回的边界
   以纵向显示屏幕。
  
   @param orientation 获取屏幕边界的方向。
   @return 指示屏幕边界的矩形。
   @see currentBounds
 */
- (CGRect)lgf_BoundsForOrientation:(UIInterfaceOrientation)orientation;

#pragma mark - 屏幕的像素实际尺寸（宽度始终小于高度）
/**
   该值在未知设备或模拟器中可能不太准确。
   例如（768,1024）
 */
@property (nonatomic, readonly) CGSize lgf_SizeInPixel;

#pragma mark - 屏幕的PPI
/**
   该值在未知设备或模拟器中可能不太准确。
   默认值是96。
 */
@property (nonatomic, readonly) CGFloat lgf_PixelsPerInch;

@end

NS_ASSUME_NONNULL_END
