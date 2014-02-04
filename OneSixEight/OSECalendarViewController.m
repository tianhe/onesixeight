//
//  OSECalendarViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 2/1/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSECalendarViewController.h"

@interface OSECalendarViewController ()

@property UILabel *dateLabel;
@property UILabel *goalsLabel;
@property UILabel *targetHoursLabel;
@property UILabel *loggedHoursLabel;

@end

@implementation OSECalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Calendar";
        self.tabBarItem.title = @"Calendar";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.dateLabel = [UILabel standardLabel];
    [self.dateLabel setOriginAtX:115 andY:50];
    [self.view addSubview:self.dateLabel];
    
    UIButton *previousWeekButton = [UIButton standardQuarterButton];
    [previousWeekButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [previousWeekButton setOriginAtX:20 andY:50];
    [previousWeekButton setTitle:@"<<" forState:UIControlStateNormal];
    previousWeekButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [previousWeekButton addTarget:self action:@selector(previousWeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousWeekButton];
    
    UIButton *nextWeekButton = [UIButton standardQuarterButton];
    [previousWeekButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    float x = [UIScreen mainScreen].bounds.size.width - 20 - nextWeekButton.frame.size.width;
    [nextWeekButton setOriginAtX:x andY:50];
    [nextWeekButton setTitle:@">>" forState:UIControlStateNormal];
    nextWeekButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [nextWeekButton addTarget:self action:@selector(nextWeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextWeekButton];
    
    self.goalsLabel = [UILabel standardFullLabel];
    [self.goalsLabel setOriginAtX:20 andY:110];
    [self.view addSubview:self.goalsLabel];
    
    self.targetHoursLabel = [UILabel standardFullLabel];
    [self.targetHoursLabel setOriginAtX:20 andY:150];
    [self.view addSubview:self.targetHoursLabel];
    
    self.loggedHoursLabel = [UILabel standardFullLabel];
    [self.loggedHoursLabel setOriginAtX:20 andY:190];
    [self.view addSubview:self.loggedHoursLabel];
    
    UIButton *copyButton = [UIButton standardButton];
    [copyButton setOriginAtX:20 andY:250];
    [copyButton setTitle:@"Copy Plan From Last Week" forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copyPlanFromLastWeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:copyButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.fetchedGoals = [self.goalsManager fetchGoalsFromWeekStarting:self.dateManager.date];
    [self _updateDate];
    [self _updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - first responder

- (void)previousWeek:(id)target
{
    self.dateManager.date = [self.dateManager.date dateByAddingTimeInterval:-7*24*60*60];
    [self viewWillAppear:YES];
}

- (void)nextWeek:(id)target
{
    self.dateManager.date = [self.dateManager.date dateByAddingTimeInterval:7*24*60*60];
    [self viewWillAppear:YES];
}

- (void)copyPlanFromLastWeek:(id)target
{
    NSDate *lastWeek = [self.dateManager.date dateByAddingTimeInterval:-7*24*60*60];
    NSArray *fetchedGoals = [self.goalsManager fetchGoalsFromWeekStarting:lastWeek];
    for(Goal *goal in fetchedGoals){
        Goal *newGoal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                      inManagedObjectContext:goal.managedObjectContext];
        [newGoal copyGoalFromGoal:goal withStartDate:self.dateManager.date];
    }
    
    [self viewWillAppear:YES];
}

#pragma mark - private methods

- (void)_updateDate
{
    NSDateFormatter *formatter = [NSDateFormatter standardDateFormat];    
    NSString *date = [formatter stringFromDate:self.dateManager.date];
    self.dateLabel.text = date;
}

- (void)_updateLabels
{
    self.goalsLabel.text = [NSString stringWithFormat:@"Num of Goals: %d", self.fetchedGoals.count];
    float targetHours = [[self.fetchedGoals valueForKeyPath:@"@sum.targetHours"] floatValue];
    float loggedHours = [[self.fetchedGoals valueForKeyPath:@"@sum.loggedHours"] floatValue];
    self.targetHoursLabel.text = [NSString stringWithFormat:@"Target Hours: %0.1f", targetHours];
    self.loggedHoursLabel.text = [NSString stringWithFormat:@"Logged Hours: %0.1f", loggedHours];
}

@end
