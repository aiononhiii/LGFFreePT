//
//  StyleDemoViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/15.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "StyleDemoViewController.h"

@interface StyleDemoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *styleDemoText;
@property (nonatomic, copy) NSArray *demoArray;
@end

@implementation StyleDemoViewController

lgf_SBViewControllerForM(StyleDemoViewController, @"Main", @"StyleDemoViewController");

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDemoArray];
    self.styleDemoText.textContainer.lineFragmentPadding = 0;
    self.styleDemoText.textContainerInset = UIEdgeInsetsMake(15, 10, 15, 10);
    NSString *demoStr = [self.demoArray componentsJoinedByString:@"\n"];
    self.styleDemoText.text = demoStr;
    [self.styleDemoText lgf_KeywordHighlightTexts:@[
  @{@"text" : @"style", @"color" : @"FFFFFF"},
  @{@"text" : @"*", @"color" : @"FFFFFF"},
  @{@"text" : @"[", @"color" : @"FFFFFF"},
  @{@"text" : @"]", @"color" : @"FFFFFF"},
  @{@"text" : @"=", @"color" : @"FFFFFF"},
  @{@"text" : @";", @"color" : @"FFFFFF"},
  @{@"text" : @".", @"color" : @"FFFFFF"},
  @{@"text" : @"(", @"color" : @"FFFFFF"},
  @{@"text" : @")", @"color" : @"FFFFFF"},
  @{@"text" : @"lgf_Bundle", @"color" : @"A96941"},
  @{@"text" : @"LGFPTHexColor", @"color" : @"A96941"}]];
    
  // @{@"text" : @"@\"tupian\"", @"color" : @"D0232D"},
}

