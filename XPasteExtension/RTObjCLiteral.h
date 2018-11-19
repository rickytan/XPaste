//
//  RTObjCLiteral.h
//  XPasteExtension
//
//  Created by Ricky on 2018/11/2.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RTObjCLiteral <NSObject>
- (NSString *)toLiteralString;
- (NSString *)toLiteralStringWithIndention:(NSInteger)numberOfSpaces;
@end

@interface NSObject (Literal) <RTObjCLiteral>
@end

@interface NSString (Literal) <RTObjCLiteral>
+ (NSString *)rt_stringWithSpaces:(NSInteger)count;
@end

@interface NSNumber (Literal) <RTObjCLiteral>
@end

@interface NSNull (Literal) <RTObjCLiteral>
@end

@interface NSArray (Literal) <RTObjCLiteral>
@end

@interface NSDictionary (Literal) <RTObjCLiteral>
@end
