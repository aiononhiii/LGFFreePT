//
//  LGFFreePTMethod.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFFreePTMethod : NSObject
#pragma mark - 获取文字size
+ (CGSize)lgf_SizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

#pragma mark - UIColorRGB 转颜色数组
+ (NSArray *)lgf_GetColorRGBA:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
