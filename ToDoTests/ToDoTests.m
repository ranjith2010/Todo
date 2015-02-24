//
//  ToDoTests.m
//  ToDoTests
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TDListInfo.h"
#import "TDAddListViewController.h"
#import "TDRootTableViewController.h"


@interface ToDoTests : XCTestCase{
    TDListInfo *listInfo;
    TDAddListViewController *addListVC;
    TDRootTableViewController *rootTVC;
}

@end

@implementation ToDoTests

- (void)setUp {
    [super setUp];
    addListVC = [[TDAddListViewController alloc]init];
    listInfo = [[TDListInfo alloc]init];
    rootTVC  = [[TDRootTableViewController alloc]init];
    [listInfo setName:@"Have a Tea"];
    [listInfo setMessage:@"Going for Tea with Ramesh"];
    [listInfo setExpirationDate:@"Today @7pm"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - CRUD Process with List

- (void)testCheckWitListHasData{
    BOOL isItValidList=[addListVC initialDataCheckUp:listInfo];
    XCTAssertTrue(isItValidList,@"List is not Created");
}

- (void)testStoreListIntoCoredata{
    [addListVC saveList:listInfo :^(BOOL succeeded){
        XCTAssertTrue(succeeded,@"List is not Stored into Coredata");
    }];
}

- (void)testFetchAllList{
    [rootTVC fetchList];
}

- (void)testDeleteList{
    [rootTVC deleteList:listInfo.name :^(BOOL succedeed){
        XCTAssertTrue(succedeed,@"Delete is not done");
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
