//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat LGFMJRefreshLabelLeftInset = 25;
const CGFloat LGFMJRefreshHeaderHeight = 54.0;
const CGFloat LGFMJRefreshFooterHeight = 44.0;
const CGFloat LGFMJRefreshFastAnimationDuration = 0.25;
const CGFloat LGFMJRefreshSlowAnimationDuration = 0.4;

NSString *const LGFMJRefreshKeyPathContentOffset = @"contentOffset";
NSString *const LGFMJRefreshKeyPathContentInset = @"contentInset";
NSString *const LGFMJRefreshKeyPathContentSize = @"contentSize";
NSString *const LGFMJRefreshKeyPathPanState = @"state";

NSString *const LGFMJRefreshHeaderLastUpdatedTimeKey = @"LGFMJRefreshHeaderLastUpdatedTimeKey";

NSString *const LGFMJRefreshHeaderIdleText = @"LGFMJRefreshHeaderIdleText";
NSString *const LGFMJRefreshHeaderPullingText = @"LGFMJRefreshHeaderPullingText";
NSString *const LGFMJRefreshHeaderRefreshingText = @"LGFMJRefreshHeaderRefreshingText";

NSString *const LGFMJRefreshAutoFooterIdleText = @"LGFMJRefreshAutoFooterIdleText";
NSString *const LGFMJRefreshAutoFooterRefreshingText = @"LGFMJRefreshAutoFooterRefreshingText";
NSString *const LGFMJRefreshAutoFooterNoMoreDataText = @"LGFMJRefreshAutoFooterNoMoreDataText";

NSString *const LGFMJRefreshBackFooterIdleText = @"LGFMJRefreshBackFooterIdleText";
NSString *const LGFMJRefreshBackFooterPullingText = @"LGFMJRefreshBackFooterPullingText";
NSString *const LGFMJRefreshBackFooterRefreshingText = @"LGFMJRefreshBackFooterRefreshingText";
NSString *const LGFMJRefreshBackFooterNoMoreDataText = @"LGFMJRefreshBackFooterNoMoreDataText";

NSString *const LGFMJRefreshHeaderLastTimeText = @"LGFMJRefreshHeaderLastTimeText";
NSString *const LGFMJRefreshHeaderDateTodayText = @"LGFMJRefreshHeaderDateTodayText";
NSString *const LGFMJRefreshHeaderNoneLastDateText = @"LGFMJRefreshHeaderNoneLastDateText";
