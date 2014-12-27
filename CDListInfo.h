//
//  CDListInfo.h
//  ToDo
//
//  Created by Ranjith on 23/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDListInfo : NSManagedObject

@property (nonatomic, retain) NSString * creationDate;
@property (nonatomic, retain) NSString * expirationDate;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * name;

@end
