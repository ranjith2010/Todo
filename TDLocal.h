//
//  TDLocal.h
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLocal : NSObject

+(id) defaultLocalDB;
+(id) withCoreData:(NSString*)type;

@end
