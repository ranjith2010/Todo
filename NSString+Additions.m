//
//  NSString+Additions.m
//  ToDo
//
//  Created by Ranjith on 24/02/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)isEmpty {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}

@end
