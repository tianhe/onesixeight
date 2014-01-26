//
//  OSELogHoursViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/25/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSELogHoursViewController.h"

@interface OSELogHoursViewController ()

@property UILabel *loggedHoursLabel;
@property UIButton *plusButton;
@property UIButton *minusButton;

@end

@implementation OSELogHoursViewController

- (id)initWithGoal:(Goal *)goal
{
    self = [super init];
    if (self) {
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

    UILabel *nameLabel = [UILabel standardFullLabel];
    nameLabel.text = self.goal.name;
    nameLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    [nameLabel setOriginAtX:20 andY:40];
    [self.view addSubview:nameLabel];

    UILabel *targetHoursLabel = [UILabel standardFullLabel];
    targetHoursLabel.text = [NSString stringWithFormat:@"Target %@ Hours", [self.goal.targetHours stringValue]];
    targetHoursLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    [targetHoursLabel setOriginAtX:20 andY:80];
    [self.view addSubview:targetHoursLabel];

    self.loggedHoursLabel = [UILabel bigLabel];
    [self.loggedHoursLabel setOriginAtX:20 andY:140];
    self.loggedHoursLabel.text = [self.goal.loggedHours stringValue];
    [self.view addSubview:self.loggedHoursLabel];
    
    self.minusButton = [UIButton solidHalfButton];
    [self.minusButton setTitle:@"- 0.5 hours" forState:UIControlStateNormal];
    [self.minusButton setOriginAtX:20 andY:250];
    [self.minusButton addTarget:self action:@selector(minusThirty:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.minusButton];
    
    self.plusButton = [UIButton solidHalfButton];
    [self.plusButton setTitle:@"+ 0.5 hours" forState:UIControlStateNormal];
    [self.plusButton setOriginAtX:180 andY:250];
    [self.plusButton addTarget:self action:@selector(addThirty:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.plusButton];
    
    UIButton *button = [UIButton standardButton];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    [button setOriginAtX:20 andY:330];
    [button addTarget:self action:@selector(logGoal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *quitButton = [UIButton standardRedButton];
    [quitButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [quitButton setOriginAtX:20 andY:390];
    [quitButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self _updatePlusMinusButtonStates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks - first responders
- (void)logGoal:(id)target
{
    if(!self.goal) return;
        
    self.goal.loggedHours = [NSDecimalNumber decimalNumberWithString:self.loggedHoursLabel.text];

    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)target
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)addThirty:(id)target
{
    NSDecimalNumber *displayLoggedHours = [NSDecimalNumber decimalNumberWithString:self.loggedHoursLabel.text];
    float newLoggedHours =  [displayLoggedHours floatValue] + 0.5f;
    NSString *loggedHours = [NSString stringWithFormat:@"%0.1f", newLoggedHours];
    self.loggedHoursLabel.text = loggedHours;
    
    [self _updatePlusMinusButtonStates];
}

- (void)minusThirty:(id)target
{
    NSDecimalNumber *displayLoggedHours = [NSDecimalNumber decimalNumberWithString:self.loggedHoursLabel.text];
    float newLoggedHours =  [displayLoggedHours floatValue] - 0.5f;
    NSString *loggedHours = [NSString stringWithFormat:@"%0.1f", newLoggedHours];
    self.loggedHoursLabel.text = loggedHours;

    [self _updatePlusMinusButtonStates];
}

#pragma marks - private methods
- (void)_updatePlusMinusButtonStates
{
    self.minusButton.hidden = NO;
    self.plusButton.hidden = NO;
    
    NSDecimalNumber *loggedHoursLabel = [NSDecimalNumber decimalNumberWithString:self.loggedHoursLabel.text];
    if([loggedHoursLabel isEqualToValue:self.goal.targetHours]){
        self.plusButton.hidden = YES;
    } else if ([loggedHoursLabel isEqualToNumber:@0]){
        self.minusButton.hidden = YES;
    }
}

@end


