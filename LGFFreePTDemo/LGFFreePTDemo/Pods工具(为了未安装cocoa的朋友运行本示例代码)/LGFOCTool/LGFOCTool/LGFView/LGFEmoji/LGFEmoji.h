//
//  LGFEmoji.h
//  OptimalLive
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFEmoji : UIView
@property (weak, nonatomic) UITextView *lgf_EmojiTextView;
@property (strong, nonatomic) NSMutableArray *lgf_EmojiArray;// 表情图片名字数组
@property (strong, nonatomic) NSMutableArray *lgf_EmojiStrArray;// 表情文字数组
@property (strong, nonatomic) UIColor *lgf_EmojiReadySendColor;// 准备发送的颜色
@property (weak, nonatomic) IBOutlet UIButton *lgf_EmojiDelete;// 删除按钮
@property (weak, nonatomic) IBOutlet UIButton *lgf_EmojiSend;// 发送按钮
@property (weak, nonatomic) IBOutlet UIPageControl *lgf_EmojiPage;// 分页控件
@property (assign, nonatomic) CGFloat lgf_LeftRightSpacing;// 整体左右边距
@property (assign, nonatomic) CGFloat lgf_TopBottomSpacing;// 整体上下边距
@property (assign, nonatomic) NSInteger lgf_VNum;// 行数
@property (assign, nonatomic) NSInteger lgf_HNum;// 列数
@property (assign, nonatomic) CGFloat lgf_EmojiSpacing;// 内部图片边距
@property (assign, nonatomic) BOOL lgf_EmojiSendBtnSelect;// 发送按钮状态改变
@property (nonatomic, copy) void (^lgf_EmojiDidchange)(void);// 表情输入中
@property (nonatomic, copy) void (^lgf_EmojiSendBolck)(void);// 点击发送
// 单列初始化
+ (instancetype)lgf;
// textview 文字中加入表情 富文本转化
+ (NSMutableAttributedString *)lgf_ImageToEmojiForText:(NSString *)text Y:(CGFloat)Y;
@end

NS_ASSUME_NONNULL_END
