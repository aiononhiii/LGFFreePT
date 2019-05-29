//
//  LGFEmoji.m
//  OptimalLive
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFEmoji.h"
#import "LGFEmojiCell.h"
#import "UIImage+ForceDecode.h"
#import "LGFOCTool.h"

@interface LGFEmoji () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *emojiSV;
@property (weak, nonatomic) IBOutlet UIView *emojiSVView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emojiSVViewWidth;
@property (assign, nonatomic) CGFloat lgf_EmojiWidth;
@property (assign, nonatomic) CGFloat lgf_EmojiHeight;
@end
@implementation LGFEmoji

static LGFEmoji *lgf_Emoji = nil;

+ (instancetype)lgf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lgf_Emoji = [lgf_Bundle(@"LGFOCTool") loadNibNamed:NSStringFromClass([LGFEmoji class]) owner:lgf_Emoji options:nil].firstObject;
        lgf_Emoji.lgf_VNum = 4;
        lgf_Emoji.lgf_HNum = 8;
        lgf_Emoji.lgf_LeftRightSpacing = 20;
        lgf_Emoji.lgf_TopBottomSpacing = 15;
    });
    return lgf_Emoji;
}

- (void)lgf_AddEmoji {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [lgf_NCenter addObserver:lgf_Emoji selector:@selector(textViewTextDidChange:)name:UITextViewTextDidChangeNotification object:nil];
        [lgf_Emoji.lgf_EmojiArray.mutableCopy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ((idx + 2) % (lgf_Emoji.lgf_VNum * lgf_Emoji.lgf_HNum) == 0) {
                [lgf_Emoji.lgf_EmojiArray insertObject:@"" atIndex:idx + 1];
                [lgf_Emoji.lgf_EmojiStrArray insertObject:@"" atIndex:idx + 1];
            }
        }];
        if (lgf_Emoji.emojiSVView.subviews.count == 0) {
            lgf_Emoji.lgf_EmojiPage.numberOfPages = ceilf(lgf_Emoji.lgf_EmojiArray.count / (lgf_Emoji.lgf_VNum * lgf_Emoji.lgf_HNum * 1.0));
            lgf_Emoji.emojiSVViewWidth.constant = lgf_ScreenWidth * lgf_Emoji.lgf_EmojiPage.numberOfPages;
            dispatch_async(dispatch_get_main_queue(), ^{
                [lgf_Emoji.lgf_EmojiArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull imageName, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (imageName.length > 0) {
                        LGFEmojiCell *emojiCell = [LGFEmojiCell lgf];
                        emojiCell.tag = idx;
                        emojiCell.lgf_EmojiSpacing = self.lgf_EmojiSpacing;
                        [emojiCell lgf_AddTapAction:@selector(emojiSelect:) target:lgf_Emoji];
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            UIImage *img = [UIImage decodedImageWithImage:lgf_Image(imageName)];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [emojiCell.lgf_EmojiImage setImage:img];
                            });
                        });
                        CGFloat emojiX = lgf_Emoji.lgf_LeftRightSpacing + lgf_Emoji.lgf_EmojiWidth * (idx % lgf_Emoji.lgf_HNum) + lgf_Emoji.emojiSV.lgf_width * (ceilf((idx + 1.0) / (lgf_Emoji.lgf_VNum * lgf_Emoji.lgf_HNum)) - 1);
                        CGFloat emgjiY = lgf_Emoji.lgf_TopBottomSpacing + lgf_Emoji.lgf_EmojiHeight * (ceilf((idx + 1.0) / lgf_Emoji.lgf_HNum - 1)) - lgf_Emoji.lgf_EmojiHeight * lgf_Emoji.lgf_VNum * (ceilf((idx + 1.0) / (lgf_Emoji.lgf_VNum * lgf_Emoji.lgf_HNum)) - 1);
                        emojiCell.frame = CGRectMake(emojiX, emgjiY, lgf_Emoji.lgf_EmojiWidth, lgf_Emoji.lgf_EmojiHeight);
                        [lgf_Emoji.emojiSVView addSubview:emojiCell];
                    }
                }];
            });
        }
    });
}

#pragma mark - 配置textView
- (void)setLgf_EmojiTextView:(UITextView *)lgf_EmojiTextView {
    _lgf_EmojiTextView = lgf_EmojiTextView;
    [lgf_Emoji lgf_AddEmoji];
}

#pragma mark - 点击 emoji
- (void)emojiSelect:(UITapGestureRecognizer *)sender {
    lgf_Emoji.lgf_EmojiTextView.text = [lgf_Emoji.lgf_EmojiTextView.text stringByAppendingString:lgf_Emoji.lgf_EmojiStrArray[sender.view.tag]];
    lgf_Emoji.lgf_EmojiSendBtnSelect = lgf_Emoji.lgf_EmojiTextView.text.length > 0;
    lgf_HaveBlock(lgf_Emoji.lgf_EmojiDidchange);
}

