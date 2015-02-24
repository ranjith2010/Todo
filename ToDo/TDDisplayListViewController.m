//
//  LDDisplayListViewController.m
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "TDDisplayListViewController.h"
#import "TDAddListViewController.h"
#import "TDLocal.h"
#import "TDLocalInterface.h"

@interface TDDisplayListViewController ()
@property (nonatomic,strong) id<TDLocalInterface> caller;

@end

@implementation TDDisplayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.caller = [TDLocal defaultLocalDB];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(pr_editButton)];
    self.navigationItem.rightBarButtonItem = editButton;
    [self pr_initialDataSetup];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.listInfo){
        [self.caller fetch:^(NSMutableArray *arrayOfLists){
            if(arrayOfLists.count){
                for(TDListInfo *listInfo in arrayOfLists){
                    if([listInfo.name isEqualToString:self.listInfo.name]){
                        self.listInfo = listInfo;
                        [self pr_initialDataSetup];
                    }
                }
            }
        }];
    }
}
#pragma mark - Private API

- (void)pr_initialDataSetup{
    if(_listInfo){
        self.nameLabel.text =self.listInfo.name;
        self.messageLabel.text = self.listInfo.message;
        self.expirationLabel.text = self.listInfo.expirationDate;
        self.creationDateLabel.text = self.listInfo.creationDate;
    }
}

- (void)pr_editButton{
    TDAddListViewController *addListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddListVC"];
    [addListVC setListInfo:self.listInfo];
    [self presentViewController:addListVC animated:YES completion:nil];
}

@end
