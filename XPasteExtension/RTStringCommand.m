//
//  RTStringCommand.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/9.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RTStringCommand.h"

@implementation RTStringCommand

- (BOOL)isValid
{
    return super.isValid && [[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[NSPasteboardTypeString]];
}

- (NSString *)replacementString
{
    NSMutableString *string = [[[NSPasteboard generalPasteboard] stringForType:NSPasteboardTypeString] mutableCopy];
    [string replaceOccurrencesOfString:@"\\" withString:@"\\\\" options:0 range:NSMakeRange(0, string.length)];
    [string replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:0 range:NSMakeRange(0, string.length)];
    [string replaceOccurrencesOfString:@"\n" withString:@"\\n" options:0 range:NSMakeRange(0, string.length)];
    return string.copy;
}

@end
