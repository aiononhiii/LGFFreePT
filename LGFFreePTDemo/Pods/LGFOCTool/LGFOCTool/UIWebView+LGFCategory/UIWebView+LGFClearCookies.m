//
//  UIWebView+LGFClearCookies.m
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIWebView+LGFClearCookies.h"

@implementation UIWebView (LGFClearCookies)

#pragma mark - 清空cookie

- (void)lgf_ClearCookies {
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
