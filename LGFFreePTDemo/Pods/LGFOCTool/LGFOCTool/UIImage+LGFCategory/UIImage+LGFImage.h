//
//  UIImage+LGFImage.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LGFImage)

#pragma mark - 图像变暗
/**
 @param value 变暗指数 0.0 - 1.0
 @return 变暗后的图片
 */
- (UIImage *)lgf_ImageToDark:(float)value;

#pragma mark - 更具gif图片名字取得gif图片数组
/**
 @param gifNameInBoundle gif图片名字
 @return gif图片数组
 */
+ (NSArray *)lgf_ImagesWithGif:(NSString *)gifNameInBoundle;

#pragma mark - 获取图片类型字符串（png/gif...）
+ (NSString *)lgf_GetContentTypeWithImageData:(NSData *)data;

#pragma mark - 截图指定view成图片
/**
 @param view 要截图的 截图
 @return 图片
 */
+ (nullable UIImage *)lgf_ScreenshotWithView:(UIView *)view;

#pragma mark - 取图片某一点的颜色
/**
 @param point 某一点
 @return 颜色
 */
- (nullable UIColor *)lgf_ColorAtPoint:(CGPoint )point;

#pragma mark - 取某一像素的颜色
/**
 @param pixel 一像素
 @return 颜色
 */
- (nullable UIColor *)lgf_ColorAtPixel:(CGPoint)pixel;

#pragma mark - 返回该图片是否有透明度
/**
 @return 是否有透明度通道
 */
- (BOOL)lgf_HasAlphaChannel;

#pragma mark - 压缩上传图片到指定字节
/**
 @param image     压缩的图片
 @param maxLength 压缩后最大字节大小
 @return 压缩后图片的二进制
 */
+ (nullable NSData *)lgf_CompressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth;

#pragma mark - 获得指定size的图片
/**
 @param image   原始图片
 @param newSize 指定的size
 @return 调整后的图片
 */
+ (nullable UIImage *)lgf_ResizeImage:(UIImage *)image withNewSize:(CGSize)newSize;

#pragma mark - 通过指定图片最长边，获得等比例的图片size
/**
 @param image       原始图片
 @param imageLength 图片允许的最长宽度（高度）
 @return 获得等比例的size
 */
+ (CGSize)lgf_ScaleImage:(UIImage *)image withLength:(CGFloat)imageLength;

#pragma mark - 获取图片主色调
/**
 @param image 要获取主色调的图片
 @return 主色调
 */
+ (nullable UIColor *)lgf_MostColorWithImage:(UIImage*)image;

#pragma mark - 返回一个新的旋转图像（相对于中心）
/**
   @param radians 逆时针旋转弧度
   @param fitSize YES：新图片的大小被扩展到适合所有内容。
                    NO：图片的大小不会改变，内容可能会被剪裁。
 */
- (nullable UIImage *)lgf_ImageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

#pragma mark - 返回逆时针旋转四分之一圈（90°）的新图像 ⤺ 宽度和高度将被交换
- (nullable UIImage *)lgf_ImageByRotateLeft90;

#pragma mark - 返回顺时针旋转四分之一圈（90°）的新图像 ⤼ 宽度和高度将被交换
- (nullable UIImage *)lgf_ImageByRotateRight90;

#pragma mark - 返回旋转180°的新图像 ↻
- (nullable UIImage *)lgf_ImageByRotate180;

#pragma mark - 返回垂直翻转的图像 ⥯
- (nullable UIImage *)lgf_ImageByFlipVertical;

#pragma mark - 返回水平翻转的图像 ⇋
- (nullable UIImage *)lgf_ImageByFlipHorizontal;

#pragma mark - Image 效果
#pragma mark - 用给定颜色在alpha通道中对图像着色
/**
   @param color 颜色。
 */
- (nullable UIImage *)lgf_ImageByTintColor:(UIColor *)color;

#pragma mark - 返回灰度图像
- (nullable UIImage *)lgf_ImageByGrayscale;

#pragma mark - 对此图像应用模糊效果, 适合模糊任何内容
- (nullable UIImage *)lgf_ImageByBlurSoft;

#pragma mark - 对此图像应用模糊效果, 适用于模糊除纯白色以外的任何内容,（与iOS控制面板相同）
- (nullable UIImage *)lgf_ImageByBlurLight;

#pragma mark - 对此图像应用模糊效果, 适合显示黑色文本,（与iOS导航栏白色相同）
- (nullable UIImage *)lgf_ImageByBlurExtraLight;

#pragma mark - 对此图像应用模糊效果, 适合显示白色文本, （与iOS通知中心相同）
- (UIImage *)lgf_ImageByBlurDark:(CGFloat)Radius;

#pragma mark - 为此图像应用模糊和色调颜色
/**
   @param tintColor 色调的颜色。
 */
- (nullable UIImage *)lgf_ImageByBlurWithTint:(UIColor *)tintColor;

#pragma mark - 对此图像应用模糊, 色调和饱和度调整, 可选地在由@a maskImage指定的区域内
/**
  @param blurRadius     以点为单位的模糊半径，0表示没有模糊效果。
  
  @param tintColor      与之均匀混合的可选UIColor对象
                        模糊和饱和操作的结果。该
                        这种颜色的alpha通道决定了它的强度
                        色调是。零意味着没有色彩。
  
  @param tintBlendMode  @a tintColor混合模式。默认值是kCGBlendModeNormal（0）。
  
  @param saturation     1.0的值在结果图像中不会产生变化。
                        小于1.0的值会使得到的图像去饱和
                        而大于1.0的值则会产生相反的效果。
                        0表示灰度。
  
  @param maskImage      如果指定，@a inputImage只在区域中修改，
                        由此掩码定义。这必须是一个图像掩码或它
                        必须符合mask参数的要求
                        CGContextClipToMask。
  
  @return 有效的图像，或者如果发生错误，则返回nil（例如，无
                        足够的记忆）。
 */
- (nullable UIImage *)lgf_ImageByBlurRadius:(CGFloat)blurRadius
                                  tintColor:(nullable UIColor *)tintColor
                                   tintMode:(CGBlendMode)tintBlendMode
                                 saturation:(CGFloat)saturation
                                  maskImage:(nullable UIImage *)maskImage;
@end

NS_ASSUME_NONNULL_END

