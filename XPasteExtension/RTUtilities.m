//
//  RTUtilities.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/9.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

#import "RTUtilities.h"

NSString * const RTXPasteErrorDomain = @"cn.rickytan.xpaste";

NSRange RTCompleteBufferSelectionRange(XCSourceTextBuffer *buffer) {
    if (buffer.selections.count == 1) {
        XCSourceTextRange *range = buffer.selections.firstObject;
        
        NSUInteger offsetStart = 0;
        for (NSInteger i = 0; i < range.start.line; ++i) {
            offsetStart += buffer.lines[i].length;
        }
        offsetStart += range.start.column;
        
        NSUInteger offsetEnd = 0;
        for (NSInteger i = 0; i < range.end.line; ++i) {
            offsetEnd += buffer.lines[i].length;
        }
        offsetEnd += range.end.column;
        
        return NSMakeRange(offsetStart, offsetEnd - offsetStart);
    }
    
    return NSMakeRange(NSNotFound, 0);
}
