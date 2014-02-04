//
//  OSECheckViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSECheckViewController.h"
#import "OSECheckCell.h"

@interface OSECheckViewController ()

@property NSArray *startDates;

@end

@implementation OSECheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Check";
        self.tabBarItem.title = @"Check";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView setOriginAtX:0 andY:0];
    [self.tableView registerClass:[OSECheckCell class] forCellReuseIdentifier:@"checkGoalCellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.startDates = [[self.goalsManager fetchAllStartDates] valueForKey:@"startDate"];
    [self.tableView reloadData];
    self.navigationItem.title = [NSString stringWithFormat:@"%d Weeks", self.startDates.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.startDates count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"checkGoalCellIdentifier";
    OSECheckCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[OSECheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *week = self.startDates[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", week];

    NSDateFormatter *dateFormatter = [NSDateFormatter standardDateFormat];
    NSDate *startDate = [dateFormatter dateFromString:week];
    NSArray *goals = [self.goalsManager fetchGoalsFromWeekStarting:startDate];
    
    float loggedHours = [[goals valueForKeyPath:@"@sum.loggedHours"] floatValue];
    float targetHours = [[goals valueForKeyPath:@"@sum.targetHours"] floatValue];
    
    NSString *string = [NSString stringWithFormat:@"%0.0f (%0.0f%%)", loggedHours, loggedHours/targetHours*100 ];
    
    cell.hoursInfoLabel.text = string;

    return cell;
}

@end
