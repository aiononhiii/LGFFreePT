//
//  UIView+LGFGSView.m
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIView+LGFGSView.h"
#import <objc/runtime.h>
#import "LGFOCTool.h"

static const char *lgf_ViewNameKey = "lgf_ViewNameKey";
static const char *lgf_CornerRadiusKey = "lgf_CornerRadiusKey";
static const char *lgf_BorderColorKey = "lgf_BorderColorKey";
static const char *lgf_BorderWidthKey = "lgf_BorderWidthKey";
static const char *lgf_ShadowColorKey = "lgf_ShadowColorKey";
static const char *lgf_ShadowRadiusKey = "lgf_ShadowRadiusKey";
static const char *lgf_ShadowOffsetKey = "lgf_ShadowOffsetKey";
static const char *lgf_ShadowOpacityKey = "lgf_ShadowOpacityKey";
static const char *lgf_IsRandomBackColorKey = "lgf_IsRandomBackColorKey";
static const char *lgf_GFromColorKey = "lgf_GFromColorKey";
static const char *lgf_GToColorKey = "lgf_GToColorKey";
static const char *lgf_GWidthKey = "lgf_GWidthKey";
static const char *lgf_GHeightKey = "lgf_GHeightKey";
static const char *lgf_GStartPointKey = "lgf_GStartPointKey";
static const char *lgf_GEndPointKey = "lgf_GEndPointKey";

@implementation UIView (LGFGSView)

@dynamic lgf_ViewName;
@dynamic lgf_CornerRadius;
@dynamic lgf_BorderColor;
@dynamic lgf_BorderWidth;
@dynamic lgf_ShadowColor;
@dynamic lgf_ShadowRadius;
@dynamic lgf_ShadowOffset;
@dynamic lgf_ShadowOpacity;
@dynamic lgf_IsRandomBackColor;
@dynamic lgf_GFromColor;
@dynamic lgf_GToColor;
@dynamic lgf_GWidth;
@dynamic lgf_GHeight;
@dynamic lgf_GStartPoint;
@dynamic lgf_GEndPoint;

#pragma mark - 控件唯一名字(通常用于确定某一个特殊的view)

- (NSString *)lgf_ViewName {
    return objc_getAssociatedObject(self, &lgf_ViewNameKey);
}

