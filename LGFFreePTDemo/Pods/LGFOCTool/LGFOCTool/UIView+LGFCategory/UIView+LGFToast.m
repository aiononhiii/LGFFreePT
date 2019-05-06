//
//  UIView+lgf_Toast.m
//  lgf_OCTool
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIView+LGFToast.h"
#import <objc/runtime.h>
#import "UIImage+GIF.h"

@implementation LGFToastStyle

lgf_ViewForM(LGFToastStyle);

- (instancetype)init {
    if (self = [super init]) {
        self.lgf_ToastImageName = @"";
        self.lgf_ToastMessage = @"";
        self.lgf_ToastPosition = lgf_ToastCenter;
        self.lgf_ToastImagePosition = lgf_ToastImageTop;
        self.lgf_ToastMessageFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];;
        self.lgf_ToastMessageTextColor = [UIColor whiteColor];
        self.lgf_ToastBackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        self.lgf_ToastCornerRadius = 10.0;
        self.lgf_DismissDuration = 0.0;
        self.lgf_Duration = 1.0;
        self.lgf_SuperEnabled = NO;
        self.lgf_BackBtnEnabled = YES;
        self.lgf_MessageImageSpacing = 5.0;
        self.lgf_ToastSpacing = 13.0;
        self.lgf_ToastImageSize = CGSizeMake(50.0, 50.0);
        self.lgf_MaxWidth = [UIScreen mainScreen].bounds.size.width * 0.8;
        self.lgf_MaxHeight = [UIScreen mainScreen].bounds.size.height * 0.8;
    }
    return self;
}

- (void)setLgf_ToastImageName:(NSString *)lgf_ToastImageName {
    _lgf_ToastImageName = lgf_ToastImageName;
    if (lgf_ToastImageName.length > 0) {
        self.lgf_ToastHaveIamge = YES;
    } else {
        self.lgf_ToastHaveIamge = NO;
    }
}

- (CGFloat)lgf_HeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:textFont,
                                 NSParagraphStyleAttributeName:paragraph};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    return ceil(textSize.height);
}

- (CGFloat)lgf_WidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:textFont,
                                 NSParagraphStyleAttributeName:paragraph};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    return ceil(textSize.width);
}

@end

@implementation LGFToastView

lgf_AllocOnceForM(LGFToastView);

- (UIImageView *)image {
    if (!_image) {
        _image = [[UIImageView alloc] init];
        [self addSubview:_image];
    }
    return _image;
}

