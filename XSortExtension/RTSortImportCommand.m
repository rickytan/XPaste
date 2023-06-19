//
//  SourceEditorCommand.m
//  XSortExtension
//
//  Created by Ricky on 2022/2/25.
//  Copyright © 2022 XcoderTips. All rights reserved.
//

#import "RTSortImportCommand.h"

#define IMPORT_ALLOW_CHAR   "[\\w/.+\\- ]"

@implementation RTSortImportCommand

- (NSString *)normalizedImportLine:(NSString *)line {
    static NSRegularExpression * exp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        exp = [NSRegularExpression regularExpressionWithPattern:@"(//)?\\s*#\\s*import\\s*([\"<]" IMPORT_ALLOW_CHAR "+[\">])\\s*"
                                                        options:NSRegularExpressionCaseInsensitive
                                                          error:NULL];
    });
    return [exp stringByReplacingMatchesInString:line
                                         options:0
                                           range:NSMakeRange(0, line.length)
                                    withTemplate:@"$1#import $2"];
}

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    NSMutableArray <NSString *> *quoteImportLines = [NSMutableArray arrayWithCapacity:17];
    NSMutableArray <NSString *> *bracketsImportLines = [NSMutableArray arrayWithCapacity:17];
    
    NSMutableIndexSet *lineIndexSet = [NSMutableIndexSet indexSet];
    NSString *p = @"(//)?\\s*#\\s*import\\s*\"" IMPORT_ALLOW_CHAR "+\"\\s*";
    NSRegularExpression *importPatternQuote = [NSRegularExpression regularExpressionWithPattern:p
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:NULL];
    NSRegularExpression *importPatternBrackets = [NSRegularExpression regularExpressionWithPattern:@"(//)?\\s*#\\s*import\\s*<" IMPORT_ALLOW_CHAR "+>\\s*"
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:NULL];
    NSRegularExpression *swiftImportPattern = [NSRegularExpression regularExpressionWithPattern:@"(//)?\\s*import\\s*" IMPORT_ALLOW_CHAR "+\\s*"
                                                                                        options:NSRegularExpressionCaseInsensitive
                                                                                          error:NULL];
    NSRegularExpression *ifPattern = [NSRegularExpression regularExpressionWithPattern:@"\\s*#\\s*if"
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:NULL];
    NSRegularExpression *endIfPattern = [NSRegularExpression regularExpressionWithPattern:@"\\s*#\\s*endif"
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:NULL];
    __block NSInteger firstImportLine = -1;
    __block NSInteger ifdefCount = 0;
    [invocation.buffer.lines enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = NSMakeRange(0, obj.length);
        if ([ifPattern firstMatchInString:obj options:0 range:range] != nil) {
            ifdefCount ++;
        }
        if ([endIfPattern firstMatchInString:obj options:0 range:range] != nil) {
            ifdefCount --;
        }
        
        if (ifdefCount == 0 && [importPatternQuote firstMatchInString:obj options:0 range:range] != nil) {
            [quoteImportLines addObject:[self normalizedImportLine:obj]];
            [lineIndexSet addIndex:idx];
            if (firstImportLine < 0) {
                firstImportLine = idx;
            }
        }
        if (ifdefCount == 0 && [importPatternBrackets firstMatchInString:obj options:0 range:range] != nil) {
            [bracketsImportLines addObject:[self normalizedImportLine:obj]];
            [lineIndexSet addIndex:idx];
            if (firstImportLine < 0) {
                firstImportLine = idx;
            }
        }
        if (ifdefCount == 0 && [swiftImportPattern firstMatchInString:obj options:0 range:range] != nil) {
            [bracketsImportLines addObject:[self normalizedImportLine:obj]];
            [lineIndexSet addIndex:idx];
            if (firstImportLine < 0) {
                firstImportLine = idx;
            }
        }
    }];
    if (lineIndexSet.count > 0) {
        [invocation.buffer.lines removeObjectsAtIndexes:lineIndexSet];
        
        NSComparisonResult(^block)(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) = ^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
            return [[obj1 substringFromIndex:[obj1 rangeOfString:@"import"].location] compare:[obj2 substringFromIndex:[obj2 rangeOfString:@"import"].location]
                                                                                      options:NSCaseInsensitiveSearch];
        };
        [bracketsImportLines sortUsingComparator:block];
        [quoteImportLines sortUsingComparator:block];
        
        [invocation.buffer.lines insertObjects:quoteImportLines
                                     atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(firstImportLine, quoteImportLines.count)]];
        if (quoteImportLines.count > 0) {
            [invocation.buffer.lines insertObject:@"" atIndex:firstImportLine];
        }
        
        [invocation.buffer.lines insertObjects:bracketsImportLines
                                     atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(firstImportLine, bracketsImportLines.count)]];
    }
    completionHandler(nil);
}

@end
