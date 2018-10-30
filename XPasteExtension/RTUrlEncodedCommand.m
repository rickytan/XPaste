//
//  RTUrlEncodedCommand.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/30.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <JavascriptCore/JavaScriptCore.h>

#import "RTUrlEncodedCommand.h"

@implementation RTUrlEncodedCommand
{
    JSContext   * _context;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _context = [[JSContext alloc] init];
    }
    return self;
}

- (BOOL)isValid
{
    return super.isValid && [[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[NSPasteboardTypeString]];
}

- (NSString *)replacementString
{
    NSString *string = [[NSPasteboard generalPasteboard] stringForType:NSPasteboardTypeString];
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        string = [[_context evaluateScript:[NSString stringWithFormat:@"encodeURI(\"%@\")", string]] toString];
        return string;
    }
    return string;
}

@end
