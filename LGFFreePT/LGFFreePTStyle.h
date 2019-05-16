//
//  LGFFreePTStyle.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#undef LGFPTBundle
#define LGFPTBundle [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"LGFFreePT" ofType:@"bundle"]] ?: [NSBundle mainBundle]
#undef LGFPTRGB
#define LGFPTRGB(A,B,C,D) [UIColor colorWithRed:A/255.0f green:B/255.0f blue:C/255.0f alpha:D]
#undef LGFPTHexColor
#define LGFPTHexColor(hexStr) [UIColor lgf_ColorWithHexString:hexStr]
#undef LGFPTLog
#ifdef DEBUG
#define LGFPTLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define LGFPTLog(FORMAT, ...) nil
#endif
#ifndef LGFPTWeak
#if DEBUG
#if __has_feature(objc_arc)
#define LGFPTWeak(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define LGFPTWeak(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define LGFPTWeak(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define LGFPTWeak(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif
#ifndef LGFPTStrong
#if DEBUG
#if __has_feature(objc_arc)
#define LGFPTStrong(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define LGFPTStrong(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define LGFPTStrong(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define LGFPTStrong(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, lgf_FreePageViewAnimationType) {
    lgf_PageViewAnimationDefult,// 默认分页动画
    lgf_PageViewAnimationTopToBottom,// 从上往下进入的分页动画
    lgf_PageViewAnimationSmallToBig,// 从小到大进入的分页动画
    lgf_PageViewAnimationNone,// 没有分页动画
};

typedef NS_ENUM(NSUInteger, lgf_FreePageLineAnimationType) {
    lgf_PageLineAnimationDefult,// title 底部线平滑改变大小
    // 后续推出下面的 仿爱奇艺底部线动画效果 现暂时不可用 请勿设置
    lgf_PageLineAnimationSmallToBig,// title 底部线先右边伸出变宽致 title 和下一个 title 的总宽度, 再左边收回恢复到下一个 title 的宽度
    lgf_PageLineAnimationHideShow,// 渐隐效果， title 底部线隐藏，再在下一个 title 的底部出现
    lgf_PageLineAnimationTortoiseDown,// 乌龟的头效果， title 底部线向下隐藏，再在下一个 title 的底部向上出现
    lgf_PageLineAnimationTortoiseUp,// 乌龟的头效果， title 底部线向上隐藏，再在下一个 title 的底部向下出现
    lgf_PageLineAnimationCustomize,// 我想自定义这个效果，系统将返回你或许需要的值（selectX，selectWidth，unSelectX，unSelectWidth等等），用这些值来制造你自己想要的 line 动画
};

typedef NS_ENUM(NSUInteger, lgf_FreeTitleScrollFollowType) {
    lgf_TitleScrollFollowDefult,// 在可滚动的情况下, 选中 title 默认滚动到 lgf_PVTitleView 中间
    // 后续推出下面的 仿腾讯新闻, 天天快报选中 title 滚动效果 现暂时不可用 请勿设置
    lgf_TitleScrollFollowLeftRight,// 向左滚动选中 title 永远出现在最右边可见位置, 反之向右滚动选中 title 永远出现在最左边可见位置（此效果不会像上面的效果那样滚到中间）(模仿腾讯新闻)
};

typedef NS_ENUM(NSUInteger, lgf_FreeTitleLineWidthType) {
    lgf_EqualTitleSTR,// 宽度等于字体宽度
    lgf_EqualTitleSTRAndImage,// 宽度等于字体宽度 + 图 title 宽度
    lgf_EqualTitle,// 宽度等于 title view宽度
    lgf_FixedWith,// 宽度等于固定宽度
};

@interface LGFFreePTStyle : NSObject

// 初始化
+ (instancetype)lgf;

// 开启 UI 调试模式（自定义 line 动画时可打开）
@property (assign, nonatomic) BOOL lgf_StartDebug;

//------------------- 数据源设置
// title 数组
@property (copy, nonatomic) NSArray *lgf_Titles;

//------------------- 主 lgf_PVTitleView
// lgf_PVTitleView
@property (weak, nonatomic) UIScrollView *lgf_PVTitleView;
// lgf_PVTitleView 父视图背景色
@property (strong, nonatomic) UIColor *lgf_PVTitleViewBackgroundColor;
// 主 lgf_PVTitleView 在父控件上的frame 默认等于父控件
@property (assign, nonatomic) CGRect lgf_PVTitleViewFrame;

