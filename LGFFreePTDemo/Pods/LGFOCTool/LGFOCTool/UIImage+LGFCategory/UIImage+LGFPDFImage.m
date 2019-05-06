//
//  UIImage+LGFPDFImage.m
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIImage+LGFPDFImage.h"
#import <CoreText/CoreText.h>

@implementation UIImage (LGFPDFImage)

+ (NSCache *)cache{
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}

#pragma mark - PDF 转图片 设置 高
/**
 @param PDFNamed PDF 文件名
 @param height 高度设置
 @return 图片
 */

+ (UIImage *)lgf_ImageWithPDFNamed:(NSString *)PDFNamed forHeight:(CGFloat)height{
    return [self lgf_ImageWithPDFNamed:PDFNamed withTintColor:nil forHeight:height];
}

#pragma mark - PDF 转图片 设置 高 颜色
/**
 @param PDFNamed PDF 文件名
 @param tintColor 颜色设置
 @param height 高度设置
 @return 图片
 */
+ (UIImage *)lgf_ImageWithPDFNamed:(NSString *)PDFNamed withTintColor:(UIColor *)tintColor forHeight:(CGFloat)height{
    NSString *pdfFile = [[NSBundle mainBundle] pathForResource:PDFNamed ofType:@"pdf"];
    return [self lgf_ImageWithPDFFile:pdfFile withTintColor:tintColor forSize:CGSizeMake(MAXFLOAT, height)];
}

#pragma mark - PDF 转图片 设置 Size 颜色
/**
 @param PDFFile pdf 文件路径
 @param tintColor 颜色设置
 @param size Size设置
 @return 图片
 */
+ (UIImage *)lgf_ImageWithPDFFile:(NSString *)PDFFile withTintColor:(UIColor *)tintColor forSize:(CGSize)size{
    if(!PDFFile || CGSizeEqualToSize(size, CGSizeZero)){
        return nil;
    }
    
    NSString *identifier = [NSString stringWithFormat:@"%@%@%@%@", NSStringFromSelector(_cmd), PDFFile, tintColor, NSStringFromCGSize(size)];
    UIImage *image = [[self cache] objectForKey:identifier];
    if(image){
        return image;
    }
    
    NSURL *url = [NSURL fileURLWithPath:PDFFile];
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    if(!pdf){
        return nil;
    }
    
    CGPDFPageRef page1 = CGPDFDocumentGetPage(pdf, 1);
    CGRect mediaRect = CGPDFPageGetBoxRect(page1, kCGPDFCropBox);
    
    CGSize imageSize = mediaRect.size;
    if(imageSize.height < size.height && size.height != MAXFLOAT){
        imageSize.width = round(size.height/imageSize.height*imageSize.width);
        imageSize.height = size.height;
    }
    if(imageSize.width < size.width && size.width != MAXFLOAT){
        imageSize.height = round(size.width/imageSize.width*imageSize.height);
        imageSize.width = size.width;
    }
    
    if(imageSize.height > size.height){
        imageSize.width = round(size.height/imageSize.height*imageSize.width);
        imageSize.height = size.height;
    }
    if(imageSize.width > size.width){
        imageSize.height = round(size.width/imageSize.width*imageSize.height);
        imageSize.width = size.width;
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGFloat scale = MIN(imageSize.width/mediaRect.size.width, imageSize.height/mediaRect.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -imageSize.height);
    CGContextScaleCTM(context, scale, scale);
    CGContextDrawPDFPage(context, page1);
    CGPDFDocumentRelease(pdf);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(tintColor){
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -imageSize.height);
        CGContextClipToMask(context, (CGRect){.size=imageSize}, [image CGImage]);
        [tintColor setFill];
        CGContextFillRect(context, (CGRect){.size=imageSize});
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return image;
}

+ (UIImage *)lgf_IconWithFont:(UIFont *)font named:(NSString *)iconNamed withTintColor:(UIColor *)tintColor clipToBounds:(BOOL)clipToBounds forSize:(CGFloat)fontSize {
    NSString *identifier = [NSString stringWithFormat:@"%@%@%@%@%d%f", NSStringFromSelector(_cmd), font.fontName, tintColor, iconNamed, clipToBounds, fontSize];
    UIImage *image = [[self cache] objectForKey:identifier];
    if(image == nil){
        NSMutableAttributedString *ligature = [[NSMutableAttributedString alloc] initWithString:iconNamed];
        [ligature setAttributes:@{(NSString *)kCTLigatureAttributeName: @(2),
                                  (NSString *)kCTFontAttributeName: font}
                          range:NSMakeRange(0, [ligature length])];
        
        CGSize imageSize = [ligature size];
        imageSize.width = ceil(imageSize.width);
        imageSize.height = ceil(imageSize.height);
        if(!CGSizeEqualToSize(CGSizeZero, imageSize)){
            UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
            [ligature drawAtPoint:CGPointZero];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            if(tintColor){
                UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextScaleCTM(context, 1, -1);
                CGContextTranslateCTM(context, 0, -imageSize.height);
                CGContextClipToMask(context, (CGRect){.size=imageSize}, [image CGImage]);
                [tintColor setFill];
                CGContextFillRect(context, (CGRect){.size=imageSize});
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            if(clipToBounds && [image respondsToSelector:@selector(imageClippedToPixelBounds)]){
                image = [image performSelector:@selector(imageClippedToPixelBounds)];
            }
#pragma clang diagnostic pop
            
            [[self cache] setObject:image forKey:identifier];
        }
    }
    return image;
}

@end
