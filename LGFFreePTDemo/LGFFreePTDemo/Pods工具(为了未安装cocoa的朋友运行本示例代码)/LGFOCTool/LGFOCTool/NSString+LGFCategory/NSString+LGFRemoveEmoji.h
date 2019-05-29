//
//  NSString+NSString_LGFRemoveEmoji.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGFRemoveEmoji)

#pragma mark - 是否包含emoji
- (BOOL)lgf_IsIncludingEmoji;

#pragma mark - 删除掉字符串中的 emoji
- (instancetype)lgf_RemovedEmojiString;

@end
