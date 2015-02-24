//
//  TDCoreDataEngine.m
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "TDCoreDataEngine.h"
#import "TDCoreDataSharedInstance.h"
#import "TDListInfo.h"
#import "CDListInfo.h"
#import "TDConstants.h"
#import "CDListInfo+Additions.h"

@implementation TDCoreDataEngine{
    NSManagedObjectContext *moc;
}

+ (TDCoreDataEngine*)sharedInstance {
    static TDCoreDataEngine* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[TDCoreDataEngine alloc] init];
        
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    moc = [[TDCoreDataSharedInstance sharedInstance]managedObjectContext];
    return self;
}


- (void)create:(TDListInfo*)listInfo :(void(^)(BOOL succeeded))block{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:kListInfoEntityName
                                                      inManagedObjectContext:moc];
    CDListInfo *newCDListInfo = (CDListInfo*)[[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:moc];
    newCDListInfo.name = listInfo.name;
    newCDListInfo.message = listInfo.message;
    newCDListInfo.creationDate = listInfo.creationDate;
    newCDListInfo.expirationDate = listInfo.expirationDate;
    NSError *error = nil;
    // Here it simply saving the 'Coredata Context'
    if ([moc save:&error] == NO) {
        block(NO);
    }
    else{
        block(YES);
    }
}

- (void)update:(TDListInfo*)listInfo withExistingName:(NSString*)existingName :(void(^)(BOOL succeeded))block{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kListInfoEntityName inManagedObjectContext:moc]];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError * error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",existingName];
    [fetchRequest setPredicate:predicate];
    NSArray * arrayOfCDLists = [moc executeFetchRequest:fetchRequest error:&error];
    CDListInfo *cdlistInfo = [arrayOfCDLists firstObject];
    [cdlistInfo setName:listInfo.name];
    [cdlistInfo setMessage:listInfo.message];
    [cdlistInfo setExpirationDate:listInfo.expirationDate];
    if([moc save:&error] == NO){
        block(NO);
    }
    else{
        block(YES);
    }
}

- (void)fetch:(void(^)(NSMutableArray* arrayOfList))block{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kListInfoEntityName inManagedObjectContext:moc]];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError * error = nil;
    NSArray * arrayOfCDListInfo = [moc executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *returnArrayOfTDListInfo = [[NSMutableArray alloc]init];
    for(CDListInfo *cdList in arrayOfCDListInfo){
        [returnArrayOfTDListInfo addObject:[CDListInfo CDListToTDListConvertion:cdList]];
    }
    block(returnArrayOfTDListInfo);
}

- (void)deleteList:(NSString*)listName :(void(^)(BOOL succeeded))block{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kListInfoEntityName inManagedObjectContext:moc]];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError * error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",listName];
    [fetchRequest setPredicate:predicate];
    NSArray * arrayOfCDListInfo = [moc executeFetchRequest:fetchRequest error:&error];
    if(arrayOfCDListInfo.count){
    [moc deleteObject:[arrayOfCDListInfo firstObject]];
    }
    if([moc save:&error]==NO){
        block(NO);
    }
    else{
        block(YES);
    }
}

@end
