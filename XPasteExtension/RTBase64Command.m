//
//  RTBase64Command.m
//  XPasteExtension
//
//  Created by Ricky on 2018/10/8.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "RTBase64Command.h"

@implementation RTBase64Command

- (BOOL)isValid
{
    return super.isValid && [[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[(NSString *)kUTTypeImage, NSPasteboardTypeString]];
}

- (NSString *)replacementString
{
    if ([[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[(NSString *)kUTTypeImage]]) {
        NSData *data = [[NSPasteboard generalPasteboard] dataForType:NSPasteboardTypeTIFF];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:data];
        NSData *pngData = [imageRep representationUsingType:NSPNGFileType
                                                 properties:@{}];
        if (pngData) {
            return [pngData base64EncodedStringWithOptions:0];
        }
    }
    else if ([[NSPasteboard generalPasteboard] canReadItemWithDataConformingToTypes:@[NSPasteboardTypeString]]) {
        NSData *data = [[NSPasteboard generalPasteboard] dataForType:NSPasteboardTypeString];
        return [data base64EncodedStringWithOptions:0];
    }
    return nil;
}

#pragma mark - Actions

@end
