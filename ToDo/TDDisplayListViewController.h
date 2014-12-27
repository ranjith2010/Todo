//
//  LDDisplayListViewController.h
//  ToDo
//
//  Created by Ranjith on 22/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDListInfo.h"

@interface TDDisplayListViewController : UIViewController{
    IBOutlet UIScrollView *scroller;
}
@property(nonatomic,strong)TDListInfo *listInfo;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;

@end
