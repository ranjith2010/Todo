//
//  TDAddListViewController.h
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDListInfo.h"

@interface TDAddListViewController : UIViewController{
    IBOutlet UIScrollView *scroller;
}

@property(nonatomic,strong)TDListInfo *listInfo;

#pragma mark - Belongs to TestCase

- (BOOL)initialDataCheckUp:(TDListInfo*)listInfo;
- (void)saveList:(TDListInfo*)listInfo :(void(^)(BOOL succeeded))block;

@end
