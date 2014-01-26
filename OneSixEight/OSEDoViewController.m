//
//  OSEDoViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEDoViewController.h"
#import "OSELogHoursViewController.h"
#import "OSELogHoursCell.h"

@interface OSEDoViewController ()

@end

@implementation OSEDoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Do";
        self.tabBarItem.title = @"Do";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    float height = [UIScreen mainScreen].bounds.size.height - 60;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,40,[UIScreen mainScreen].bounds.size.width,height)];
    [self.tableView registerClass:[OSELogHoursCell class] forCellReuseIdentifier:@"logHoursCellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    OSEAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedGoals = [appDelegate getAllGoals];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - responders
- (void)logHours:(id)target
{
    OSELogHoursViewController *logHoursController = [[OSELogHoursViewController alloc] init];
    [self presentViewController:logHoursController animated:YES completion:nil];
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
    static NSString *cellIdentifier = @"logHoursCellIdentifier";
    OSELogHoursCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[OSELogHoursCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", goal.name];
    
    float loggedHours = [goal.loggedHours floatValue];
    float targetHours = [goal.targetHours floatValue];
    NSString *string = [NSString stringWithFormat:@"%0.0f/%0.0f (%0.0f%%)", loggedHours, targetHours, loggedHours/targetHours*100 ];
    cell.hoursInfoLabel.text = string;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    
    OSELogHoursViewController *goalController = [[OSELogHoursViewController alloc] initWithGoal:goal];
    [self presentViewController:goalController animated:YES completion:nil];
}

@end