//------------------- 分页控件是否带分页动画
@property (assign, nonatomic) lgf_FreePageViewAnimationType lgf_PVAnimationType;

//------------------- 整体序列设置
// 当所有 title 总宽度加起来小于 lgf_PVTitleView 宽度时 是否居中显示 默认 NO - 不居中(从左边开始显示)
@property (assign, nonatomic) BOOL lgf_IsTitleCenter;
// 选中 title 滚动类型 默认 LGFTitleScrollFollowDefult
@property (assign, nonatomic) lgf_FreeTitleScrollFollowType lgf_TitleScrollFollowType;
// page左右间距 默认 0.0
@property (assign, nonatomic) CGFloat lgf_PageLeftRightSpace;

//-------------------  title 设置
// 是否支持副 title
@property (assign, nonatomic) BOOL lgf_IsDoubleTitle;
// title 固定宽度 默认等于 0.0 如果此属性大于 0.0 那么 title 宽度将为固定值
// 如果设置此项（lgf_TitleFixedWidth） LGFTitleLineWidthType 将只支持 FixedWith 固定底部线宽度
@property (assign, nonatomic) CGFloat lgf_TitleFixedWidth;
// 选中 title 放大缩小倍数 默认 1.0(不放大缩小)
@property (assign, nonatomic) CGFloat lgf_TitleTransformSX;
// 选中 title 字体颜色 默认 blackColor 黑色 (对应 lgf_TitleUnSelectColor 两个颜色一样则取消渐变效果)
@property (strong, nonatomic) UIColor *lgf_TitleSelectColor;
// 未选中 title 字体颜色 默认 lightGrayColor 淡灰色 (对应 lgf_TitleSelectColor 两个颜色一样则取消渐变效果)
@property (strong, nonatomic) UIColor *lgf_UnTitleSelectColor;
// title 选中字体 默认 [UIFont systemFontOfSize:14]
@property (strong, nonatomic) UIFont *lgf_TitleSelectFont;
// title 未选中字体 默认 和选中字体一样
@property (strong, nonatomic) UIFont *lgf_UnTitleSelectFont;
// 选中主 title 放大缩小倍数 默认 1.0(不放大缩小)
@property (assign, nonatomic) CGFloat lgf_MainTitleTransformSX;
// 选中主 title 上下偏移数 默认 0.0(不上下偏移)
@property (assign, nonatomic) CGFloat lgf_MainTitleTransformTY;
// 选中主 title 左右偏移数 默认 0.0(不左右偏移)
@property (assign, nonatomic) CGFloat lgf_MainTitleTransformTX;
// 副 title 默认和 title 一样
@property (strong, nonatomic) UIColor *lgf_SubTitleSelectColor;
@property (strong, nonatomic) UIColor *lgf_UnSubTitleSelectColor;
@property (strong, nonatomic) UIFont *lgf_SubTitleSelectFont;
@property (strong, nonatomic) UIFont *lgf_UnSubTitleSelectFont;
// 副 title 和 主 title 的距离
@property (assign, nonatomic) CGFloat lgf_SubTitleTopSpace;
// 选中副 title 放大缩小倍数 默认 1.0(不放大缩小)
@property (assign, nonatomic) CGFloat lgf_SubTitleTransformSX;
// 选中副 title 上下偏移数 默认 0.0(不上下偏移)
@property (assign, nonatomic) CGFloat lgf_SubTitleTransformTY;
// 选中副 title 左右偏移数 默认 0.0(不左右偏移)
@property (assign, nonatomic) CGFloat lgf_SubTitleTransformTX;
// line 是否对准 副 title
@property (assign, nonatomic) BOOL lgf_IsLineAlignSubTitle;
// title 是否有滑动动画 默认 YES 有动画
@property (assign, nonatomic) BOOL lgf_TitleHaveAnimation;
// title 左右间距 默认 0.0
@property (assign, nonatomic) CGFloat lgf_TitleLeftRightSpace;
// title 背景色
@property (strong, nonatomic) UIColor *lgf_TitleBackgroundColor;
// title 边框颜色
@property (strong, nonatomic) UIColor *lgf_TitleBorderColor;
// title 边框宽度
@property (assign, nonatomic) CGFloat lgf_TitleBorderWidth;
// title 圆角
@property (assign, nonatomic) CGFloat lgf_TitleCornerRadius;
// 点击 title 移动动画时间 默认 0.2
@property (assign, nonatomic) CGFloat lgf_TitleClickAnimationDuration;
// 点击 title 后移动 title 居中动画时间 默认 0.2
@property (assign, nonatomic) CGFloat lgf_TitleScrollToTheMiddleAnimationDuration;
//------------------- 特殊 title 设置
// 要替换的特殊 title 数组（数组中元素 view 的 lgf_FreePTSpecialTitleArray（值格式：@"0/80"） 字符串属性转化为数组后 数组的 firstObject（0） 即为要替换 title 的 index, 数组的 lastObject（80） 即为要替换 title 的自定义宽度）（记住这只是替换，因此原数据源支撑 UI 展示的数据必须存在，可设置为空字符串）
@property (nonatomic, copy) NSArray <UIView *> *lgf_FreePTSpecialTitleArray;

