//
//  LGFPch.h
//  LGFOCTool
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#ifndef LGFPch_h
#define LGFPch_h

// 自动 NSLog
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[文件名:%s][行号:%d] [%s]\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#undef GKeyPath
#define GKeyPath(objc,keyPath) @(((void)objc.keyPath,#keyPath))

#undef lgf_UUID
#define lgf_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#undef lgf_IOS11SV
#define lgf_IOS11SV(sv) if (@available(iOS 11.0, *)) {\
    sv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
    self.automaticallyAdjustsScrollViewInsets = NO;\
}

// 获取相对 cell 高度
#undef lgf_RealCellHeight
#define lgf_RealCellHeight(h) ((lgf_ScreenWidth / 375) * h)

// IPhone4
#undef lgf_IPhone4
#define lgf_IPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhone5
#undef lgf_IPhone5
#define lgf_IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhone6789
#undef lgf_IPhone6789
#define lgf_IPhone6789 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(754, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhone6789Plus
#undef lgf_IPhone6789Plus
#define lgf_IPhone6789Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhoneX
#undef lgf_IPhoneX
#define lgf_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhoneXS
#undef lgf_IPhoneXS
#define lgf_IPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhoneXR
#undef lgf_IPhoneXR
#define lgf_IPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// IPhoneX 或 IPhoneXS 或 IPhoneXR
#undef lgf_IPhoneXSR
#define lgf_IPhoneXSR (lgf_IPhoneX || lgf_IPhoneXS || lgf_IPhoneXR)

// IPhoneX 导航栏高度
#undef IPhoneX_NAVIGATION_BAR_HEIGHT
#define IPhoneX_NAVIGATION_BAR_HEIGHT (lgf_IPhoneXSR ? 88 : 64)

// 获取真实 Rect
#undef lgf_RectReal
#define lgf_RectReal(view, superview) [view convertRect:view.bounds toView:superview]

// 是否大于某个系统版本
#undef lgf_IOSSystemVersion
#define lgf_IOSSystemVersion(V) [[UIDevice currentDevice] systemVersion].floatValue >= (V)

// RGB颜色
#undef lgf_RGBColor
#define lgf_RGBColor(R, G, B, A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

//随机色
#undef lgf_RandomColor
#define lgf_RandomColor lgf_RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)

// 设置字号
#undef lgf_Font
#define lgf_Font(fontSize) [UIFont systemFontOfSize:fontSize]

// 设置粗体字号
#undef lgf_BoldFont
#define lgf_BoldFont(fontSize) [UIFont systemFontOfSize:fontSize]

// 设置图片
#undef lgf_Image
#define lgf_Image(imageName) [UIImage imageNamed:imageName]

// 设置 Hex 颜色
#undef lgf_HexColor
#define lgf_HexColor(hexStr) [UIColor lgf_ColorWithHexString:hexStr]

// 系统电池栏小菊花
#undef lgf_NWA
#define lgf_NWA LGFApplication.networkActivityIndicatorVisible

// UIApplication
#undef lgf_Application
#define lgf_Application [UIApplication sharedApplication]

// 通知中心
#undef lgf_NCenter
#define lgf_NCenter [NSNotificationCenter defaultCenter]

#undef lgf_MainScreen
#define lgf_MainScreen [UIScreen mainScreen].bounds

// 获取横向滚动index
#undef lgf_ScrollHorizontalIndex
#define lgf_ScrollHorizontalIndex(scrollView) (scrollView.contentOffset.x / (NSInteger)scrollView.bounds.size.width)

// 获取竖向滚动index
#undef lgf_ScrollVerticalIndex
#define lgf_ScrollVerticalIndex(scrollView) (scrollView.contentOffset.y / (NSInteger)scrollView.bounds.size.height)

// Log 输出
#undef lgf_LogContentOffset
#define lgf_LogContentOffset(scrollView) NSLog(@"%f", scrollView.contentOffset.y)

// SDWebImage
#undef lgf_SDImage
#define lgf_SDImage(imageView, imageUrl) [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
#undef lgf_SDAnimatedImage
#define lgf_SDAnimatedImage(imageView, imageData) [imageView setAnimatedImage:[FLAnimatedImage animatedImageWithGIFData:imageData]];
//s.dependency 'LGFRefresh'
//s.dependency 'SDWebImage', '4.4.1'
//s.dependency 'FLAnimatedImage', '~> 1.0'
// NSUserDefaults 缓存
#undef lgf_Defaults
#define lgf_Defaults [NSUserDefaults standardUserDefaults]

