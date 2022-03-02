//
//  RTSortSelectedLinesCommand.m
//  XSortExtension
//
//  Created by Ricky on 2022/3/2.
//  Copyright © 2022 XcoderTips. All rights reserved.
//

#import "RTSortSelectedLinesCommand.h"

@implementation RTSortSelectedLinesCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSMutableArray <XCSourceTextRange *> *selections = invocation.buffer.selections;
    if (selections.count > 0) {
        XCSourceTextPosition start = selections.firstObject.start;
        XCSourceTextPosition end = selections.lastObject.end;
        NSInteger firstLine = start.line;
        NSInteger lastLine = end.line;

        NSArray <NSString *> *selectedLines = [invocation.buffer.lines subarrayWithRange:NSMakeRange(firstLine, lastLine - firstLine + 1)];
        selectedLines = [selectedLines sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        [invocation.buffer.lines replaceObjectsInRange:NSMakeRange(firstLine, lastLine - firstLine + 1)
                                  withObjectsFromArray:selectedLines];
        
        start.column = 0;
        end.column = invocation.buffer.lines[end.line].length;
        [selections removeAllObjects];
        [selections addObject:[[XCSourceTextRange alloc] initWithStart:start end:end]];
    }
    completionHandler(nil);
}

@end