//-------------------  title 图片设置
// 图片Bundle 如果图片不在本控件bundel里请设置
@property (strong, nonatomic) NSBundle *lgf_TitleImageBundel;
// lgf_SelectImageNames 和 lgf_SameSelectImageName 设置一个就行 如果都设置了默认取 lgf_SameSelectImageName
// 设置不同图 title 数组（必须和titles数组count保持一致,如果某一个 title 不想设置图 title 名字传空即可）
// 选中图 title 数组和未选中图 title 数组如果只传了其中一个,将没有选中效果
@property (strong, nonatomic) NSMutableArray *lgf_SelectImageNames;
@property (strong, nonatomic) NSMutableArray *lgf_UnSelectImageNames;
// 设置所有图 title 为相同
@property (copy, nonatomic) NSString *lgf_SameSelectImageName;
@property (copy, nonatomic) NSString *lgf_SameUnSelectImageName;

// 以下属性只要有值，对应imageview就会显示出来
// 顶部 title 图片与 title 的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_TopImageSpace;
// 顶部 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
@property (assign, nonatomic) CGFloat lgf_TopImageWidth;
// 顶部 title 图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_TopImageHeight;
// 底部 title 图片与 title 的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_BottomImageSpace;
// 底部 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
@property (assign, nonatomic) CGFloat lgf_BottomImageWidth;
// 底部 title 图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_BottomImageHeight;
// 左边 title 图片与 title 的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_LeftImageSpace;
// 左边 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
@property (assign, nonatomic) CGFloat lgf_LeftImageWidth;
// 左边 title 图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_LeftImageHeight;
// 右边 title 图片与 title 的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_RightImageSpace;
// 右边 title 图片宽度 默认等于设置的高度 最大不超过 title view高度
@property (assign, nonatomic) CGFloat lgf_RightImageWidth;
// 右边 title 图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_RightImageHeight;

//-------------------  title 底部线设置
// 是否显示 title 底部滚动线 默认 YES 显示
@property (assign, nonatomic) BOOL lgf_IsShowLine;
// title 底部线圆角弧度 默认 0 没有弧度
@property (assign, nonatomic) CGFloat lgf_LineCornerRadius;
// title 背景图片 默认 无图
@property (strong, nonatomic) UIImage *_Nullable lgf_LineBackImage;
// title 底部滚动线 颜色 默认 blueColor
@property (strong, nonatomic) UIColor *lgf_LineColor;
// title 底部滚动线 透明度 默认 1.0 - 不透明
@property (assign, nonatomic) CGFloat lgf_LineAlpha;
// title 底部滚动线 动画宽度设置 默认宽度等于 title 字体宽度 - EqualTitleSTR
@property (assign, nonatomic) lgf_FreeTitleLineWidthType lgf_LineWidthType;
// title 底部滚动线 宽度 默认 0 - 设置 LGFTitleLineType 固定宽度(FixedWith)时有效
@property (assign, nonatomic) CGFloat lgf_LineWidth;
// title 底部滚动线 高度 默认 1.0 (line_height最大高度为 LGFFreePT 的高度)
@property (assign, nonatomic) CGFloat lgf_LineHeight;
// title 底部滚动线相对于底部位置 默认 0 - 贴于底部
@property (assign, nonatomic) CGFloat lgf_LineBottom;
// title 底部滚动线滑动动画 默认 LGFPageLineAnimationDefult 有跟随动画
@property (assign, nonatomic) lgf_FreePageLineAnimationType lgf_LineAnimation;

@end

NS_ASSUME_NONNULL_END
