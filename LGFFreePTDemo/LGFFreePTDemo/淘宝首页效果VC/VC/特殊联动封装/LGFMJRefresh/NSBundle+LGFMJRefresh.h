//
//  NSBundle+LGFMJRefresh.h
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (LGFMJRefresh)
+ (instancetype)lgfmj_refreshBundle;
+ (UIImage *)lgfmj_arrowImage;
+ (NSString *)lgfmj_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)lgfmj_localizedStringForKey:(NSString *)key;
@end