- (void)setLgf_ViewName:(NSString *)lgf_ViewName {
    objc_setAssociatedObject(self, &lgf_ViewNameKey, lgf_ViewName, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 圆角

- (CGFloat)lgf_CornerRadius {
    return [objc_getAssociatedObject(self, &lgf_CornerRadiusKey) floatValue];
}

- (void)setLgf_CornerRadius:(CGFloat)lgf_CornerRadius {
    objc_setAssociatedObject(self, &lgf_CornerRadiusKey, [NSNumber numberWithFloat:lgf_CornerRadius], OBJC_ASSOCIATION_ASSIGN);
    self.layer.cornerRadius = lgf_CornerRadius;
}

#pragma mark - 边框颜色

- (UIColor *)lgf_BorderColor {
    return objc_getAssociatedObject(self, lgf_BorderColorKey);
}

- (void)setLgf_BorderColor:(UIColor *)lgf_BorderColor {
    objc_setAssociatedObject(self, &lgf_BorderColorKey, lgf_BorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = lgf_BorderColor.CGColor;
}

#pragma mark - 边框宽度

- (CGFloat)lgf_BorderWidth {
    return [objc_getAssociatedObject(self, &lgf_BorderWidthKey) floatValue];
}

- (void)setLgf_BorderWidth:(CGFloat)lgf_BorderWidth {
    objc_setAssociatedObject(self, &lgf_BorderWidthKey, [NSNumber numberWithFloat:lgf_BorderWidth], OBJC_ASSOCIATION_ASSIGN);
    self.layer.borderWidth = lgf_BorderWidth;
}

#pragma mark - 阴影颜色

- (UIColor *)lgf_ShadowColor {
    return objc_getAssociatedObject(self, &lgf_ShadowColorKey);
}

- (void)setLgf_ShadowColor:(UIColor *)lgf_ShadowColor {
    objc_setAssociatedObject(self, &lgf_ShadowColorKey, lgf_ShadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.shadowColor = lgf_ShadowColor.CGColor;
}

#pragma mark - 阴影圆角

- (CGFloat)lgf_ShadowRadius {
    return [objc_getAssociatedObject(self, &lgf_ShadowRadiusKey) floatValue];
}

- (void)setLgf_ShadowRadius:(CGFloat)lgf_ShadowRadius {
    objc_setAssociatedObject(self, &lgf_ShadowRadiusKey, [NSNumber numberWithFloat:lgf_ShadowRadius], OBJC_ASSOCIATION_ASSIGN);
    self.layer.shadowRadius = lgf_ShadowRadius;
}

#pragma mark - 阴影偏移量

- (CGSize)lgf_ShadowOffset {
    return [objc_getAssociatedObject(self, &lgf_ShadowOffsetKey) CGSizeValue];
}

- (void)setLgf_ShadowOffset:(CGSize)lgf_ShadowOffset {
    objc_setAssociatedObject(self, &lgf_ShadowOffsetKey, [NSValue valueWithCGSize:lgf_ShadowOffset], OBJC_ASSOCIATION_ASSIGN);
    self.layer.shadowOffset = lgf_ShadowOffset;
}

#pragma mark - 阴影透明度

- (float)lgf_ShadowOpacity {
    return [objc_getAssociatedObject(self, &lgf_ShadowOpacityKey) floatValue];
}

- (void)setLgf_ShadowOpacity:(float)lgf_ShadowOpacity {
    objc_setAssociatedObject(self, &lgf_ShadowOpacityKey, [NSNumber numberWithFloat:lgf_ShadowOpacity], OBJC_ASSOCIATION_ASSIGN);
    self.layer.shadowOpacity = lgf_ShadowOpacity;
}

#pragma mark - 是否随机背景色 通常用于调试UI

- (BOOL)lgf_IsRandomBackColor {
    return [objc_getAssociatedObject(self, &lgf_IsRandomBackColorKey) boolValue];
}

- (void)setLgf_IsRandomBackColor:(BOOL)lgf_IsRandomBackColor {
    objc_setAssociatedObject(self, &lgf_IsRandomBackColorKey, [NSNumber numberWithBool:lgf_IsRandomBackColor], OBJC_ASSOCIATION_ASSIGN);
    if (lgf_IsRandomBackColor) {
        self.backgroundColor = lgf_RandomColor;
    }
}

#pragma mark - 是否使用渐变背景色

- (UIColor *)lgf_GFromColor {
    return objc_getAssociatedObject(self, &lgf_GFromColorKey);
}

- (void)setLgf_GFromColor:(UIColor *)lgf_GFromColor {
    objc_setAssociatedObject(self, &lgf_GFromColorKey, lgf_GFromColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self goGradient];
}

- (UIColor *)lgf_GToColor {
    return objc_getAssociatedObject(self, &lgf_GToColorKey);
}

- (void)setLgf_GToColor:(UIColor *)lgf_GToColor {
    objc_setAssociatedObject(self, &lgf_GToColorKey, lgf_GToColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self goGradient];
}

- (CGFloat)lgf_GWidth {
    return [objc_getAssociatedObject(self, &lgf_GWidthKey) floatValue];
}

- (void)setLgf_GWidth:(CGFloat)lgf_GWidth {
    objc_setAssociatedObject(self, &lgf_GWidthKey, [NSNumber numberWithFloat:lgf_GWidth], OBJC_ASSOCIATION_ASSIGN);
    [self goGradient];
}

- (CGFloat)lgf_GHeight {
    return [objc_getAssociatedObject(self, &lgf_GHeightKey) floatValue];
}

- (void)setLgf_GHeight:(CGFloat)lgf_GHeight {
    objc_setAssociatedObject(self, &lgf_GHeightKey, [NSNumber numberWithFloat:lgf_GHeight], OBJC_ASSOCIATION_ASSIGN);
    [self goGradient];
}

- (void)goGradient {
    if (self.lgf_GWidth && self.lgf_GToColor && self.lgf_GFromColor) {
        self.backgroundColor = [UIColor lgf_GradientFromColor:self.lgf_GFromColor toColor:self.lgf_GToColor width:self.lgf_GWidth == 888 ? self.lgf_width : self.lgf_GWidth];
    } else if (self.lgf_GHeight && self.lgf_GToColor && self.lgf_GFromColor) {
        self.backgroundColor = [UIColor lgf_GradientFromColor:self.lgf_GFromColor toColor:self.lgf_GToColor height:self.lgf_GHeight == 888 ? self.lgf_height : self.lgf_GHeight];
    }
}

- (CGPoint)lgf_GStartPoint {
    return [objc_getAssociatedObject(self, &lgf_GStartPointKey) CGPointValue];
}

- (void)setLgf_GStartPoint:(CGPoint)lgf_GStartPoint {
    objc_setAssociatedObject(self, &lgf_GStartPointKey, [NSValue valueWithCGPoint:lgf_GStartPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)lgf_GEndPoint {
    return [objc_getAssociatedObject(self, &lgf_GEndPointKey) CGPointValue];
}

- (void)setLgf_GEndPoint:(CGPoint)lgf_GEndPoint {
    objc_setAssociatedObject(self, &lgf_GEndPointKey, [NSValue valueWithCGPoint:lgf_GEndPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)changeAlpha{
    if ((self.lgf_GStartPoint.x && self.lgf_GEndPoint.x) || (self.lgf_GStartPoint.y && self.lgf_GEndPoint.y)) {
        CAGradientLayer *gradLayer = [CAGradientLayer layer];
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithWhite:0 alpha:0] CGColor],
                           (id)[[UIColor colorWithWhite:0 alpha:0.5] CGColor],
                           (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                           nil];
        [gradLayer setColors:colors];
        [gradLayer setStartPoint:self.lgf_GStartPoint];
        [gradLayer setEndPoint:self.lgf_GEndPoint];
        [gradLayer setFrame:self.bounds];
        [self.layer setMask:gradLayer];
    }
}

- (void)lgf_LayoutSubviews {
    [self goGradient];
    [self changeAlpha];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 如果是实例方法:
        Class class = [self class];
        // 如果是类方法
        // Class class = object_getClass((id)self);
        
        // 替换 viewDidLoad
        SEL layoutSubviews = @selector(layoutSubviews);
        SEL lgf_LayoutSubviews = @selector(lgf_LayoutSubviews);
        [class lgf_SwizzleMethod:layoutSubviews withMethod:lgf_LayoutSubviews];
    });
}

@end

