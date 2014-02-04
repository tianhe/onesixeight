//
//  OSEPlanViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/20/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEPlanViewController.h"
#import "OSESaveGoalViewController.h"
#import "OSEPlanCell.h"

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.tableView registerClass:[OSEPlanCell class] forCellReuseIdentifier:@"planGoalCellIdentifier"];
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
    
    self.fetchedGoals = [self.goalsManager fetchGoalsFromWeekStarting:self.dateManager.date];
    
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
    OSESaveGoalViewController *goalController = [[OSESaveGoalViewController alloc] initWithDateManager:self.dateManager
                                                                                          goalsManager:self.goalsManager];
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
    OSEPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[OSEPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", goal.name];
    
    float targetHours = [goal.targetHours floatValue];
    cell.hoursInfoLabel.text = [NSString stringWithFormat:@"%0.0f", targetHours];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goal *goal = [self.fetchedGoals objectAtIndex:indexPath.row];
    
    OSESaveGoalViewController *goalController = [[OSESaveGoalViewController alloc] initWithDateManager:self.dateManager
                                                                                          goalsManager:self.goalsManager];
    goalController.goal = goal;
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
    NSString *totalHours = [NSString stringWithFormat:@"Planned (%d%%)", [sum intValue]*100/168];
    self.navigationItem.title = totalHours;
}

- (void)_removeGoalAtIndexPath:(NSIndexPath *)indexPath
{
    [self.goalsManager removeGoal:self.fetchedGoals[indexPath.row]];
    [self.fetchedGoals removeObjectAtIndex:indexPath.row];
}

@end
