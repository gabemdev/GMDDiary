//
//  DiaryViewController.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "DiaryViewController.h"
#import "DiaryEntryViewController.h"
#import "DiaryEntry.h"
#import "DetailViewController.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController

- (instancetype)init {
    if ((self = [super init])) {
        self.editing = NO;
        [_tableView reloadData];
    }
    return self;
}

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray new];
    _descriptionArray = [NSMutableArray new];
    self.editing = NO;

    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[GMDTrackingService sharedInstance] trackEvent:@"Table View Viewed" withValue:nil fromSender:@"DiaryViewController"];
    [[GMDTrackingService sharedInstance] trackScreen:@"DiaryViewController"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark - UITableViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    DiaryEntry *entry = [_titleArray objectAtIndex:indexPath.row];
    DiaryEntry *desc = [_descriptionArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = entry.titleString;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_titleArray removeObjectAtIndex:indexPath.row];
        [_descriptionArray removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *titleItem = [_titleArray objectAtIndex:sourceIndexPath.row];
    [_titleArray removeObject:titleItem];
    [_titleArray insertObject:titleItem atIndex:destinationIndexPath.row];
    
    NSString *descriptionItem = [_descriptionArray objectAtIndex:sourceIndexPath.row];
    [_descriptionArray removeObject:descriptionItem];
    [_descriptionArray insertObject:descriptionItem atIndex:destinationIndexPath.row];
    
    [_tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editing == NO || !indexPath)
    {
        return UITableViewCellEditingStyleNone;
    }
    
    if (self.editing && indexPath.row == _titleArray.count)
    {
        return UITableViewCellEditingStyleInsert;
    }
    
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}


#pragma mark - Actions
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"button"]) {
        UINavigationController *navController = segue.destinationViewController;
        DiaryEntryViewController *entryVV = [[navController viewControllers] objectAtIndex:0];
        entryVV.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"detail"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.titleString = [_titleArray objectAtIndex:_tableView.indexPathForSelectedRow.row];
//        detailVC.descriptionString = [_descriptionArray objectAtIndex:_tableView.indexPathForSelectedRow.row];
    }
    
    
}
- (IBAction)onAddButtonTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"button" sender:sender];
}

- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender {
    if (self.editing) {
        self.editing = NO;
        [self.tableView setEditing:NO animated:NO];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.tableView setEditing:YES animated:NO];
        sender.title = @"Done";
        sender.style = UIBarButtonItemStylePlain;
    }
    [_tableView reloadData];
}

#pragma mark - Helper Methods
+ (DiaryViewController *)sharedInstance {
    static DiaryViewController *instance = nil;
    if (!instance) {
        instance = [[DiaryViewController alloc] init];
    }
    return instance;
}

#pragma mark - Delegate
- (void)entryDetailedViewControllerDidCancel:(DiaryEntryViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)entryDetailedViewController:(DiaryEntryViewController *)controller didAddEntry:(DiaryEntry *)entry withDescription:(DiaryEntry *)description {
    [_titleArray addObject:entry];
    [_descriptionArray addObject:description];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_titleArray count] - 1 inSection:0];
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
