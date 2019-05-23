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
  @{@"text" : @"@[", @"color" : [self.styleDemoText.textColor lgf_HexString]},
  @{@"text" : @"].copy", @"color" : [self.styleDemoText.textColor lgf_HexString]},
  @{@"text" : @"].mutableCopy", @"color" : [self.styleDemoText.textColor lgf_HexString]},
  @{@"text" : @"=", @"color" : @"FFFFFF"},
  @{@"text" : @";", @"color" : @"FFFFFF"},
  @{@"text" : @".", @"color" : @"FFFFFF"},
  @{@"text" : @"(", @"color" : @"FFFFFF"},
  @{@"text" : @")", @"color" : @"FFFFFF"},
  @{@"text" : @"YES", @"color" : @"D5008F"},
  @{@"text" : @"NO", @"color" : @"D5008F"},
  @{@"text" : @"lgf_Bundle", @"color" : @"A96941"},
  @{@"text" : @"LGFPTHexColor", @"color" : @"A96941"},
  @{@"text" : @"@(\"([^\"]*)\")", @"color" : @"D0232D"}]];
}

- (void)creatDemoArray {
    NSMutableDictionary *styleDefultDict = [[NSMutableDictionary alloc] initWithDictionary:[lgf_Defaults objectForKey:@"LGFStyleDefultDict"]];
    NSMutableDictionary *styleDict = [[NSMutableDictionary alloc] initWithDictionary:[lgf_Defaults objectForKey:@"LGFStyleDict"]];
    
    NSMutableArray *demoArray = [NSMutableArray arrayWithArray:@[@"LGFFreePTStyle *style = [LGFFreePTStyle lgf];"]];
    
    if (![styleDict[@"lgf_IsDoubleTitle"] boolValue]) {
        NSString *demo = @"style.lgf_Titles = @[@\"我的\", @\"邮箱:\", @\"452354033@qq.com\", @\"正在\", @\"寻求好的\", @\"团队\", @\"从事过 IOS 开发 And Android 开发\", @\"主要从事\", @\"IOS 开发\", @\"5\", @\"年半开发经验\"].copy;";
        [demoArray addObject:demo];
    } else {
        NSString *demo = @"style.lgf_Titles = @[@\"我的/我的\", @\"邮箱:/邮箱\", @\"452354033@qq.com/452354033@qq.com\", @\"正在/正在\", @\"寻求好的/寻求好的\", @\"团队/团队\", @\"从事过 IOS 开发 And Android 开发/从事过 IOS 开发 And Android 开发\", @\"主要从事/主要从事\", @\"IOS 开发/IOS 开发\", @\"5/5\", @\"年半开发经验/年半开发经验\"].copy;";
        [demoArray addObject:demo];
    }
    
    [styleDefultDict.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull defultKey, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![[styleDefultDict valueForKey:defultKey] isEqualToString:[styleDict valueForKey:defultKey]] && ![defultKey isEqualToString:@"LGFFreePTSuperViewHeight"]) {
            NSString *demo = @"";
            if ([defultKey isEqualToString:@"setlgf_ImageNames"]) {
                demo = @"style.lgf_SelectImageNames = @[@\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\", @\"tupian\"].mutableCopy;\nstyle.lgf_UnSelectImageNames = @[@\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\", @\"tupian_un\"].mutableCopy;";
                if ([demoArray containsObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"]) {
                    [demoArray removeObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"];
                }
                [demoArray addObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"];
            } else if ([defultKey isEqualToString:@"setlgf_LineImageName"]) {
                demo = @"style.lgf_LineImageName = @\"line_image\";";
                if ([demoArray containsObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"]) {
                    [demoArray removeObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"];
                }
                [demoArray addObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"];
            } else if ([defultKey isEqualToString:@"lgf_TitleSelectFont"] || [defultKey isEqualToString:@"lgf_UnTitleSelectFont"] || [defultKey isEqualToString:@"lgf_SubTitleSelectFont"] || [defultKey isEqualToString:@"lgf_UnSubTitleSelectFont"]) {
                demo = [NSString stringWithFormat:@"style.%@ = [UIFont systemFontOfSize:%@];", defultKey, [styleDict valueForKey:defultKey]];
            } else if ([defultKey isEqualToString:@"lgf_TitleSelectColor"] || [defultKey isEqualToString:@"lgf_UnSubTitleSelectColor"] || [defultKey isEqualToString:@"lgf_SubTitleSelectColor"] || [defultKey isEqualToString:@"lgf_TitleBackgroundColor"] || [defultKey isEqualToString:@"lgf_LineColor"] || [defultKey isEqualToString:@"lgf_TitleBorderColor"] || [defultKey isEqualToString:@"lgf_PVTitleViewBackgroundColor"]) {
                demo = [NSString stringWithFormat:@"style.%@ = LGFPTHexColor(@\"%@\");", defultKey, [styleDict valueForKey:defultKey]];
            } else {
                demo = [NSString stringWithFormat:@"style.%@ = %@;", defultKey, [styleDict valueForKey:defultKey]];
            }
            [demoArray addObject:demo];
        }
    }];
    
    if (![styleDict[@"setlgf_ImageNames"] boolValue]) {
        if (![demoArray containsObject:@"style.lgf_LineImageName = @\"line_image\";"]) {
            [demoArray removeObject:@"style.lgf_ImageBundel = lgf_Bundle(@\"LGFFreePTDemo\");"];
        }
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_TopImageSpace", [styleDict valueForKey:@"lgf_TopImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_TopImageWidth", [styleDict valueForKey:@"lgf_TopImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_TopImageHeight", [styleDict valueForKey:@"lgf_TopImageHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_BottomImageSpace", [styleDict valueForKey:@"lgf_BottomImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_BottomImageWidth", [styleDict valueForKey:@"lgf_BottomImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_BottomImageHeight", [styleDict valueForKey:@"lgf_BottomImageHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LeftImageSpace", [styleDict valueForKey:@"lgf_LeftImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LeftImageWidth", [styleDict valueForKey:@"lgf_LeftImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LeftImageHeight", [styleDict valueForKey:@"lgf_LeftImageHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_RightImageSpace", [styleDict valueForKey:@"lgf_RightImageSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_RightImageWidth", [styleDict valueForKey:@"lgf_RightImageWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_RightImageHeight", [styleDict valueForKey:@"lgf_RightImageHeight"]]];
    }
    
    if (![styleDict[@"lgf_IsShowLine"] boolValue]) {
        [demoArray removeObject:@"style.lgf_LineImageName = @\"line_image\";"];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineAnimation", [styleDict valueForKey:@"lgf_LineAnimation"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineCornerRadius", [styleDict valueForKey:@"lgf_LineCornerRadius"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = @\"%@\";", @"lgf_LineColor", [styleDict valueForKey:@"lgf_LineColor"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineWidth", [styleDict valueForKey:@"lgf_LineWidth"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineCenterX", [styleDict valueForKey:@"lgf_LineCenterX"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineHeight", [styleDict valueForKey:@"lgf_LineHeight"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineBottom", [styleDict valueForKey:@"lgf_LineBottom"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineAlpha", [styleDict valueForKey:@"lgf_LineAlpha"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineAnimation", [styleDict valueForKey:@"lgf_LineAnimation"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_LineWidthType", [styleDict valueForKey:@"lgf_LineWidthType"]]];
    }
    if (![styleDict[@"lgf_IsDoubleTitle"] boolValue]) {
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = [UIFont systemFontOfSize:%@];", @"lgf_SubTitleSelectFont", [styleDict valueForKey:@"lgf_SubTitleSelectFont"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = [UIFont systemFontOfSize:%@];", @"lgf_UnSubTitleSelectFont", [styleDict valueForKey:@"lgf_UnSubTitleSelectFont"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = @\"%@\";", @"lgf_UnSubTitleSelectColor", [styleDict valueForKey:@"lgf_UnSubTitleSelectColor"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = @\"%@\";", @"lgf_SubTitleSelectColor", [styleDict valueForKey:@"lgf_SubTitleSelectColor"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_SubTitleTransformSX", [styleDict valueForKey:@"lgf_SubTitleTransformSX"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_SubTitleTransformTY", [styleDict valueForKey:@"lgf_SubTitleTransformTY"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_SubTitleTransformTX", [styleDict valueForKey:@"lgf_SubTitleTransformTX"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_SubTitleTopSpace", [styleDict valueForKey:@"lgf_SubTitleTopSpace"]]];
        [demoArray removeObject:[NSString stringWithFormat:@"style.%@ = %@;", @"lgf_IsLineAlignSubTitle", [styleDict valueForKey:@"lgf_IsLineAlignSubTitle"]]];
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
