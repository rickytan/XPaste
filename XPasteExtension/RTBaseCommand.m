//
//  RTBaseCommand.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/9.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import "RTBaseCommand.h"

@interface RTBaseCommand ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation RTBaseCommand

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"cn.rickytan.XPaste.defaults"];
    }
    return self;
}

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError *))completionHandler
{
    _invocation = invocation;
    _completionHandler = completionHandler;
    
    [self execute];
}

- (BOOL)isValid
{
    return self.invocation.buffer.selections.count == 1;
}

- (NSRange)bufferSelectionRange
{
    return RTCompleteBufferSelectionRange(self.invocation.buffer);
}

- (void)execute
{
    NSRange range = RTCompleteBufferSelectionRange(self.invocation.buffer);
    if (range.location != NSNotFound && self.isValid) {
        NSString *string = self.replacementString;
        if  (string.length > 0) {
            self.invocation.buffer.completeBuffer = [self.invocation.buffer.completeBuffer stringByReplacingCharactersInRange:range
                                                                                                                   withString:string];
        }
    }
    self.completionHandler(nil);
}

- (NSString *)replacementString
{
    return nil;
}

@end
