//
//  OSECheckViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSECheckViewController.h"
#import "OSECheckTableViewCell.h"

@interface OSECheckViewController ()

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
    OSEAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedGoals = [appDelegate getAllGoals];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView setOriginAtX:0 andY:40];
    [self.tableView registerClass:[OSECheckTableViewCell class] forCellReuseIdentifier:@"checkGoalCellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedGoals count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"checkGoalCellIdentifier";
    OSECheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[OSECheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", goal.name];
    
    float loggedHours = [goal.loggedHours floatValue];
    float targetHours = [goal.targetHours floatValue];
    NSString *string = [NSString stringWithFormat:@"%0.0f/%0.0f (%0.0f%%)", loggedHours, targetHours, loggedHours/targetHours*100 ];
    
    cell.hoursInfoLabel.text = string;

    return cell;
}

@end
