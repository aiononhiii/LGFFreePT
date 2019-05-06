//
//  UIView+LGFExtension.h
//  LGFOCTool
//
//  Created by apple on 2017/5/7.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LGFExtension)

/**
 创建完整视图层次结构的快照映像.
 */
- (nullable UIImage *)lgf_SnapshotImage;

/**
 创建完整视图层次结构的快照映像。
   @讨论它比“snapshotImage”快，但可能导致屏幕更新(闪)。
   有关更多信息，请参阅 - [UIView drawViewHierarchyInRect：afterScreenUpdates：]
 */
- (nullable UIImage *)lgf_SnapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 创建完整视图层次结构的快照PDF.
 */
- (nullable NSData *)lgf_SnapshotPDF;

/**
 快捷方式设置view.layer阴影
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)lgf_SetLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 删除所有子视图.
 
 @warning 不要在视图的drawRect：方法内调用此方法.
 */
- (void)lgf_RemoveAllSubviews;

/**
 返回view的视图控制器（可能为nil）.
 */
@property (nullable, nonatomic, readonly) UIViewController *lgf_ViewController;

/**
 考虑到超视图和窗口，返回屏幕上的可见alpha.
 */
@property (nonatomic, readonly) CGFloat lgf_VisibleAlpha;

/**
 将一个点从接收者的坐标系转换为指定视图或窗口的点。
  
   @param point 在接收器的本地坐标系（边界）中指定的点。
   @param view  坐标系统点将被转换的视图或窗口。
                如果视图为零，则此方法将转换为窗口底座坐标。
   @return      将点转换为视图的坐标系。
 */
- (CGPoint)lgf_ConvertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 将给定视图或窗口的坐标系中的点转换为接收者的点。
  
   @param point 在本地坐标系统（边界）中指定的点。
   @param view  在其坐标系中带有点的视图或窗口。
                如果视图为零，则此方法将从窗口底座坐标转换而来。
   @return      将点转换为接收器的本地坐标系（边界）。
 */
- (CGPoint)lgf_ConvertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 将矩形从接收器的坐标系转换为另一个视图或窗口的矩形。
 
   @param rect  在接收器的本地坐标系（边界）中指定的矩形。
   @param view  作为转换操作目标的视图或窗口。 如果视图为零，则此方法将转换为窗口底座坐标。
   @return      转换后的矩形。
 */
- (CGRect)lgf_ConvertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 将矩形从另一个视图或窗口的坐标系转换为接收者的坐标系。
  
   @param rect  在本地坐标系统（边界）中指定的矩形。
   @param view  在其坐标系中使用直角坐标的视图或窗口。
                如果视图为零，则此方法将从窗口底座坐标转换而来。
   @return      转换后的矩形。
 */
- (CGRect)lgf_ConvertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;


@property (nonatomic, assign) CGFloat lgf_x;
@property (nonatomic, assign) CGFloat lgf_y;
@property (nonatomic, assign) CGFloat lgf_centerX;
@property (nonatomic, assign) CGFloat lgf_centerY;
@property (nonatomic, assign) CGFloat lgf_width;
@property (nonatomic, assign) CGFloat lgf_height;
@property (nonatomic, assign) CGSize lgf_size;
@property (nonatomic, assign) CGPoint lgf_origin;

@end

NS_ASSUME_NONNULL_END
