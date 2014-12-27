//
//  CDListInfo+Additions.m
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CDListInfo+Additions.h"

@implementation CDListInfo (Additions)

+ (TDListInfo*)CDListToTDListConvertion:(CDListInfo*)CDListInfo{
    TDListInfo *newTDListInfo = [[TDListInfo alloc]init];
    [newTDListInfo setName:CDListInfo.name];
    [newTDListInfo setMessage:CDListInfo.message];
    [newTDListInfo setCreationDate:CDListInfo.creationDate];
    [newTDListInfo setExpirationDate:CDListInfo.expirationDate];
    return newTDListInfo;
}
@end
