//
//  UIFont+LGFFont.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIFont`.
 */
@interface UIFont (LGFFont) <NSCoding>

#pragma mark - Font Traits
///=============================================================================
/// @name Font Traits
///=============================================================================

@property (nonatomic, readonly) BOOL lgf_IsBold NS_AVAILABLE_IOS(7_0); ///< 字体是否粗体.
@property (nonatomic, readonly) BOOL lgf_IsItalic NS_AVAILABLE_IOS(7_0); ///< 字体是否是斜体.
@property (nonatomic, readonly) BOOL lgf_IsMonoSpace NS_AVAILABLE_IOS(7_0); ///< 字体是否是单声道空间.
@property (nonatomic, readonly) BOOL lgf_IsColorGlyphs NS_AVAILABLE_IOS(7_0); ///< 字体是否为彩色字形（如Emoji）.
@property (nonatomic, readonly) CGFloat lgf_FontWeight NS_AVAILABLE_IOS(7_0); ///< 字体权重从-1.0到1.0。 正常体重是0.0.

#pragma mark - 从接收器创建一个粗体字体。
/**
 @return 粗体字体，如果失败则为nil
 */
- (nullable UIFont *)lgf_FontWithBold NS_AVAILABLE_IOS(7_0);

#pragma mark - 从接收器创建一个斜体字体。
/**
 @return 斜体字体，如果失败则为nil
 */
- (nullable UIFont *)lgf_FontWithItalic NS_AVAILABLE_IOS(7_0);

#pragma mark - 从接收器创建一个粗体和斜体字体。
/**
 @return 粗体和斜体字体，如果失败则为nil
 */
- (nullable UIFont *)lgf_FontWithBoldItalic NS_AVAILABLE_IOS(7_0);

#pragma mark - 从接收器创建一个正常的（不粗体/斜体/ ...）字体。
/**
 @return 一个正常的字体，如果失败则为零。
 */
- (nullable UIFont *)lgf_FontWithNormal NS_AVAILABLE_IOS(7_0);

#pragma mark - Create font
///=============================================================================
/// @name 创建字体
///=============================================================================

#pragma mark - 为指定的CTFontRef创建并返回一个字体对象
/**
 @param CTFont CoreText字体
 */
+ (nullable UIFont *)lgf_FontWithCTFont:(CTFontRef)CTFont;

#pragma mark - 为指定的CGFontRef和size创建并返回一个字体对象
/**
 @param CGFont CoreGraphic字体
 @param size 字体大小
 */
+ (nullable UIFont *)lgf_FontWithCGFont:(CGFontRef)CGFont size:(CGFloat)size;

#pragma mark - 创建并返回CTFontRef对象 使用后需要调用CFRelease（）

- (nullable CTFontRef)lgf_CTFontRef CF_RETURNS_RETAINED;

#pragma mark - 创建并返回CGFontRef对象 使用后需要调用CFRelease（）

- (nullable CGFontRef)lgf_CGFontRef CF_RETURNS_RETAINED;


#pragma mark - Load and unload font
///=============================================================================
/// @name Load and unload font
///=============================================================================

#pragma mark - 从文件路径加载字体 支持格式：TTF, OTF 如果返回YES, 字体可以加载使用它PostScript名称:[UIFont fontWithName：...]
/**
 @param path 字体文件的完整路径
 */
+ (BOOL)lgf_LoadFontFromPath:(NSString *)path;

#pragma mark - 从文件路径中卸载字体
/**
 @param path 字体文件的完整路径
 */
+ (void)lgf_UnloadFontFromPath:(NSString *)path;

#pragma mark - 从数据加载字体 支持格式：TTF, OTF
/**
 @param data 字体数据
 @return UIFont对象如果加载成功，否则为零
 */
+ (nullable UIFont *)lgf_LoadFontFromData:(NSData *)data;

#pragma mark - 卸载由loadFontFromData：function加载的字体
/**
 @param font 由loadFontFromData:function加载的字体
 @return 如果成功则返回YES, 否则返回NO
 */
+ (BOOL)lgf_UnloadFontFromData:(UIFont *)font;


#pragma mark - Dump font data
///=============================================================================
/// @name 转储字体数据
///=============================================================================

#pragma mark - 序列化并返回字体数据
/**
 @param font 字体
 @return TTF中的数据，如果发生错误则返回nil
 */
+ (nullable NSData *)lgf_DataFromFont:(UIFont *)font;

#pragma mark - 序列化并返回字体数据
/**
 @param cgFont 字体
 @return TTF中的数据，如果发生错误则返回nil
 */
+ (nullable NSData *)lgf_DataFromCGFont:(CGFontRef)cgFont;

@end

NS_ASSUME_NONNULL_END
