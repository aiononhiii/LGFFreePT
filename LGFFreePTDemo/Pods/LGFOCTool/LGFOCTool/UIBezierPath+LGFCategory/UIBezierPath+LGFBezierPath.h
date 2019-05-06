//
//  UIBezierPath+LGFBezierPath.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIBezierPath`.
 */
@interface UIBezierPath (LGFBezierPath)

#pragma mark - 创建并返回一个用文本字形初始化的新UIBezierPath对象, 从指定的字体生成
/**
   @discussion 它不支持苹果表情符号 如果你想获得表情符号图片，请尝试
   在'UIImage（YYAdd）`中使用[UIImage imageWithEmoji：size：]
   @param text 生成字形路径的文本
   @param font 生成字形路径的字体
  
   @return 包含文本和字体的新路径对象，如果发生错误，则返回nil。
 */
+ (nullable UIBezierPath *)lgf_BezierPathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