// storyboard
#undef lgf_GetSBVC
#define lgf_GetSBVC(className, storyboardStr, bundleStr)\
[lgf_GetSBWithName(storyboardStr, bundleStr) instantiateViewControllerWithIdentifier:(NSStringFromClass([className class]))]

// xib
#undef lgf_GetXibView
#define lgf_GetXibView(className, bundleStr) [lgf_Bundle(bundleStr) loadNibNamed:NSStringFromClass([className class]) owner:self options:nil].firstObject;

// 获取对应名字 storyboard
#undef lgf_GetSBWithName
#define lgf_GetSBWithName(storyboardStr, bundleStr)\
[UIStoryboard storyboardWithName:(storyboardStr) bundle:lgf_Bundle(bundleStr)]

// 资源文件 Bundle
#undef lgf_Bundle
#define lgf_Bundle(bundleName)\
[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"]] ?: [NSBundle mainBundle]

// 资源文件路径
#undef lgf_BundlePath
#define lgf_BundlePath(pathName)\
[[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:pathName ofType:nil]

//---------------------- 常用系统信息获取 ----------------------

// 设备模型数据
#undef lgf_DeviceModel
#define lgf_DeviceModel [UIDevice currentDevice].model

// 屏幕尺寸
#undef lgf_ScreenWidth
#define lgf_ScreenWidth ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#undef lgf_ScreenHeight
#define lgf_ScreenHeight ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

//---------------------- 全局包含头文件 ----------------------
#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreImage/CoreImage.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <Photos/Photos.h>
#import <CoreTelephony/CTCellularData.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>
#endif

//---------------------- 常用数据非空判断 ----------------------
// 字符串是否为空
#undef lgf_StringIsEmpty
#define lgf_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#undef lgf_ArrayIsEmpty
#define lgf_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#undef lgf_DictIsEmpty
#define lgf_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//---------------------- 注册 Nib CollectionViewCell ----------------------
#undef lgf_RegisterNibCVCell
#define lgf_RegisterNibCVCell(collectionView, cellClass, bundleStr)\
[collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:lgf_Bundle(bundleStr)] forCellWithReuseIdentifier:NSStringFromClass([cellClass class])]

//---------------------- 初始化 CollectionViewCell ----------------------
#undef lgf_CVGetCell
#define lgf_CVGetCell(collectionView, cellClass, indexPath)\
[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath]

//---------------------- 注册 Nib CollectionViewReusableView ----------------------
#undef lgf_RegisterNibCVReusableView
#define lgf_RegisterNibCVReusableView(collectionView, cellClass, UICollectionElementKindSection, bundleStr)\
[collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:lgf_Bundle(bundleStr)] forSupplementaryViewOfKind:UICollectionElementKindSection withReuseIdentifier:NSStringFromClass([cellClass class])]

//---------------------- 初始化 CollectionReusableView ----------------------
#undef lgf_CVGetReusableView
#define lgf_CVGetReusableView(collectionView, kind, cellClass, indexPath)\
[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath]


//---------------------- Block 引用控制 ----------------------
// 判断 block 是否被引用
#undef lgf_HaveBlock
#define lgf_HaveBlock(block, ...) if (block) { block(__VA_ARGS__); };
// block 防止强引用
#ifndef lgf_Weak
#if DEBUG
#if __has_feature(objc_arc)
#define lgf_Weak(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define lgf_Weak(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define lgf_Weak(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define lgf_Weak(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif
#ifndef lgf_Strong
#if DEBUG
#if __has_feature(objc_arc)
#define lgf_Strong(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define lgf_Strong(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define lgf_Strong(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define lgf_Strong(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

