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

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, lgf_FreePageViewAnimationType) {
    lgf_PageViewAnimationNone,// 没有分页动画
    lgf_PageViewAnimationTopToBottom,// 从上往下进入的分页动画
    lgf_PageViewAnimationSmallToBig,// 从小到大进入的分页动画
};

typedef NS_ENUM(NSUInteger, lgf_FreePageLineAnimationType) {
    lgf_PageLineAnimationDefult,// 标底部线平滑改变大小
    // 后续推出下面的 仿爱奇艺底部线动画效果 现暂时不可用 请勿设置
    lgf_PageLineAnimationSmallToBig,// 标底部线先右边伸出变宽致标和下一个标的总宽度, 再左边收回恢复到下一个标的宽度
    lgf_PageLineAnimationTortoise,// 乌龟效果，标底部线向下隐藏，再在下一个标的底部向上出现（暂未实现）
};

typedef NS_ENUM(NSUInteger, lgf_FreeTitleScrollFollowType) {
    lgf_TitleScrollFollowDefult,// 在可滚动的情况下, 选中标默认滚动到 lgf_PVTitleView 中间
    // 后续推出下面的 仿腾讯新闻, 天天快报选中标滚动效果 现暂时不可用 请勿设置
    lgf_TitleScrollFollowLeftRight,// 向左滚动选中标永远出现在最右边可见位置, 反之向右滚动选中标永远出现在最左边可见位置（此效果不会像上面的效果那样滚到中间）
};

typedef NS_ENUM(NSUInteger, lgf_FreeTitleLineWidthType) {
    lgf_EqualTitleSTR,// 宽度等于字体宽度
    lgf_EqualTitleSTRAndImage,// 宽度等于字体宽度 + 图标宽度
    lgf_EqualTitle,// 宽度等于标view宽度
    lgf_FixedWith,// 宽度等于固定宽度
};

@interface LGFFreePTStyle : NSObject

// 初始化
+ (instancetype)lgf;

//------------------- 数据源设置
// 标数组
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
// 当所有标总宽度加起来小于 lgf_PVTitleView 宽度时 是否居中显示 默认 NO - 不居中(从左边开始显示)
@property (assign, nonatomic) BOOL lgf_IsTitleCenter;
// 选中标滚动类型 默认 LGFTitleScrollFollowDefult
@property (assign, nonatomic) lgf_FreeTitleScrollFollowType lgf_TitleScrollFollowType;
// page左右间距 默认 0.0
@property (assign, nonatomic) CGFloat lgf_PageLeftRightSpace;

//------------------- 标设置
// 支持副标题
@property (assign, nonatomic) BOOL lgf_IsDoubleTitle;
// 标固定宽度 默认等于 0.0 如果此属性大于 0.0 那么标宽度将为固定值
// 如果设置此项（lgf_TitleFixedWidth） LGFTitleLineWidthType 将只支持 FixedWith 固定底部线宽度
@property (assign, nonatomic) CGFloat lgf_TitleFixedWidth;
// 选中标 字体颜色 默认 blackColor 黑色 (对应 lgf_TitleUnSelectColor 两个颜色一样则取消渐变效果)
@property (strong, nonatomic) UIColor *lgf_TitleSelectColor;
// 未选中标 字体颜色 默认 lightGrayColor 淡灰色 (对应 lgf_TitleSelectColor 两个颜色一样则取消渐变效果)
@property (strong, nonatomic) UIColor *lgf_UnTitleSelectColor;
// 标 选中字体 默认 [UIFont systemFontOfSize:14]
@property (strong, nonatomic) UIFont *lgf_TitleSelectFont;
// 标 未选中字体 默认 和选中字体一样
@property (strong, nonatomic) UIFont *lgf_UnTitleSelectFont;
// 子标题 默认和标一样
@property (strong, nonatomic) UIColor *lgf_SubTitleSelectColor;
@property (strong, nonatomic) UIColor *lgf_UnSubTitleSelectColor;
@property (strong, nonatomic) UIFont *lgf_SubTitleSelectFont;
@property (strong, nonatomic) UIFont *lgf_UnSubTitleSelectFont;
@property (assign, nonatomic) CGFloat lgf_SubTitleTopSpace;
// 选中标 放大缩小倍数 默认 1.0(不放大缩小)
@property (assign, nonatomic) CGFloat lgf_TitleBigScale;
// 选中主标 放大缩小倍数 默认 1.0(不放大缩小)
@property (assign, nonatomic) CGFloat lgf_MainTitleBigScale;
// 选中主标 上下偏移数 默认 0.0(不上下偏移)
@property (assign, nonatomic) CGFloat lgf_MainTitleUpDownScale;
// 选中子标 放大缩小倍数 默认 1.0(不放大缩小)
@property (assign, nonatomic) CGFloat lgf_SubTitleBigScale;
// 选中子标 上下偏移数 默认 0.0(不上下偏移)
@property (assign, nonatomic) CGFloat lgf_SubTitleUpDownScale;
// 标是否有滑动动画 默认 YES 有动画
@property (assign, nonatomic) BOOL lgf_TitleHaveAnimation;
// 标左右间距 默认 0.0
@property (assign, nonatomic) CGFloat lgf_TitleLeftRightSpace;
// 标背景色
@property (strong, nonatomic) UIColor *lgf_TitleBackgroundColor;
// 标边框颜色
@property (strong, nonatomic) UIColor *lgf_TitleBorderColor;
// 标边框宽度
@property (assign, nonatomic) CGFloat lgf_TitleBorderWidth;
// 标圆角
@property (assign, nonatomic) CGFloat lgf_TitleCornerRadius;
// 点击标移动动画时间 默认 0.2
@property (assign, nonatomic) CGFloat lgf_TitleClickAnimationDuration;
// 点击标后移动标居中动画时间 默认 0.2
@property (assign, nonatomic) CGFloat lgf_TitleScrollToTheMiddleAnimationDuration;
//------------------- 特殊标设置
// 要替换的特殊标数组（数组中元素 view 的 lgf_FreePTSpecialTitleArray（值格式：@"0/80"） 字符串属性转化为数组后 数组的 firstObject（0） 即为要替换 title 的 index, 数组的 lastObject（80） 即为要替换 title 的自定义宽度）（记住这只是替换，因此原数据源支撑 UI 展示的数据必须存在，可设置为空字符串）
@property (nonatomic, copy) NSArray <UIView *> *lgf_FreePTSpecialTitleArray;

