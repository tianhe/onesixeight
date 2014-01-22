//
//  OSEPlanViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
// 

#import "OSESaveGoalViewController.h"

@interface OSESaveGoalViewController ()

@property UITextField *startDateField;
@property UITextField *targetHoursField;
@property UITextField *nameField;

@end

@implementation OSESaveGoalViewController

- (id)initWithGoal:(Goal *)goal
{
    self = [super init];
    if (self){
        self.goal = goal;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *nameLabel = [UILabel standardLabel];
    nameLabel.text = @"Name";
    [nameLabel setOriginAtX:20 andY:40];
    [self.view addSubview:nameLabel];
    
    self.nameField = [UITextField standardTextField];
    [self.nameField setOriginAtX:140 andY:40];
    self.nameField.text = self.goal.name;
    [self.view addSubview:self.nameField];
    
    UILabel *startDateLabel = [UILabel standardLabel];
    startDateLabel.text = @"Start Date";
    [startDateLabel setOriginAtX:20 andY:100];
    [self.view addSubview:startDateLabel];

    self.startDateField = [UITextField standardTextField];
    [self.startDateField setOriginAtX:140 andY:100];
    [self.view addSubview:self.startDateField];
    
    UILabel *targetHoursLabel = [UILabel standardLabel];
    targetHoursLabel.text = @"Target Hours";
    [targetHoursLabel setOriginAtX:20 andY:160];
    [self.view addSubview:targetHoursLabel];

    self.targetHoursField = [UITextField standardTextField];
    [self.targetHoursField setOriginAtX:140 andY:160];
    self.targetHoursField.text = [self.goal.targetHours stringValue];
    [self.view addSubview:self.targetHoursField];
    
    UIButton *button = [UIButton standardHalfButton];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    [button setOriginAtX:20 andY:220];
    [button addTarget:self action:@selector(saveGoal:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];

    UIButton *quitButton = [UIButton standardHalfButton];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [quitButton setOriginAtX:200 andY:220];
    [quitButton addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveGoal:(id)sender
{
    if (!self.goal){
        self.goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                  inManagedObjectContext:self.managedObjectContext];
    }
    
    self.goal.startDate = [self.dateFormatter dateFromString:self.startDateField.text];
    self.goal.endDate = [self.goal.startDate dateByAddingTimeInterval:7*24*60*60];
    self.goal.targetHours = [NSDecimalNumber decimalNumberWithString:self.targetHoursField.text];
    self.goal.name = self.nameField.text;

    NSLog(@"Date for locale %@: %@",
          [[self.dateFormatter locale] localeIdentifier], [self.dateFormatter stringFromDate:self.goal.startDate]);

    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)quit:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