- (UILabel *)message {
    if (!_message) {
        _message = [[UILabel alloc] init];
        [self addSubview:_message];
    }
    return _message;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setStyle:(LGFToastStyle *)style {
    _style = style;
    if (style.lgf_ToastHaveIamge) {
        UIImage *image = [UIImage imageNamed:style.lgf_ToastImageName];
        if (image) {
            [self.image setImage:image];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *path = [[NSBundle mainBundle] pathForResource:style.lgf_ToastImageName ofType:@"gif"];
                NSData *data = [NSData dataWithContentsOfFile:path];
                UIImage *image = [UIImage sd_animatedGIFWithData:data];
                [self.image setImage:image];
            });
        }
    } else {
        [self.image setImage:nil];
    }
    self.message.text = style.lgf_ToastMessage;
    self.message.font = style.lgf_ToastMessageFont;
    self.message.textColor = style.lgf_ToastMessageTextColor;
    self.message.numberOfLines = 0;
    self.layer.cornerRadius = style.lgf_ToastCornerRadius;
    self.backgroundColor = style.lgf_ToastBackColor;
    self.layer.borderColor = style.lgf_ToastBorderColor.CGColor;
    self.layer.borderWidth = style.lgf_ToastBorderWidth;
    self.alpha = 1.0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.style.lgf_ToastHaveIamge) {
        switch (self.style.lgf_ToastImagePosition) {
            case lgf_ToastImageTop:
                self.image.frame = CGRectMake((self.frame.size.width / 2) - (self.style.lgf_ToastImageSize.width / 2),
                                              self.style.lgf_ToastSpacing,
                                              self.style.lgf_ToastImageSize.width,
                                              self.style.lgf_ToastImageSize.height);
                self.message.frame = CGRectMake(self.style.lgf_ToastSpacing,
                                                self.style.lgf_ToastSpacing + self.style.lgf_ToastImageSize.height + self.style.lgf_MessageImageSpacing,
                                                self.frame.size.width - (self.style.lgf_ToastSpacing * 2),
                                                self.frame.size.height - (self.style.lgf_ToastSpacing * 2) - self.image.frame.size.height - self.style.lgf_MessageImageSpacing);
                break;
            case lgf_ToastImageBottom:
                self.image.frame = CGRectMake((self.frame.size.width / 2) - (self.style.lgf_ToastImageSize.width / 2),
                                              self.frame.size.height - self.style.lgf_ToastImageSize.height - self.style.lgf_ToastSpacing,
                                              self.style.lgf_ToastImageSize.width,
                                              self.style.lgf_ToastImageSize.height);
                self.message.frame = CGRectMake(self.style.lgf_ToastSpacing,
                                                self.style.lgf_ToastSpacing,
                                                self.frame.size.width - (self.style.lgf_ToastSpacing * 2),
                                                self.frame.size.height - (self.style.lgf_ToastSpacing * 2) - self.image.frame.size.height - self.style.lgf_MessageImageSpacing);
                break;
            case lgf_ToastImageLeft:
                self.image.frame = CGRectMake(self.style.lgf_ToastSpacing,
                                              (self.frame.size.height / 2) - (self.style.lgf_ToastImageSize.height / 2),
                                              self.style.lgf_ToastImageSize.width,
                                              self.style.lgf_ToastImageSize.height);
                self.message.frame = CGRectMake(self.style.lgf_ToastSpacing + self.image.frame.size.width + self.style.lgf_MessageImageSpacing,
                                                self.style.lgf_ToastSpacing,
                                                self.frame.size.width - (self.style.lgf_ToastSpacing * 2) - self.image.frame.size.width - self.style.lgf_MessageImageSpacing,
                                                self.frame.size.height - (self.style.lgf_ToastSpacing * 2));
                break;
            case lgf_ToastImageRight:
                self.image.frame = CGRectMake(self.frame.size.width - self.style.lgf_ToastImageSize.width - self.style.lgf_ToastSpacing,
                                              (self.frame.size.height / 2) - (self.style.lgf_ToastImageSize.height / 2),
                                              self.style.lgf_ToastImageSize.width,
                                              self.style.lgf_ToastImageSize.height);
                self.message.frame = CGRectMake(self.style.lgf_ToastSpacing,
                                                self.style.lgf_ToastSpacing,
                                                self.frame.size.width - (self.style.lgf_ToastSpacing * 2) - self.image.frame.size.width - self.style.lgf_MessageImageSpacing,
                                                self.frame.size.height - (self.style.lgf_ToastSpacing * 2));
                break;
            case lgf_ToastOnlyImage:
                self.image.frame = CGRectMake(self.style.lgf_MessageImageSpacing,
                                              self.style.lgf_MessageImageSpacing,
                                              self.style.lgf_ToastImageSize.width,
                                              self.style.lgf_ToastImageSize.height);
                self.message.frame = CGRectMake(0,
                                                0,
                                                0,
                                                0);
                break;
            default:
                break;
        }
    } else {
        self.message.frame = CGRectMake(self.style.lgf_ToastSpacing,  self.style.lgf_ToastSpacing, self.frame.size.width - (self.style.lgf_ToastSpacing * 2), self.frame.size.height - (self.style.lgf_ToastSpacing * 2));
    }
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end

@implementation UIView (lgf_Toast)

static char lgf_ToastViewKey;
static char lgf_ToastActivityKey;
static char lgf_ToastScreenMessageKey;

- (void)lgf_HideMessage:(void (^ __nullable)(void))completion {
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        btn.enabled = YES;
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.userInteractionEnabled = YES;
            if ([obj isKindOfClass:[LGFToastView class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
    lgf_HaveBlock(completion);
}

- (void)lgf_ShowMessage:(NSString *)message
             completion:(void (^ __nullable)(void))completion {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_ToastMessage = message;
    [self lgf_ShowMessageStyle:style animated:YES completion:completion];
}

- (void)lgf_ShowMessage:(NSString *)message
               animated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_ToastMessage = message;
    [self lgf_ShowMessageStyle:style animated:animated completion:completion];
}

- (void)lgf_ShowMessage:(NSString *)message
               duration:(CGFloat)duration
               animated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_ToastMessage = message;
    if (duration) style.lgf_Duration = duration;
    style.lgf_ToastMessage = message;
    [self lgf_ShowMessageStyle:style animated:animated completion:completion];
}

- (void)lgf_ShowMessage:(NSString *)message
            maxDuration:(BOOL)maxDuration
               animated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_ToastMessage = message;
    if (maxDuration) style.lgf_Duration = CGFLOAT_MAX;
    style.lgf_ToastMessage = message;
    [self lgf_ShowMessageStyle:style animated:animated completion:completion];
}

