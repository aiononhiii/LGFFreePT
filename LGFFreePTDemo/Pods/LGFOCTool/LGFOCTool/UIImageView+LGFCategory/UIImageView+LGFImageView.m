//
//  UIImageView+LGFImageView.m
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIImageView+LGFImageView.h"

static const char *lgf_NetImageNameKey = "lgf_NetImageNameKey";

@implementation UIImageView (LGFImageView)

@dynamic lgf_NetImageName;

#pragma mark - 控件唯一名字(通常用于确定某一个特殊的view)

- (NSString *)lgf_NetImageName {
    return objc_getAssociatedObject(self, &lgf_NetImageNameKey);
}

- (void)setLgf_NetImageName:(NSString *)lgf_NetImageName {
    objc_setAssociatedObject(self, &lgf_NetImageNameKey, lgf_NetImageName, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 创建imageview动画
/**
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 */
- (void)lgf_AnimationWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration {
    if (imageArray && !([imageArray count] > 0)) {
        return;
    }
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [images addObject:image];
    }
    [self setImage:[images objectAtIndex:0]];
    [self setAnimationImages:images];
    [self setAnimationDuration:duration];
    [self setAnimationRepeatCount:0];
}

#pragma mark - 添加可伸缩图片
- (void)lgf_SetImageWithStretchableImage:(UIImage*)image {
    self.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

#pragma mark - 给 ImageView 添加图片的同时 在某个区域添加 水印
/**
 @param image 图片
 @param waterMark 水印
 @param rect 水印添加区域
 */
- (void)lgf_SetImage:(UIImage *)image withWaterMark:(UIImage *)waterMark inRect:(CGRect)rect {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    }
    //原图
    [image drawInRect:self.bounds];
    //水印图
    [waterMark drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

#pragma mark - 给 ImageView 添加图片的同时 在某个区域添加 文字水印
/**
 @param image 图片
 @param waterMarkString 水印文字
 @param rect 水印添加区域
 @param color 文字颜色
 @param font 文字字体
 */
- (void)lgf_SetImage:(UIImage *)image withStringWaterMark:(NSString *)waterMarkString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
    //原图
    [image drawInRect:self.bounds];
    //文字颜色
    [color set];
    //水印文字
    if ([waterMarkString respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        [waterMarkString drawInRect:rect withAttributes:@{NSFontAttributeName:font}];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [waterMarkString drawInRect:rect withFont:font];
#pragma clang diagnostic pop
    }
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

#pragma mark - 给 ImageView 添加图片的同时 在某个点添加 文字水印
/**
 @param image 图片
 @param waterMarkString 水印文字
 @param point 水印添加点
 @param color 文字颜色
 @param font 文字字体
 */
- (void)lgf_SetImage:(UIImage *)image withWaterMarkString:(NSString *)waterMarkString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    }
    //原图
    [image drawInRect:self.bounds];
    //文字颜色
    [color set];
    //水印文字
    if ([waterMarkString respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        [waterMarkString drawAtPoint:point withAttributes:@{NSFontAttributeName:font}];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [waterMarkString drawAtPoint:point withFont:font];
#pragma clang diagnostic pop
    }
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newPic;
}

@end
