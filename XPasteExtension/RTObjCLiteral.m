//
//  RTObjCLiteral.m
//  XPasteExtension
//
//  Created by Ricky on 2018/11/2.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import "RTObjCLiteral.h"

@implementation NSObject (Literal)

- (NSString *)toLiteralString
{
    return [NSString stringWithFormat:@"@\"%@\"", self.description];
}

- (NSString *)toLiteralStringWithIndention:(NSInteger)numberOfSpaces
{
    return [[NSString rt_stringWithSpaces:numberOfSpaces] stringByAppendingString:[self toLiteralString]];
}

@end

@implementation NSString (Literal)

+ (NSString *)rt_stringWithSpaces:(NSInteger)count
{
    return [@"" stringByPaddingToLength:count withString:@" " startingAtIndex:0];
}

- (NSString *)toLiteralStringWithIndention:(NSInteger)numberOfSpaces
{
    return [self toLiteralString];
}

@end

@implementation NSNumber (Literal)

- (NSString *)toLiteralString
{
    return [NSString stringWithFormat:@"@%@", self.description];
}

@end

@implementation NSNull (Literal)

- (NSString *)toLiteralString
{
    return [NSString stringWithFormat:@"[NSNull null]"];
}

@end

@implementation NSArray (Literal)

- (NSString *)toLiteralString
{
    return [self toLiteralStringWithIndention:0];
}

- (NSString *)toLiteralStringWithIndention:(NSInteger)numberOfSpaces
{
    NSMutableArray <NSString *> *arr = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (idx == 0) {
            [arr addObject:[obj toLiteralStringWithIndention:numberOfSpaces + 2]];
        }
        else {
            NSString *keyString = [NSString stringWithFormat:@"%@%@", [NSString rt_stringWithSpaces:numberOfSpaces + 2], [obj toLiteralStringWithIndention:numberOfSpaces + 2]];
            [arr addObject:keyString];
        }
    }];
    return [NSString stringWithFormat:@"@[%@]", [arr componentsJoinedByString:@",\n"]];
}

@end

@implementation NSDictionary (Literal)

- (NSString *)toLiteralString
{
    return [self toLiteralStringWithIndention:0];
}

- (NSString *)toLiteralStringWithIndention:(NSInteger)numberOfSpaces
{
    NSMutableArray <NSString *> *arr = [NSMutableArray arrayWithCapacity:self.count];
    __block BOOL isFirst = YES;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        if (isFirst) {
            isFirst = NO;
            NSString *keyString = [key toLiteralString];
            // 2 个来自开头的 "@{"，2 个来自 ": "
            [arr addObject:[NSString stringWithFormat:@"%@: %@", keyString, [obj toLiteralStringWithIndention:numberOfSpaces + keyString.length + 4]]];
        }
        else {
            // 2 个来自开头的 "@{"
            NSString *keyString = [NSString stringWithFormat:@"%@%@", [NSString rt_stringWithSpaces:numberOfSpaces + 2], [key toLiteralString]];
            // 2 个来自 ": "
            [arr addObject:[NSString stringWithFormat:@"%@: %@", keyString, [obj toLiteralStringWithIndention:keyString.length + 2]]];
        }
    }];
    return [NSString stringWithFormat:@"@{%@}", [arr componentsJoinedByString:@",\n"]];
}

@end