- (void)lgf_ShowMessageStyle:(LGFToastStyle *)style
                    animated:(BOOL)animated
                  completion:(void (^ __nullable)(void))completion {
    if (style.lgf_ToastMessage.length == 0 && style.lgf_ToastImagePosition != lgf_ToastOnlyImage && !(style.lgf_ToastImageName.length == 0)) {
        return;
    }
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        btn.enabled = style.lgf_SuperEnabled;
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.lgf_ViewName isEqualToString:@"LGFVIP"]) {
                obj.userInteractionEnabled = style.lgf_BackBtnEnabled;
            } else {
                obj.userInteractionEnabled = style.lgf_SuperEnabled;
            }
            if ([obj isKindOfClass:[LGFToastView class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
    
    // 动态加载 lgf_ToastView
    LGFToastView *toastView = objc_getAssociatedObject(self, &lgf_ToastViewKey);
    toastView.style = style;
    toastView = [LGFToastView lgf_Once];
    objc_setAssociatedObject(self, &lgf_ToastViewKey, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CGFloat lgf_ToastViewHeight = 0.0;
    CGFloat lgf_ToastViewWidth = 0.0;
    CGFloat lgf_ToastViewY = 0.0;
    CGFloat lgf_ToastViewX = 0.0;
    
    if (style.lgf_ToastImagePosition != lgf_ToastOnlyImage) {
        lgf_ToastViewHeight = [style lgf_HeightWithText:@"" font:style.lgf_ToastMessageFont width:style.lgf_MaxWidth];
        lgf_ToastViewWidth = [style lgf_WidthWithText:style.lgf_ToastMessage font:style.lgf_ToastMessageFont height:lgf_ToastViewHeight];
        if (lgf_ToastViewWidth >= style.lgf_MaxWidth) {
            CGFloat realHeight = [style lgf_HeightWithText:style.lgf_ToastMessage font:style.lgf_ToastMessageFont width:style.lgf_MaxWidth];
            if (lgf_ToastViewHeight < realHeight) {
                lgf_ToastViewHeight = MIN(realHeight, style.lgf_MaxHeight);
            }
        }
    }
    
    if (style.lgf_ToastHaveIamge) {
        switch (style.lgf_ToastImagePosition) {
            case lgf_ToastImageTop:
                lgf_ToastViewHeight += style.lgf_ToastImageSize.height + style.lgf_MessageImageSpacing;
                break;
            case lgf_ToastImageBottom:
                lgf_ToastViewHeight += style.lgf_ToastImageSize.height + style.lgf_MessageImageSpacing;
                break;
            case lgf_ToastImageLeft:
                lgf_ToastViewWidth += style.lgf_ToastImageSize.width + style.lgf_MessageImageSpacing;
                break;
            case lgf_ToastImageRight:
                lgf_ToastViewWidth += style.lgf_ToastImageSize.width + style.lgf_MessageImageSpacing;
                break;
            case lgf_ToastOnlyImage:
                lgf_ToastViewHeight += style.lgf_ToastImageSize.height + style.lgf_MessageImageSpacing * 2;
                lgf_ToastViewWidth += style.lgf_ToastImageSize.width + style.lgf_MessageImageSpacing * 2;
                break;
            default:
                break;
        }
    }
    
    switch (style.lgf_ToastPosition) {
        case lgf_ToastTop:
            lgf_ToastViewY = self.frame.size.height * 0.2;
            break;
        case lgf_ToastBottom:
            lgf_ToastViewY = self.frame.size.height * 0.8;
            break;
        case lgf_ToastCenter:
            lgf_ToastViewY = (self.frame.size.height / 2) - (lgf_ToastViewHeight / 2);
            break;
        default:
            break;
    }
    
    if (style.lgf_ToastImagePosition != lgf_ToastOnlyImage) {
        lgf_ToastViewWidth = MIN(lgf_ToastViewWidth, style.lgf_MaxWidth) + style.lgf_ToastSpacing * 2;
        lgf_ToastViewHeight = lgf_ToastViewHeight + style.lgf_ToastSpacing * 2;
    }
    
    lgf_ToastViewX = (self.frame.size.width / 2) - (lgf_ToastViewWidth / 2);
    
    toastView.frame = CGRectMake(lgf_ToastViewX, lgf_ToastViewY, lgf_ToastViewWidth, lgf_ToastViewHeight);
    toastView.style = style;
    [self addSubview:toastView];
    
    // 动画
    [NSObject cancelPreviousPerformRequestsWithTarget:toastView selector:@selector(dismiss) object:nil];
    [toastView performSelector:@selector(dismiss) withObject:nil afterDelay:style.lgf_Duration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((style.lgf_Duration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.userInteractionEnabled = YES;
        }];
        lgf_HaveBlock(completion);
    });
}

#pragma mark - 覆盖全view的遮罩文字

- (void)lgf_ShowScreenMessage:(NSString *)message fontSize:(CGFloat)fontSize cr:(CGFloat)cr {
    UILabel *screenMessage = (UILabel *)objc_getAssociatedObject(self, &lgf_ToastScreenMessageKey);
    [screenMessage removeFromSuperview];
    screenMessage = nil;
    if (!screenMessage) {
        screenMessage = [[UILabel alloc] initWithFrame:self.bounds];
        screenMessage.text = message;
        screenMessage.font = [UIFont boldSystemFontOfSize:fontSize];
        screenMessage.textAlignment = NSTextAlignmentCenter;
        screenMessage.textColor = [UIColor whiteColor];
        screenMessage.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    [self addSubview:screenMessage];
    objc_setAssociatedObject(self, &lgf_ToastScreenMessageKey, screenMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        btn.enabled = NO;
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.lgf_ViewName isEqualToString:@"LGFVIP"]) {
                obj.userInteractionEnabled = YES;
                [self bringSubviewToFront:obj];
            } else {
                obj.userInteractionEnabled = NO;
            }
        }];
    }
}

