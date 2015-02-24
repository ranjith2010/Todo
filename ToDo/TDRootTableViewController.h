//
//  ViewController.h
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDRootTableViewController : UITableViewController

@property(nonatomic,strong)NSMutableArray *listDataSource;

#pragma mark - Test Case

- (void)fetchList;
- (void)deleteList:(NSString*)listName :(void(^)(BOOL succeeded))block;

@end

