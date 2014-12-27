//
//  TDLocal.m
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "TDLocal.h"
#import "TDCoreDataEngine.h"

@implementation TDLocal

+(id) defaultLocalDB{
    return [TDLocal withCoreData:@"CoreData"];
}

+(id) withCoreData:(NSString*)type{
    if([type isEqual:@"CoreData"])
        return [TDCoreDataEngine sharedInstance];
    else
        return nil;
}
@end