- (void)creatDemoArray {
    NSMutableDictionary *styleDefultDict = [[NSMutableDictionary alloc] initWithDictionary:[lgf_Defaults objectForKey:@"LGFStyleDefultDict"]];
    NSMutableDictionary *styleDict = [[NSMutableDictionary alloc] initWithDictionary:[lgf_Defaults objectForKey:@"LGFStyleDict"]];
    
    NSMutableArray *demoArray = [NSMutableArray arrayWithArray:@[@"LGFFreePTStyle *style = [LGFFreePTStyle lgf];\n"]];
    
    if (![styleDict[@"lgf_IsDoubleTitle"] boolValue]) {
        NSString *demo = @"style.lgf_Titles = @[@\"我的\", @\"邮箱:\", @\"452354033@qq.com\", @\"正在\", @\"寻求好的\", @\"团队\", @\"从事过 IOS 开发 And Android 开发\", @\"主要从事\", @\"IOS 开发\", @\"5\", @\"年开发经验\"].copy;\n";
        [demoArray addObject:demo];
    } else {
        NSString *demo = @"style.lgf_Titles = @[@\"我的/我的\", @\"邮箱:/邮箱\", @\"452354033@qq.com/452354033@qq.com\", @\"正在/正在\", @\"寻求好的/寻求好的\", @\"团队/团队\", @\"从事过 IOS 开发 And Android 开发/从事过 IOS 开发 And Android 开发\", @\"主要从事/主要从事\", @\"IOS 开发/IOS 开发\", @\"5/5\", @\"年半开发经验/年半开发经验\"].copy;\n";
        [demoArray addObject:demo];
    }
    
    [styleDefultDict.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull defultKey, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![[styleDefultDict valueForKey:defultKey] isEqualToString:[styleDict valueForKey:defultKey]] && ![defultKey isEqualToString:@"LGFFreePTSuperViewHeight"]) {
            NSString *demo = @"";
            if ([defultKey isEqualToString:@"setlgf_ImageNames"]) {
                demo = @"style.lgf_SelectImageNames = @[@\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\"].mutableCopy;\nstyle.lgf_UnSelectImageNames = @[@\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\"].mutableCopy;\nstyle.lgf_TitleImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");\n";
            } else if ([defultKey isEqualToString:@"setlgf_LineBackImage"]) {
                demo = @"style.lgf_LineBackImage = lgf_Image(@\"line_image\");\n";
            } else if ([defultKey isEqualToString:@"lgf_TitleSelectFont"] || [defultKey isEqualToString:@"lgf_UnTitleSelectFont"] || [defultKey isEqualToString:@"lgf_SubTitleSelectFont"] || [defultKey isEqualToString:@"lgf_UnSubTitleSelectFont"]) {
                demo = [NSString stringWithFormat:@"style.%@ = [UIFont systemFontOfSize:%@];\n", defultKey, [styleDict valueForKey:defultKey]];
            } else if ([defultKey isEqualToString:@"lgf_TitleSelectColor"] || [defultKey isEqualToString:@"lgf_UnSubTitleSelectColor"] || [defultKey isEqualToString:@"lgf_SubTitleSelectColor"] || [defultKey isEqualToString:@"lgf_TitleBackgroundColor"] || [defultKey isEqualToString:@"lgf_LineColor"] || [defultKey isEqualToString:@"lgf_TitleBorderColor"] || [defultKey isEqualToString:@"lgf_PVTitleViewBackgroundColor"]) {
                demo = [NSString stringWithFormat:@"style.%@ = @\"%@\";\n", defultKey, [styleDict valueForKey:defultKey]];
            } else {
                demo = [NSString stringWithFormat:@"style.%@ = %@;\n", defultKey, [styleDict valueForKey:defultKey]];
            }
            [demoArray addObject:demo];
        }
    }];
    
    if (![styleDict[@"setlgf_ImageNames"] boolValue]) {
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_TopImageSpace", [styleDict valueForKey:@"lgf_TopImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_TopImageWidth", [styleDict valueForKey:@"lgf_TopImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_TopImageHeight", [styleDict valueForKey:@"lgf_TopImageHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_BottomImageSpace", [styleDict valueForKey:@"lgf_BottomImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_BottomImageWidth", [styleDict valueForKey:@"lgf_BottomImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_BottomImageHeight", [styleDict valueForKey:@"lgf_BottomImageHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LeftImageSpace", [styleDict valueForKey:@"lgf_LeftImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LeftImageWidth", [styleDict valueForKey:@"lgf_LeftImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LeftImageHeight", [styleDict valueForKey:@"lgf_LeftImageHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_RightImageSpace", [styleDict valueForKey:@"lgf_RightImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_RightImageWidth", [styleDict valueForKey:@"lgf_RightImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_RightImageHeight", [styleDict valueForKey:@"lgf_RightImageHeight"]]];
    }
    
    if (![styleDict[@"lgf_IsShowLine"] boolValue]) {
        [demoArray removeObject:@"style.lgf_LineBackImage = lgf_Image(@\"line_image\");\n"];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineAnimation", [styleDict valueForKey:@"lgf_LineAnimation"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineCornerRadius", [styleDict valueForKey:@"lgf_LineCornerRadius"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = @\"%@\";\n", @"lgf_LineColor", [styleDict valueForKey:@"lgf_LineColor"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineWidth", [styleDict valueForKey:@"lgf_LineWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineHeight", [styleDict valueForKey:@"lgf_LineHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineBottom", [styleDict valueForKey:@"lgf_LineBottom"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineAlpha", [styleDict valueForKey:@"lgf_LineAlpha"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineAnimation", [styleDict valueForKey:@"lgf_LineAnimation"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_LineWidthType", [styleDict valueForKey:@"lgf_LineWidthType"]]];
    }
    if (![styleDict[@"lgf_IsDoubleTitle"] boolValue]) {
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = [UIFont systemFontOfSize:%@];\n", @"lgf_SubTitleSelectFont", [styleDict valueForKey:@"lgf_SubTitleSelectFont"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = [UIFont systemFontOfSize:%@];\n", @"lgf_UnSubTitleSelectFont", [styleDict valueForKey:@"lgf_UnSubTitleSelectFont"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = @\"%@\";\n", @"lgf_UnSubTitleSelectColor", [styleDict valueForKey:@"lgf_UnSubTitleSelectColor"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = @\"%@\";\n", @"lgf_SubTitleSelectColor", [styleDict valueForKey:@"lgf_SubTitleSelectColor"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_SubTitleTransformSX", [styleDict valueForKey:@"lgf_SubTitleTransformSX"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_SubTitleTransformTY", [styleDict valueForKey:@"lgf_SubTitleTransformTY"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_SubTitleTransformTX", [styleDict valueForKey:@"lgf_SubTitleTransformTX"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_SubTitleTopSpace", [styleDict valueForKey:@"lgf_SubTitleTopSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;\n", @"lgf_IsLineAlignSubTitle", [styleDict valueForKey:@"lgf_IsLineAlignSubTitle"]]];
    }
    
    self.demoArray = demoArray.copy;
}

#pragma mark - 复制代码
- (IBAction)pasteboard:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.styleDemoText.text;
    if (pasteboard) {
        [self.view lgf_ShowMessage:@"复制成功" completion:nil];
    }
}

@end
