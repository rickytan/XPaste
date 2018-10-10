//
//  ViewController.m
//  XPaste
//
//  Created by Ricky on 2018/10/8.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak) IBOutlet NSButton *caseButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UnicodeUpperCase": @YES}];
    
    self.caseButton.state = [[NSUserDefaults standardUserDefaults] boolForKey:@"UnicodeUpperCase"] ? NSControlStateValueOn : NSControlStateValueOff;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)onEnable:(id)sender {
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Preference" withExtension:@"scpt"]
                                                                   error:nil];
    [script executeAndReturnError:nil];
}

- (IBAction)onHelp:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/rickytan/XPaste"]];
}

- (IBAction)onUnicodeCase:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:((NSButton *)sender).state == NSControlStateValueOn
                                            forKey:@"UnicodeUpperCase"];
}

@end

