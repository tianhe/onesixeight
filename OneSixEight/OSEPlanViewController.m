//
//  OSEPlanViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/20/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEPlanViewController.h"
#import "OSESaveGoalViewController.h"
#import "OSEPlanTableViewCell.h"

@interface OSEPlanViewController ()

@end

@implementation OSEPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Plan";
        self.tabBarItem.title = @"Plan";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    float height = [UIScreen mainScreen].bounds.size.height - 60 - 60 - 100;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,40,[UIScreen mainScreen].bounds.size.width,height)];
    [self.tableView registerClass:[OSEPlanTableViewCell class] forCellReuseIdentifier:@"planGoalCellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.totalLabel = [UILabel standardFullLabel];
    float y = height + 40 + 20;
    [self.totalLabel setOriginAtX:20 andY:y];
    [self.view addSubview:self.totalLabel];

    UIButton *addButton = [UIButton standardButton];
    [addButton setTitle:@"New Goal" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(createNewGoal:) forControlEvents:UIControlEventTouchUpInside];
    y = [UIScreen mainScreen].bounds.size.height - 40 - 60;
    [addButton setOriginAtX:20 andY:y];
    [self.view addSubview:addButton];    
}

- (void)viewWillAppear:(BOOL)animated
{
    OSEAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedGoals = [appDelegate getAllGoals];
    
    NSNumber *sum = [self.fetchedGoals valueForKeyPath:@"@sum.targetHours"];
    NSString *totalHours = [NSString stringWithFormat:@"Planned Hours:   %d of 168 (%d%%)", [sum intValue], [sum intValue]*100/168];
    self.totalLabel.text = totalHours;    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - responders
- (void)createNewGoal:(id)target
{
    OSESaveGoalViewController *goalController = [[OSESaveGoalViewController alloc] init];
    [self presentViewController:goalController animated:YES completion:nil];
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
    static NSString *cellIdentifier = @"planGoalCellIdentifier";
    OSEPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[OSEPlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", goal.name];
    
    float targetHours = [goal.targetHours floatValue];
    NSString *string= [NSString stringWithFormat:@"%0.0f", targetHours];
    
    cell.hoursInfoLabel.text = string;
    cell.hoursInfoLabel.textAlignment = NSTextAlignmentRight;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    
    OSESaveGoalViewController *goalController = [[OSESaveGoalViewController alloc] initWithGoal:goal];
    [self presentViewController:goalController animated:YES completion:nil];
}

@end
