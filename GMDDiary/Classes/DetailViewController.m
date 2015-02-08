//
//  DetailViewController.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (instancetype)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = _titleStr;
    _textView.text = _descriptionString;
    
    NSLog(@"Title: %@, Description: %@", _titleStr, _descriptionString);
    
    NSLog(@"Detail View Showed");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}



@end
