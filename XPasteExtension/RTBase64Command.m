//
//  RTBase64Command.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/8.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RTBase64Command.h"
#import "RTUtilities.h"

@implementation RTBase64Command
{
    XCSourceEditorCommandInvocation         * _invocation;
    void (^_completionHandler)(NSError *);
}

- (void)_doPaste:(NSData *)data
{
    NSRange range = RTCompleteBufferSelectionRange(_invocation.buffer);
    if (range.location != NSNotFound) {
        if (data) {
            NSString *base64String = [data base64EncodedStringWithOptions:0];
            _invocation.buffer.completeBuffer = [_invocation.buffer.completeBuffer stringByReplacingCharactersInRange:range
                                                                                                           withString:base64String];
            _completionHandler(nil);
        }
        else {
            _completionHandler([NSError errorWithDomain:RTXPasteErrorDomain
                                                   code:-1
                                               userInfo:@{NSLocalizedDescriptionKey: @"Data is empty!"}]);
        }
    } else {
        _completionHandler([NSError errorWithDomain:RTXPasteErrorDomain
                                               code:-1
                                           userInfo:@{NSLocalizedDescriptionKey: @"Multiple selection range not supported!"}]);
    }
}

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError *))completionHandler
{
    _invocation = invocation;
    _completionHandler = completionHandler;
    
    
    if ([[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[(NSString *)kUTTypeImage]]) {
        NSData *data = [[NSPasteboard generalPasteboard] dataForType:NSPasteboardTypeTIFF];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:data];
        NSData *pngData = [imageRep representationUsingType:NSPNGFileType
                                                 properties:@{}];
        [self _doPaste:pngData];
    }
    else if ([[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[NSPasteboardTypeString]]) {
        NSData *data = [[NSPasteboard generalPasteboard] dataForType:NSPasteboardTypeString];
        [self _doPaste:data];
    }
    else {
        completionHandler(nil);
    }
}

#pragma mark - Actions

@end
