//
//  OSEImproveViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSENotesViewController.h"

@interface OSENotesViewController ()

@property UITableView *tableView;
@property OSENotesManager *notesManager;

@end

@implementation OSENotesViewController

- (id)initWithDateManager:(OSEDateManager *)dateManager notesManager:(OSENotesManager *)notesManager
{
    self = [super init];
    if (self) {
        self.dateManager = dateManager;
        self.notesManager = notesManager;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Notes";
        self.tabBarItem.title = @"Notes";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClass:[OSENoteCell class] forCellReuseIdentifier:@"notesCellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewNote:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationItem.title = [NSString stringWithFormat:@"Notes (%d)", [self.notesManager fetchAll].count];    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notesManager fetchAll].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"notesCellIdentifier";
    OSENoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[OSENoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *notes = [self.notesManager fetchAll];
    
    Note *note = notes[indexPath.row];
    cell.textLabel.text = note.text;

    NSDateFormatter *dateFormatter = [NSDateFormatter standardDateFormat];
    NSString *dateLabel = [dateFormatter stringFromDate:note.date];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", dateLabel];
    
    return cell;
}

#pragma marks - first responder

- (void)createNewNote:(id)target
{
    OSESaveNoteViewController *newNoteVC = [[OSESaveNoteViewController alloc] initWithDateManager:self.dateManager andNotesManager:self.notesManager];
    [self.navigationController pushViewController:newNoteVC animated:YES];
}

@end
