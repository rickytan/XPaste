//
//  RTBaseCommand.h
//  XPasteExtension
//
//  Created by Ricky on 2018/10/9.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>
#import "RTUtilities.h"

@interface RTBaseCommand : NSObject <XCSourceEditorCommand>
@property (nonatomic, readonly) XCSourceEditorCommandInvocation *invocation;
@property (nonatomic, readonly) void (^completionHandler)(NSError *);
@property (nonatomic, readonly, getter=isValid) BOOL valid;
@property (nonatomic, readonly) NSRange bufferSelectionRange;

- (void)execute;

// Override me!
- (NSString *)replacementString;

@end