//---------------------- 创建类快捷设置 ----------------------
#ifndef lgf_SYNTH_DUMMY_CLASS
#define lgf_SYNTH_DUMMY_CLASS(_name_) \
@interface lgf_SYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation lgf_SYNTH_DUMMY_CLASS_ ## _name_ @end
#endif
//---------------------- 获取 Storyboard VC 快捷设置 ----------------------
#undef lgf_SBViewControllerForH
#define lgf_SBViewControllerForH + (instancetype)lgf
#undef lgf_SBViewControllerForM
#define lgf_SBViewControllerForM(className, storyboardStr, bundleStr) \
+ (instancetype)lgf\
{\
return lgf_GetSBVC(className, storyboardStr, bundleStr);\
}
//---------------------- 获取 Xib View 快捷设置 ----------------------
#undef lgf_XibViewForH
#define lgf_XibViewForH + (instancetype)lgf
#undef lgf_XibViewForM
#define lgf_XibViewForM(className, bundleStr) \
+ (instancetype)lgf\
{\
return lgf_GetXibView(className, bundleStr);\
}
//---------------------- 获取 View 快捷设置 ----------------------
#undef lgf_ViewForH
#define lgf_ViewForH + (instancetype)lgf
#undef lgf_ViewForM
#define lgf_ViewForM(className) \
+ (instancetype)lgf\
{\
return [[className alloc] init];\
}
//---------------------- 单列快捷设置 ----------------------

// 添加到 .h 文件
#undef lgf_XibAllocOnceForH
#define lgf_XibAllocOnceForH + (instancetype)lgf
// 添加到 .m 文件
#undef lgf_XibAllocOnceForM
#define lgf_XibAllocOnceForM(className, bundleStr)\
static className *xibView;\
+ (instancetype)lgf\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
xibView = lgf_GetXibView(className, bundleStr);\
});\
return xibView;\
}\

// 添加到 .h 文件
#undef lgf_AllocOnceForH
#define lgf_AllocOnceForH + (instancetype)lgf_Once
// 添加到 .m 文件
#undef lgf_AllocOnceForM
#define lgf_AllocOnceForM(className) static className* _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+ (instancetype)lgf_Once {\
\
return [[className alloc] init];\
}\
- (instancetype)init{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super init];\
});\
return _instance;\
}\
\
- (instancetype)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
- (instancetype)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

//---------------------- 多线程 GCD 宏 ----------------------
// 主队列 + 异步执行
#undef lgf_MAIN
#define lgf_MAIN(demo) dispatch_async(dispatch_get_main_queue(),^{demo});
// 主队列 + 同步执行 通常情况下不建议使用
#undef lgf_MAINT
#define lgf_MAINT(demo) dispatch_sync(dispatch_get_main_queue(),^{demo});
// 并行队列 + 同步执行 主线程执行 一个一个执行 不用等待任务添加到队列立即执行
#undef lgf_CONCURRENTT
#define lgf_CONCURRENTT(demo) dispatch_sync(dispatch_queue_create("lgf", DISPATCH_QUEUE_CONCURRENT), ^{demo});
// 并行队列 + 异步执行 开启新线程 同时执行 将所有任务添加到队列之后开始异步执行
#undef lgf_CONCURRENTY
#define lgf_CONCURRENTY(demo) dispatch_async(dispatch_queue_create("lgf", DISPATCH_QUEUE_CONCURRENT), ^{demo});
// 串行队列 + 同步执行 主线程执行 一个一个执行 不用等待任务添加到队列立即执行
#undef lgf_SERIALT
#define lgf_SERIALT(demo) dispatch_sync(dispatch_queue_create("lgf", DISPATCH_QUEUE_SERIAL), ^{demo});
// 串行队列 + 异步执行 开启新线程 一个一个执行 将所有任务添加到队列之后开始同步执行
#undef lgf_SERIALY
#define lgf_SERIALY(demo) dispatch_async(dispatch_queue_create("lgf", DISPATCH_QUEUE_SERIAL), ^{demo});
// 延时
#undef lgf_AFTER
#define lgf_AFTER(time,demo) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{demo});
// 异步
#undef lgf_GLOBAL
#define lgf_GLOBAL(demo) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{demo})
// 异步栏栅 用于分隔两批异步任务
#undef lgf_BARRIER
#define lgf_BARRIER(demo) dispatch_barrier_async(dispatch_queue_create("lgf", DISPATCH_QUEUE_CONCURRENT), ^{demo});
// 队列组 异步执行多个耗时操作，然后当所有耗时操作都执行完毕后再回到主线程执行操作
#undef lgf_GROUPGLOBAL
#define lgf_GROUPGLOBAL(demo) dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{demo});
#undef lgf_GROUPMAIN
#define lgf_GROUPMAIN(demo) dispatch_group_notify(dispatch_group_create(), dispatch_get_main_queue(), ^{demo});

#endif /* LGFPch_h */

