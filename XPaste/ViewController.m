//
//  ViewController.m
//  XPaste
//
//  Created by Ricky on 2018/10/8.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (weak) IBOutlet NSButton *caseButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"cn.rickytan.XPaste.defaults"];
    [self.userDefaults registerDefaults:@{@"UnicodeUpperCase": @YES}];
    [self.userDefaults synchronize];
    
    self.caseButton.state = [self.userDefaults boolForKey:@"UnicodeUpperCase"] ? NSControlStateValueOn : NSControlStateValueOff;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)onEnable:(id)sender {
    system("open -b com.apple.systempreferences /System/Library/PreferencePanes/Extensions.prefPane");
}

- (IBAction)onHelp:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/rickytan/XPaste"]];
}

- (IBAction)onUnicodeCase:(id)sender {
    [self.userDefaults setBool:((NSButton *)sender).state == NSControlStateValueOn
                        forKey:@"UnicodeUpperCase"];
}

@end

