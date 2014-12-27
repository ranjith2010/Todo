//
//  TDListInfo.h
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDListInfo : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *creationDate;
@property(nonatomic,strong)NSString *expirationDate;

@end
