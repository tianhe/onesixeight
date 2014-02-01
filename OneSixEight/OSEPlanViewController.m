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

@property UITableView *tableView;
@property UILabel *totalLabel;
@property UILabel *dateLabel;

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
    self.view.backgroundColor = [UIColor orangeColor];
    
	// Do any additional setup after loading the view.
    float height = [UIScreen mainScreen].bounds.size.height-20;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,height) style:UITableViewStylePlain];
    [self.tableView registerClass:[OSEPlanTableViewCell class] forCellReuseIdentifier:@"planGoalCellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //Edit Button
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Add Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewGoal:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    OSEAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedGoals = [appDelegate fetchGoalsFromWeekStarting:self.dateManager.date];
    
    [self _updateTotals];
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
    OSESaveGoalViewController *goalController = [[OSESaveGoalViewController alloc] initWithDate:self.dateManager.date];
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
    NSString *string = [NSString stringWithFormat:@"%0.0f", targetHours];
    cell.hoursInfoLabel.text = string;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    
    OSESaveGoalViewController *goalController = [[OSESaveGoalViewController alloc] initWithGoal:goal];
    [self presentViewController:goalController animated:YES completion:nil];
}

//Edit Controls
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.editing || !indexPath) {
        return UITableViewCellEditingStyleNone;
    }
    
    if (self.editing && indexPath.row == [self.fetchedGoals count]) {
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self _removeGoalAtIndexPath:indexPath];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [self.tableView reloadData];
        [self _updateTotals];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    [self.tableView reloadData];

    if (editing){
        // Change views to edit mode.
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
    }
    else {
        // Save the changes if needed and change the views to noneditable.
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
    }
}

#pragma marks - private methods
- (void)_updateTotals
{
    NSNumber *sum = [self.fetchedGoals valueForKeyPath:@"@sum.targetHours"];
    NSString *totalHours = [NSString stringWithFormat:@"%d%% Planned", [sum intValue]*100/168];
    self.navigationItem.title = totalHours;
}

- (void)_removeGoalAtIndexPath:(NSIndexPath *)indexPath
{
    [self.managedObjectContext deleteObject:self.fetchedGoals[indexPath.row]];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self.fetchedGoals removeObjectAtIndex:indexPath.row];
}

@end
