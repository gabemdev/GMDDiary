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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _titleString;
    _textView.text = _descriptionString;
    
    NSLog(@"Detail View Showed");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}



@end
