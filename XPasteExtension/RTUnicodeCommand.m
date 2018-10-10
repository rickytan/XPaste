//
//  RTUnicodeCommand.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/9.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RTUnicodeCommand.h"

@implementation RTUnicodeCommand

- (BOOL)isValid
{
    return super.isValid && [[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[NSPasteboardTypeString]];
}

- (NSString *)replacementString
{
    BOOL upperCase = [self.userDefaults boolForKey:@"UnicodeUpperCase"];
    
    NSString *string = [[NSPasteboard generalPasteboard] stringForType:NSPasteboardTypeString];

    NSMutableString *newString = [NSMutableString stringWithCapacity:string.length];
    [NSApplication sharedApplication];
    uint32 ch = 0;
    NSRange remainingRange = NSMakeRange(0, string.length);
    while (remainingRange.length > 0) {
        [string getBytes:&ch
               maxLength:sizeof(ch)
              usedLength:NULL
                encoding:NSUTF32StringEncoding
                 options:0
                   range:NSMakeRange(remainingRange.location, string.length - remainingRange.location)
          remainingRange:&remainingRange];
        if (ch > 0xffff) {
            if (upperCase)
                [newString appendFormat:@"\\U%08X", ch];
            else
                [newString appendFormat:@"\\U%08x", ch];
        }
        else if (ch > 0x7f) {
            if (upperCase)
                [newString appendFormat:@"\\u%04X", ch];
            else
                [newString appendFormat:@"\\u%04x", ch];
        }
        else {
            [newString appendFormat:@"%c", ch];
        }
    }
    return newString.copy;
}

@end