- (void)lgf_HideScreenMessage {
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        btn.enabled = YES;
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.userInteractionEnabled = YES;
        }];
    }
    UIView *activityBackView = (UIView *)objc_getAssociatedObject(self, &lgf_ToastScreenMessageKey);
    if (activityBackView) {
        [activityBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [activityBackView removeFromSuperview];
    }
}

#pragma mark - 菊花

- (void)lgf_ShowToastActivity:(UIEdgeInsets)Insets isClearBack:(BOOL)isClearBack cornerRadius:(CGFloat)cornerRadius style:(UIActivityIndicatorViewStyle)style {
    UIView *activityBackView = (UIView *)objc_getAssociatedObject(self, &lgf_ToastActivityKey);
    [activityBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [activityBackView removeFromSuperview];
    if (!activityBackView) {
        activityBackView = [[UIView alloc] init];
        if (cornerRadius > 0) {
            activityBackView.layer.cornerRadius = cornerRadius;
            activityBackView.layer.borderWidth = 0.5;
            activityBackView.layer.borderColor = lgf_HexColor(@"F0F0F0").CGColor;
        }
        activityBackView.alpha = 1.0;
        activityBackView.backgroundColor = isClearBack ? [UIColor clearColor] : [UIColor whiteColor];
    }
    [self addSubview:activityBackView];
    activityBackView.translatesAutoresizingMaskIntoConstraints = NO;
    objc_setAssociatedObject(self, &lgf_ToastActivityKey, activityBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:activityBackView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:Insets.right];
    [self addConstraint:rightConstraint];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:activityBackView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:Insets.left];
    [self addConstraint:leftConstraint];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:activityBackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:Insets.top];
    [self addConstraint:topConstraint];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:activityBackView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:Insets.bottom];
    [self addConstraint:bottomConstraint];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
    activityView.activityIndicatorViewStyle = style;
    [UIView animateWithDuration:0.1 animations:^{
        [activityView startAnimating];
    }];
    activityView.center = CGPointMake(activityBackView.bounds.size.width / 2, activityBackView.bounds.size.height / 2);
    [activityBackView addSubview:activityView];
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        btn.enabled = NO;
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.lgf_ViewName isEqualToString:@"LGFVIP"]) {
                obj.userInteractionEnabled = YES;
                [self bringSubviewToFront:obj];
            } else {
                obj.userInteractionEnabled = NO;
            }
        }];
    }
}

- (void)lgf_HideToastActivity {
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        btn.enabled = YES;
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.userInteractionEnabled = YES;
        }];
    }
    UIView *activityBackView = (UIView *)objc_getAssociatedObject(self, &lgf_ToastActivityKey);
    if (activityBackView) {
        [activityBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [activityBackView removeFromSuperview];
    }
}

@end

