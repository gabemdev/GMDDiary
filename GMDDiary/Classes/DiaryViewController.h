//
//  DiaryViewController.h
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryEntryViewController.h"

@interface DiaryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, DiaryEntryViewControllerDelegate>

+ (DiaryViewController *)sharedInstance;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *titleArray;
@property (nonatomic) NSMutableArray *descriptionArray;
@property(nonatomic, retain) NSString *category;

- (id)initWithCategory:(NSString *)category;

@end
