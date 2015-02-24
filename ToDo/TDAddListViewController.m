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
#import "NSString+Additions.h"

@interface TDAddListViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerProperty;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtnProperty;

@property (nonatomic,strong) id<TDLocalInterface> caller;

@end

@implementation TDAddListViewController{
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Here No need to call the defaultLocalDB all the time.
    // Just trigger once and get the instance of localDB and set into the Property.
    self.caller = [TDLocal defaultLocalDB];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [scroller setScrollEnabled:YES];
   // [scroller setContentSize:CGSizeMake(320, 800)];
    [self initialDataCheckUp:self.listInfo];
}

#pragma mark - Belongs to TestCase

- (BOOL)initialDataCheckUp:(TDListInfo*)listInfo{
    if(listInfo && ![listInfo.name isEqualToString:@""]){
        _nameTextField.text = listInfo.name;
        _messageTextField.text = listInfo.message;
        _datePickerProperty.date = [dateFormatter dateFromString:listInfo.expirationDate];
        return YES;
    }
    else{
        return NO;
    }
}

- (void)saveList:(TDListInfo*)listInfo :(void(^)(BOOL succeeded))block{
    [self.caller create:listInfo :^(BOOL succeeded){
        if(succeeded){
            block(succeeded);
            [self CancelBtn:Nil];
        }
    }];
}

#pragma mark -

#pragma mark - Button Action API

- (IBAction)dismissKeyboard:(id)sender {
}

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtn:(id)sender {
    NSString *errorMsg = Nil;
    if([_nameTextField.text isEmpty]) {
        errorMsg = @"Don't go with Emptie Name?";
    }
    else if ([self.messageTextField.text isEmpty]) {
        errorMsg = @"Don't go with Emptie Message?";
    }
    if(errorMsg) {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error:" message:errorMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
        return;
    }
    if(self.listInfo) {
        [self pr_updateWithExistingListInfo];
    }
    else {
        [self pr_createListInfo];
    }
}




- (void)pr_updateWithExistingListInfo{
    NSString *existingListName  = self.listInfo.name;
    [self.listInfo setName:_nameTextField.text];
    [self.listInfo setMessage:_messageTextField.text];

    [self.listInfo setExpirationDate:[dateFormatter stringFromDate:_datePickerProperty.date]];
    [self.caller update:self.listInfo withExistingName:existingListName :^(BOOL succeeded){
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
    [self.caller create:listInfo :^(BOOL succeeded){
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
