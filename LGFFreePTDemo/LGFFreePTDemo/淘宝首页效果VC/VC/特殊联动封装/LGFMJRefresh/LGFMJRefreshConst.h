//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 弱引用
#define MJWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define LGFMJRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define LGFMJRefreshLog(...)
#endif

// 过期提醒
#define LGFMJRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define LGFMJRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define LGFMJRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define LGFMJRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define LGFMJRefreshLabelTextColor LGFMJRefreshColor(90, 90, 90)

// 字体大小
#define LGFMJRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat LGFMJRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat LGFMJRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat LGFMJRefreshFooterHeight;
UIKIT_EXTERN const CGFloat LGFMJRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat LGFMJRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const LGFMJRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const LGFMJRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const LGFMJRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const LGFMJRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const LGFMJRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const LGFMJRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const LGFMJRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const LGFMJRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const LGFMJRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const LGFMJRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const LGFMJRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const LGFMJRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const LGFMJRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const LGFMJRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const LGFMJRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const LGFMJRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const LGFMJRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const LGFMJRefreshHeaderNoneLastDateText;

// 状态检查
#define LGFMJRefreshCheckState \
LGFMJRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

// 异步主线程执行，不强持有Self
#define LGFMJRefreshDispatchAsyncOnMainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});

