//
//  RTJSONCommand.m
//  XPasteExtension
//
//  Created by Ricky on 2018/11/2.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RTJSONCommand.h"
#import "RTObjCLiteral.h"

@implementation RTJSONCommand

- (BOOL)isValid
{
    return super.isValid && [[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[NSPasteboardTypeString]];
}

- (NSString *)replacementString
{
    NSString *jsonString = [[NSPasteboard generalPasteboard] stringForType:NSPasteboardTypeString];
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                              options:0
                                                error:&error];
    if (error == nil) {
        return [json toLiteralStringWithIndention:self.invocation.buffer.selections.firstObject.start.column];
    }
    return @"";
}

@end
