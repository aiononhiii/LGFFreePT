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

@end

@implementation StyleDemoViewController

lgf_SBViewControllerForM(StyleDemoViewController, @"Main", @"StyleDemoViewController");

- (void)viewDidLoad {
    [super viewDidLoad];
    self.styleDemoText.textContainer.lineFragmentPadding = 0;
    self.styleDemoText.textContainerInset = UIEdgeInsetsMake(30, 15, 30, 15);
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
  @{@"text" : @"LGFPTHexColor", @"color" : @"A96941"},
  @{@"text" : @"@\"tupian\"", @"color" : @"D0232D"},
  @{@"text" : @"@\"tupian_un\"", @"color" : @"D0232D"},
  @{@"text" : @"@\"LGFFreePTDemo\"", @"color" : @"D0232D"}]];
    
    
}

@end