//------------------- 标图片设置
// 图片Bundle 如果图片不在本控件bundel里请设置
@property (strong, nonatomic) NSBundle *lgf_TitleImageBundel;
// lgf_SelectImageNames 和 lgf_SameSelectImageName 设置一个就行 如果都设置了默认取 lgf_SameSelectImageName
// 设置不同图标数组（必须和titles数组count保持一致,如果某一个标不想设置图标名字传空即可）
// 选中图标数组和未选中图标数组如果只传了其中一个,将没有选中效果
@property (strong, nonatomic) NSMutableArray *lgf_SelectImageNames;
@property (strong, nonatomic) NSMutableArray *lgf_UnSelectImageNames;
// 设置所有图标为相同
@property (copy, nonatomic) NSString *lgf_SameSelectImageName;
@property (copy, nonatomic) NSString *lgf_SameUnSelectImageName;

// 以下属性只要有值，对应imageview就会显示出来
// 顶部标图片与标的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_TopImageSpace;
// 顶部标图片宽度 默认等于设置的高度 最大不超过标 view高度
@property (assign, nonatomic) CGFloat lgf_TopImageWidth;
// 顶部标图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_TopImageHeight;
// 底部标图片与标的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_BottomImageSpace;
// 底部标图片宽度 默认等于设置的高度 最大不超过标 view高度
@property (assign, nonatomic) CGFloat lgf_BottomImageWidth;
// 底部标图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_BottomImageHeight;
// 左边标图片与标的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_LeftImageSpace;
// 左边标图片宽度 默认等于设置的高度 最大不超过标 view高度
@property (assign, nonatomic) CGFloat lgf_LeftImageWidth;
// 左边标图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_LeftImageHeight;
// 右边标图片与标的间距 默认 0
@property (assign, nonatomic) CGFloat lgf_RightImageSpace;
// 右边标图片宽度 默认等于设置的高度 最大不超过标 view高度
@property (assign, nonatomic) CGFloat lgf_RightImageWidth;
// 右边标图片高度 默认等于设置的宽度
@property (assign, nonatomic) CGFloat lgf_RightImageHeight;

//------------------- 标底部线设置
// 是否显示标底部滚动线 默认 YES 显示
@property (assign, nonatomic) BOOL lgf_IsShowLine;
// 标底部线圆角弧度 默认 0 没有弧度
@property (assign, nonatomic) CGFloat lgf_LineCornerRadius;
// 标背景图片 默认 无图
@property (strong, nonatomic) UIImage *_Nullable lgf_LineBackImage;
// 标底部滚动线 颜色 默认 blueColor
@property (strong, nonatomic) UIColor *lgf_LineColor;
// 标底部滚动线 透明度 默认 1.0 - 不透明
@property (assign, nonatomic) CGFloat lgf_LineAlpha;
// 标底部滚动线 动画宽度设置 默认宽度等于标字体宽度 - EqualTitleSTR
@property (assign, nonatomic) lgf_FreeTitleLineWidthType lgf_LineWidthType;
// 标底部滚动线 宽度 默认 0 - 设置 LGFTitleLineType 固定宽度(FixedWith)时有效
@property (assign, nonatomic) CGFloat lgf_LineWidth;
// 标底部滚动线 高度 默认 1.0 (line_height最大高度为 LGFFreePT 的高度)
@property (assign, nonatomic) CGFloat lgf_LineHeight;
// 标底部滚动线相对于底部位置 默认 0 - 贴于底部
@property (assign, nonatomic) CGFloat lgf_LineBottom;
// 标底部滚动线滑动动画 默认 LGFPageLineAnimationDefult 有跟随动画
@property (assign, nonatomic) lgf_FreePageLineAnimationType lgf_LineAnimation;

@end

NS_ASSUME_NONNULL_END
