//
//  DiaryEntryViewController.h
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DiaryEntryViewController;
@class DiaryEntry;

@protocol DiaryEntryViewControllerDelegate <NSObject>

- (void)entryDetailedViewControllerDidCancel:(DiaryEntryViewController *)controller;
- (void)entryDetailedViewController:(DiaryEntryViewController *)controller didAddEntry:(DiaryEntry *)entry withDescription:(DiaryEntry *)description;

@end

@interface DiaryEntryViewController : UIViewController
@property (nonatomic, weak) id <DiaryEntryViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *diaryTitle;
@property (weak, nonatomic) IBOutlet UITextField *diaryDescription;

- (IBAction)onSaveTapped:(id)sender;
- (IBAction)onCancelTapped:(id)sender;

@end
