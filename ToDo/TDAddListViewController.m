//
//  TDAddListViewController.m
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "TDAddListViewController.h"

#import "TDLocal.h"
#import "TDLocalInterface.h"

@interface TDAddListViewController ()

@end

@implementation TDAddListViewController{
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
    [self pr_initialDataSetup];
}

#pragma mark - Private API

- (void)pr_initialDataSetup{
    if(_listInfo){
        _nameTextField.text = _listInfo.name;
        _messageTextField.text = _listInfo.message;
        _datePickerProperty.date = [dateFormatter dateFromString:_listInfo.expirationDate];
    }
}


#pragma mark - Button Action API

- (IBAction)dismissKeyboard:(id)sender {
}

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveBtn:(id)sender {
    if(![_nameTextField.text isEqualToString:@""]){
    if(_listInfo){
        [self pr_updateWithExistingListInfo];
    }
    else{
        [self pr_createListInfo];
    }
    }
    else{
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Caution:" message:@"Don't go with Emptie Name?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
    }
}


- (void)pr_updateWithExistingListInfo{
    NSString *existingListName  = self.listInfo.name;
    [self.listInfo setName:_nameTextField.text];
    [self.listInfo setMessage:_messageTextField.text];

    [self.listInfo setExpirationDate:[dateFormatter stringFromDate:_datePickerProperty.date]];
    [[TDLocal defaultLocalDB]update:self.listInfo withExistingName:existingListName :^(BOOL succeeded){
        if(succeeded){
            NSLog(@"Successfully updated New values");
            [self CancelBtn:nil];
        }
    }];
}

- (void)pr_createListInfo{
    TDListInfo *listInfo = [[TDListInfo alloc]init];
    [listInfo setName:_nameTextField.text];
    [listInfo setMessage:_messageTextField.text];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [listInfo setExpirationDate:[dateFormatter stringFromDate:_datePickerProperty.date]];
    [listInfo setCreationDate:[dateFormatter stringFromDate:[NSDate date]]];
    [[TDLocal defaultLocalDB] create:listInfo :^(BOOL succeeded){
        if(succeeded){
            NSLog(@"List has been Created!");
            [self CancelBtn:Nil];
            }
            else{
                UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Issue:" message:@"Could not create a List" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [errorAlert show];
            }
        }];
}
@end
