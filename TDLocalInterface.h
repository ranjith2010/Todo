//
//  TDLocalInterface.h
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDListInfo.h"

@protocol TDLocalInterface <NSObject>

- (void)create:(TDListInfo*)listInfo :(void(^)(BOOL succeeded))block;
- (void)update:(TDListInfo*)listInfo withExistingName:(NSString*)existingName :(void(^)(BOOL succeeded))block;
- (void)fetch:(void(^)(NSMutableArray* arrayOfList))block;
- (void)deleteList:(NSString*)listName :(void(^)(BOOL succeeded))block;
@end
