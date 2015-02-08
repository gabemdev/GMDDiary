//
//  DiaryEntryViewController.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "DiaryEntryViewController.h"
#import "DiaryEntry.h"

@interface DiaryEntryViewController ()


@end

@implementation DiaryEntryViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    _diaryDescription.layer.masksToBounds = YES;
    _diaryDescription.layer.borderColor = [UIColor GMDKitColorWithHex:@"3B7ADA"].CGColor;
    _diaryDescription.layer.borderWidth = 1.0f;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[GMDTagService sharedInstance] pushOpenWithScreen:@"DiaryEntryViewController"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor GMDKitColorWithHex:@"4C4C4C"]];
}


#pragma mark - Actions
- (IBAction)onSaveTapped:(id)sender {
    if (([_diaryTitle.text length] == 0) | ([_diaryDescription.text length] == 0)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"Please make sure you enter a title and a description"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        DiaryEntry *entry = [[DiaryEntry alloc] init];
        entry.titleString = _diaryTitle.text;
        
        DiaryEntry *description = [[DiaryEntry alloc] init];
        description.descriptionString = _diaryDescription.text;
        
        [self.delegate entryDetailedViewController:self didAddEntry:entry withDescription:description];
    }
}

- (IBAction)onCancelTapped:(id)sender {
    [self.delegate entryDetailedViewControllerDidCancel:self];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[GMDTagService sharedInstance] pushCloseWithScreen:@"DiaryEntryViewController"];
}
@end
