//
//  UIColor+LGFColor.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern void LGF_RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *l);

extern void LGF_HSL2RGB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void LGF_RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *v);

extern void LGF_HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void LGF_RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
                        CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k);

extern void LGF_CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
                        CGFloat *r, CGFloat *g, CGFloat *b);

extern void LGF_HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
                       CGFloat *hh, CGFloat *ss, CGFloat *ll);

extern void LGF_HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *hh, CGFloat *ss, CGFloat *bb);


/*
 使用十六进制字符串创建UIColor。
   示例：UIColorHex（0xF0F），UIColorHex（66ccff），UIColorHex（＃66CCFF88）
 
 有效格式：#RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
   `＃`或“0x”符号不是必需的。
 */
#ifndef lgf_UIColorHex
#define lgf_UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

/**
 提供一些`UIColor`来转换颜色
   RGB，HSB，HSL，CMYK和Hex。
 
  | 色彩空间| 含义|
  |-------------|----------------------------------------|
  | RGB * | 红色，绿色，蓝色|
  | HSB（HSV）* | 色相，饱和度，亮度（值）|
  | HSL | 色调，饱和度，亮度|
  | CMYK | 青色，洋红色，黄色，黑色|
  
   Apple使用RGB和HSB默认值。
  
   该类别中的所有值都是浮点数，范围为'0.0'到'1.0'。
   低于'0.0'的值被解释为'0.0'，
   而高于'1.0'的值被解释为'1.0'。
 */
@interface UIColor (LGFColor)

#pragma mark - 创建一个UIColor对象

#pragma mark - 使用指定的不透明度创建并返回一个颜色对象和HSL色彩空间分量值。
/**
   @param hue        HSL颜色空间中颜色对象的色相组件，
                     指定为从0.0到1.0的值。
 
   @param saturation HSL颜色空间中颜色对象的饱和度分量，
                     指定为从0.0到1.0的值。
   
   @param lightness  HSL颜色空间中颜色对象的亮度分量，
                     指定为从0.0到1.0的值。
   
   @param alpha      颜色对象的不透明度值，
                     指定为从0.0到1.0的值。
   
   @return           颜色对象, 由此表示的颜色信息
                     对象位于设备的RGB色彩空间中。
 */
+ (UIColor *)lgf_ColorWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
                lightness:(CGFloat)lightness
                    alpha:(CGFloat)alpha;

#pragma mark - 使用指定的不透明度创建并返回一个颜色对象和CMYK色彩空间分量值。
/**
   @param cyan    CMYK颜色空间中颜色对象的青色成分，
                  指定为从0.0到1.0的值。
  
   @param magenta CMYK颜色空间中颜色对象的洋红色成分，
                  指定为从0.0到1.0的值。
  
   @param yellow  CMYK颜色空间中颜色对象的黄色分量，
                  指定为从0.0到1.0的值。
  
   @param black   CMYK颜色空间中颜色对象的黑色分量，
                  指定为从0.0到1.0的值。
  
   @param alpha   颜色对象的不透明度值，
                  指定为从0.0到1.0的值。
  
   @return颜色对象。 由此表示的颜色信息
                  对象位于设备的RGB色彩空间中。
 */
+ (UIColor *)lgf_ColorWithCyan:(CGFloat)cyan
                   magenta:(CGFloat)magenta
                    yellow:(CGFloat)yellow
                     black:(CGFloat)black
                     alpha:(CGFloat)alpha;

#pragma mark - 使用十六进制RGB颜色值创建并返回一个颜色对象。
/**
   @param rgbValue rgb值，如0x66ccff。
   @return         颜色对象, 由此表示的颜色信息
                   对象位于设备的RGB色彩空间中。
 */
+ (UIColor *)lgf_ColorWithRGB:(uint32_t)rgbValue;

#pragma mark - 使用十六进制RGBA颜色值创建并返回一个颜色对象。
/**
   @param rgbaValue rgb值，如0x66ccffff。
   @return 颜色对象, 由此表示的颜色信息
                     对象位于设备的RGB色彩空间中。
 */
+ (UIColor *)lgf_ColorWithRGBA:(uint32_t)rgbaValue;

#pragma mark - 使用指定的不透明度和RGB十六进制值创建并返回一个颜色对象。
/**
   @param rgbValue  rgb值，如0x66CCFF。
   @param alpha     颜色对象的不透明度值，
                    指定为从0.0到1.0的值。
   @return 颜色对象, 由此表示的颜色信息
                    对象位于设备的RGB色彩空间中。
 */
+ (UIColor *)lgf_ColorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

#pragma mark - 从十六进制字符串创建并返回一个颜色对象。
/**
  @discussion：
   有效格式：#RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
   `＃`或“0x”符号不是必需的。
   如果没有alpha分量，alpha将被设置为1.0。
   当解析发生错误时，它将返回nil。
  
   例如：@“0xF0F”，@“66ccff”，@“＃66CCFF88”
  
   @param hexStr 新颜色的十六进制字符串值。
  
   @return 字符串中的UIColor对象，如果发生错误，则返回nil。
 */
