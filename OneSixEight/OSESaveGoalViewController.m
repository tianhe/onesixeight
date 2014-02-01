//
//  OSEPlanViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
// 

#import "OSESaveGoalViewController.h"

@interface OSESaveGoalViewController ()

@property UITextField *targetHoursField;
@property UITextField *nameField;
@property NSDate *date;

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

- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self){
        self.date = date;
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
    
    UILabel *targetHoursLabel = [UILabel standardLabel];
    targetHoursLabel.text = @"Target Hours";
    [targetHoursLabel setOriginAtX:20 andY:100];
    [self.view addSubview:targetHoursLabel];

    self.targetHoursField = [UITextField standardTextField];
    [self.targetHoursField setOriginAtX:140 andY:100];
    self.targetHoursField.text = [self.goal.targetHours stringValue];
    [self.view addSubview:self.targetHoursField];
    
    UIButton *button = [UIButton standardButton];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    [button setOriginAtX:20 andY:220];
    [button addTarget:self action:@selector(saveGoal:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];

    UIButton *cancelButton = [UIButton standardRedButton];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setOriginAtX:20 andY:280];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks - first responders

- (void)saveGoal:(id)sender
{
    if (!self.goal){
        self.goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                  inManagedObjectContext:self.managedObjectContext];
    }
    
    self.goal.startDate = self.date;
    self.goal.endDate = [self.date dateByAddingTimeInterval:7*24*60*60];
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

- (void)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
