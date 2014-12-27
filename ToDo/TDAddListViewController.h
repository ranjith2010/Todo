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

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerProperty;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtnProperty;

@end
