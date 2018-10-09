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
    NSMutableString *string = [[[NSPasteboard generalPasteboard] stringForType:NSPasteboardTypeString] mutableCopy];
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"[\\u007f-\\uffff]"
                                                                                options:NSRegularExpressionCaseInsensitive | NSRegularExpressionUseUnicodeWordBoundaries
                                                                                  error:NULL];
    NSArray <NSTextCheckingResult *> *matches = [expression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    [matches enumerateObjectsWithOptions:NSEnumerationReverse
                              usingBlock:^(NSTextCheckingResult * obj, NSUInteger idx, BOOL * stop) {
                                  NSRange range = obj.range;
                                  unichar ch = [string characterAtIndex:range.location];
                                  [string replaceCharactersInRange:range
                                                        withString:[NSString stringWithFormat:@"\\u%04x", ch]];
                              }];
    return string.copy;
}

@end
