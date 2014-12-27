//
//  ViewController.m
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "TDRootTableViewController.h"
#import "TDAddListViewController.h"
#import "TDDisplayListViewController.h"

#import "TDLocal.h"
#import "TDLocalInterface.h"

@interface TDRootTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TDRootTableViewController{
    UIRefreshControl  *refreshControl;
    NSIndexPath *toDeleteIndexPath;
    NSDateFormatter *dateFormatter;
}
@synthesize listDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(pr_refreshTable) forControlEvents:UIControlEventValueChanged];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self pr_refreshTable];
    
}

#pragma mark - Private API

- (void)pr_refreshTable {
    [[TDLocal defaultLocalDB] fetch:^(NSMutableArray *arrayOfLocalList){
        if(arrayOfLocalList.count){
            self.listDataSource = arrayOfLocalList;
            [refreshControl endRefreshing];
            [self.tableView reloadData];
        }
    }];
   // [self pr_checkWithExpiration];
}

//- (void)pr_checkWithExpiration{
//    TDListInfo *listInfo = self.listDataSource[0];
//    NSDateFormatter *df = [[NSDateFormatter alloc]init];
//    [df setDateFormat:@"hh:mm a"];
//    NSArray *arrayOfStrings = [listInfo.expirationDate componentsSeparatedByString:@","];
//    if([arrayOfStrings[2] isEqualToString:@" 8:00 PM"]){
//        NSLog(@"matched");
//    }
//    
//    NSNumber *strikeSize = [NSNumber numberWithInt:2];
//    
//    NSDictionary *strikeThroughAttribute = [NSDictionary dictionaryWithObject:strikeSize
//                                                                       forKey:NSStrikethroughStyleAttributeName];
//    
//    NSAttributedString* strikeThroughText = [[NSAttributedString alloc] initWithString:@"Striking through it" attributes:strikeThroughAttribute];
//    listInfo.name = strikeThroughText;
//    NSLog(@"%@",strikeThroughText);
////    strikeThroughLabel.attributedText = strikeThroughText;
//    
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TDListInfo *listInfo = [listDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = listInfo.name;
    cell.detailTextLabel.text = listInfo.expirationDate;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDListInfo *listInfo = [self.listDataSource objectAtIndex:indexPath.row];
    TDDisplayListViewController *displayListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DisplayListVC"];
    [displayListVC setListInfo:listInfo];
    [self.navigationController pushViewController:displayListVC animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if ([tableView isEqual:self.tableView]){
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Confirmation"
                                                        message:@"Are you sure!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"Cancel",nil];
        toDeleteIndexPath = indexPath;
        [alert show];
    }
}

#pragma mark -


#pragma mark - Alert View Delegate API

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        if(toDeleteIndexPath.section==0){
            TDListInfo *listInfo = [self.listDataSource objectAtIndex:toDeleteIndexPath.row];
            [[TDLocal defaultLocalDB] deleteList:listInfo.name :^(BOOL succeeded){
                if(succeeded){
                    [self.listDataSource removeObjectAtIndex:toDeleteIndexPath.row];
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:toDeleteIndexPath]
                                          withRowAnimation:UITableViewRowAnimationFade];
                }
            }];
        }
    }
    else{
        [self.tableView reloadData];
    }
}

#pragma mark -

@end