+ (nullable UIColor *)lgf_ColorWithHexString:(NSString *)hexStr;
+ (nullable UIColor *)lgf_ColorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

#pragma mark - 通过添加新颜色创建并返回一个颜色对象。
/**
  @param add       添加的颜色
  @param blendMode 添加颜色混合模式
  @return 混合色
 */
- (UIColor *)lgf_ColorByAddColor:(UIColor *)add blendMode:(CGBlendMode)blendMode;

#pragma mark - 通过更改组件创建并返回一个颜色对象。
/**
  @param hueDelta        指定为值的色调变化增量
                           从-1.0到1.0。 0意味着没有变化。
  @param saturationDelta 指定为值的饱和度变化增量
                           从-1.0到1.0。 0意味着没有变化。
  @param brightnessDelta 指定为值的亮度变化增量
                           从-1.0到1.0。 0意味着没有变化。
  @param alphaDelta      指定为值的阿尔法变化增量
                           从-1.0到1.0。 0意味着没有变化。
 */
- (UIColor *)lgf_ColorByChangeHue:(CGFloat)hueDelta
                   saturation:(CGFloat)saturationDelta
                   brightness:(CGFloat)brightnessDelta
                        alpha:(CGFloat)alphaDelta;


#pragma mark - Get color's description
///=============================================================================
/// @name 获取颜色的描述
///=============================================================================

#pragma mark - 以十六进制格式返回rgb值。
/**
  @return RGB的十六进制值，如0x66ccff。
 */
- (uint32_t)lgf_RgbValue;

#pragma mark - 以十六进制格式返回rgba值。
/**
  @return RGBA的十六进制值，如0x66ccffff。
 */
- (uint32_t)lgf_RgbaValue;

#pragma mark - 以十六进制字符串（小写）返回颜色的RGB值。
/**
  如@“0066cc”。
  
  当颜色空间不是RGB时，它将返回nil
  
  @return 作为十六进制字符串的颜色值。
 */
- (nullable NSString *)lgf_HexString;

#pragma mark - 以十六进制字符串（小写）返回颜色的RGBA值。
/**
  如@“0066ccff”。
  
  当颜色空间不是RGBA时，它将返回nil
  
  @return作为十六进制字符串的颜色值。
 */
- (nullable NSString *)lgf_HexStringWithAlpha;


#pragma mark - 检索颜色信息

#pragma mark - 返回组成HSL颜色空间中颜色的组件。
/**
   @param hue         返回时，颜色对象的色相组件，
                      指定为介于0.0和1.0之间的值。
  
   @param saturation  返回时，颜色对象的饱和度分量，
                      指定为介于0.0和1.0之间的值。
  
   @param lightness   返回时，颜色对象的亮度分量，
                      指定为介于0.0和1.0之间的值。
  
   @param alpha       返回时，颜色对象的alpha分量，
                      指定为介于0.0和1.0之间的值。
  
   @return 如果颜色可以转换，则返回YES，否则返回NO。
 */
- (BOOL)lgf_GetHue:(CGFloat *)hue
    saturation:(CGFloat *)saturation
     lightness:(CGFloat *)lightness
         alpha:(CGFloat *)alpha;

#pragma mark - 返回组成CMYK颜色空间中颜色的组件。
/**
   @param cyan     返回时，彩色对象的青色部分，
                   指定为介于0.0和1.0之间的值。
  
   @param magenta  返回时，颜色对象的洋红色组件，
                   指定为介于0.0和1.0之间的值。
  
   @param yellow   返回时，颜色对象的黄色部分，
                   指定为介于0.0和1.0之间的值。
  
   @param black    返回时，颜色对象的黑色组件，
                   指定为介于0.0和1.0之间的值。
  
   @param alpha    返回时，颜色对象的alpha分量，
                   指定为介于0.0和1.0之间的值。
  
   @return 如果颜色可以转换，则返回YES，否则返回NO。
 */
- (BOOL)lgf_GetCyan:(CGFloat *)cyan
        magenta:(CGFloat *)magenta
         yellow:(CGFloat *)yellow
          black:(CGFloat *)black
          alpha:(CGFloat *)alpha;

#pragma mark - RGB颜色空间中颜色的红色分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Red;

#pragma mark - RGB颜色空间中颜色的绿色分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Green;

#pragma mark - RGB颜色空间中颜色的蓝色分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Blue;

#pragma mark - HSB颜色空间中的颜色色调分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Hue;

#pragma mark - HSB颜色空间中颜色的饱和度分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Saturation;

#pragma mark - HSB颜色空间中的颜色亮度分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Brightness;

#pragma mark - 颜色的alpha分量值。
/**
  这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat lgf_Alpha;

#pragma mark - 颜色的颜色空间模型。
@property (nonatomic, readonly) CGColorSpaceModel lgf_ColorSpaceModel;

#pragma mark - 可读的颜色空间字符串。
@property (nullable, nonatomic, readonly) NSString *lgf_ColorSpaceString;

@end

NS_ASSUME_NONNULL_END
