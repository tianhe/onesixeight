//
//  OSEPlanViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
// 

#import "OSEPlanViewController.h"

@interface OSEPlanViewController ()

@property UITextField *startDateField;
@property UITextField *targetHoursField;
@property UITextField *nameField;
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
    UILabel *nameLabel = [UILabel standardLabel];
    nameLabel.text = @"Name";
    [nameLabel setOriginAtX:20 andY:40];
    [self.view addSubview:nameLabel];
    
    self.nameField = [UITextField standardTextField];
    [self.nameField setOriginAtX:140 andY:40];
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
    [self.view addSubview:self.targetHoursField];
    
    UIButton *button = [UIButton standardButton];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    [button setOriginAtX:20 andY:220];
    [button addTarget:self action:@selector(addGoal:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addGoal:(id)sender
{
    Goal *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    newEntry.startDate = [self.dateFormatter dateFromString:self.startDateField.text];
    newEntry.endDate = [newEntry.startDate dateByAddingTimeInterval:7*24*60*60];
    newEntry.targetHours = [NSDecimalNumber decimalNumberWithString:self.targetHoursField.text];
    newEntry.name = self.nameField.text;

    NSLog(@"Date for locale %@: %@",
          [[self.dateFormatter locale] localeIdentifier], [self.dateFormatter stringFromDate:newEntry.startDate]);

    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    self.startDateField.text = @"";
    self.targetHoursField.text = @"";
    self.nameField.text = @"";

    [self.view endEditing:YES];
}

@end