#pragma mark - 删除
- (IBAction)emojiDelete:(UIButton *)sender {
    [lgf_Emoji textView:lgf_Emoji.lgf_EmojiTextView shouldChangeTextInRange:NSMakeRange(lgf_Emoji.lgf_EmojiTextView.text.length - 1, 1) replacementText:@""];
    lgf_Emoji.lgf_EmojiSendBtnSelect = lgf_Emoji.lgf_EmojiTextView.text.length > 0;
    lgf_HaveBlock(lgf_Emoji.lgf_EmojiDidchange);
}

#pragma mark - 发送
- (IBAction)emojiSend:(UIButton *)sender {
    lgf_HaveBlock(lgf_Emoji.lgf_EmojiSendBolck);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == lgf_Emoji.emojiSV) {
        lgf_Emoji.lgf_EmojiPage.currentPage = lgf_ScrollHorizontalIndex(scrollView);
    }
}

#pragma mark - UITextViewTextDidChangeNotification
- (void)textViewTextDidChange:(NSNotification *)notification {
    if (notification.object == lgf_Emoji.lgf_EmojiTextView) {
        lgf_Emoji.lgf_EmojiSendBtnSelect = lgf_Emoji.lgf_EmojiTextView.text.length > 0;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)lgf_EmojiArray {
    if (!_lgf_EmojiArray) {
        _lgf_EmojiArray = [NSMutableArray new];
    }
    return _lgf_EmojiArray;
}

- (NSMutableArray *)lgf_EmojiStrArray {
    if (!_lgf_EmojiStrArray) {
        _lgf_EmojiStrArray = [NSMutableArray new];
    }
    return _lgf_EmojiStrArray;
}

- (CGFloat)lgf_EmojiWidth {
    return ((self.emojiSV.lgf_width - self.lgf_LeftRightSpacing * 2) / self.lgf_HNum);
}

- (CGFloat)lgf_EmojiHeight {
    return ((self.emojiSV.lgf_height - _lgf_TopBottomSpacing * 2) / self.lgf_VNum);
}

- (void)setLgf_EmojiSendBtnSelect:(BOOL)lgf_EmojiSendBtnSelect {
    _lgf_EmojiSendBtnSelect = lgf_EmojiSendBtnSelect;
    if (lgf_EmojiSendBtnSelect) {
        self.lgf_EmojiSend.userInteractionEnabled = YES;
        [self.lgf_EmojiSend setBackgroundColor:self.lgf_EmojiReadySendColor];
        [self.lgf_EmojiSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.lgf_EmojiSend.userInteractionEnabled = NO;
        [self.lgf_EmojiSend setBackgroundColor:lgf_HexColor(@"f0f0f0")];
        [self.lgf_EmojiSend setTitleColor:lgf_HexColor(@"808080") forState:UIControlStateNormal];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {//发送
        return NO;
    }
    if ([NSString lgf_IsBlank:text]) {
        NSString *deleteText = [textView.text substringWithRange:range];
        NSUInteger location = range.location;
        NSUInteger length = range.length;
        if ([deleteText isEqualToString:@"]"]) {
            NSString *subText;
            while (YES) {
                if (location == 0) {
                    return YES;
                }
                location--;
                length++;
                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
                    break;
                }
            }
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
            return NO;
        } else {
            if (textView.text.length != 0) {
                textView.text = [textView.text stringByReplacingCharactersInRange:range withString:@""];
                [textView setSelectedRange:NSMakeRange(location, 0)];
            }
        }
    }
    return YES;
}

+ (NSMutableAttributedString *)lgf_ImageToEmojiForText:(NSString *)text Y:(CGFloat)Y {
    NSMutableArray *emotions = [NSMutableArray array];
    NSArray *imageNameArray = [LGFEmoji lgf].lgf_EmojiArray;
    NSArray *faceNameArray = [LGFEmoji lgf].lgf_EmojiStrArray;
    for (int i = 0; i < imageNameArray.count; i++) {
        NSDictionary *emotion = @{@"strName" : faceNameArray[i], @"imageName" : imageNameArray[i]};
        [emotions addObject:emotion];
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSString *pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    for(NSTextCheckingResult *match in resultArray) {
        NSRange range = [match range];
        NSString *subStr = [text substringWithRange:range];
        for (int i = 0; i < emotions.count; i++) {
            NSDictionary *emotion = emotions[i];
            if ([emotion[@"strName"] isEqualToString:subStr]) {
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //这个 Y 需要自己调整
                textAttachment.bounds = CGRectMake(0, Y, 20, 20);
                NSString *emojiString = [NSString stringWithFormat:@"%@", emotion[@"imageName"]];
                textAttachment.image = [UIImage imageNamed:emojiString];
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                [imageArray addObject:imageDic];
            }
        }
    }
    for (NSInteger i = imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
}

@end
