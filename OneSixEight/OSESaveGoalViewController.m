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
@property UIButton *saveButton;

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
    [nameLabel setOriginAtX:20 andY:60];
    [self.view addSubview:nameLabel];
    
    self.nameField = [UITextField standardTextField];
    [self.nameField setOriginAtX:140 andY:60];
    self.nameField.text = self.goal.name;
    self.nameField.delegate = self;
    [self.view addSubview:self.nameField];
    
    UILabel *targetHoursLabel = [UILabel standardLabel];
    targetHoursLabel.text = @"Target Hours";
    [targetHoursLabel setOriginAtX:20 andY:120];
    [self.view addSubview:targetHoursLabel];

    self.targetHoursField = [UITextField standardTextField];
    [self.targetHoursField setOriginAtX:140 andY:120];
    self.targetHoursField.text = [self.goal.targetHours stringValue];
    self.targetHoursField.delegate = self;
    [self.view addSubview:self.targetHoursField];
    
    self.saveButton = [UIButton standardButton];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton setOriginAtX:20 andY:220];
    [self.saveButton addTarget:self action:@selector(saveGoal:) forControlEvents:UIControlEventTouchUpInside];
    //self.saveButton.enabled = NO;
    
    [self.view addSubview:self.saveButton];

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
    NSDecimalNumber *targetHours = [NSDecimalNumber decimalNumberWithString:self.targetHoursField.text];

    if (!self.goal)
        self.goal = [self.goalsManager addGoalWithDate:self.dateManager.date];
        
    [self.goalsManager saveGoal:self.goal withTargetHours:targetHours name:self.nameField.text];
    
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma marks - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGRect frame = textField.frame;
//    float newWidth = [UIScreen mainScreen].bounds.size.width - 40;
//    textField.frame = CGRectMake(20, frame.origin.y, newWidth, frame.size.height);

    
//    if (!self.goal && ![textField.text isEqualToString:@""]){
//        self.saveButton.enabled = YES;
//
//    } else if (textField == self.nameField) {
//        if (![self.nameField.text isEqualToString:self.goal.name])
//            self.saveButton.enabled = YES;
//
//    } else if (textField == self.targetHoursField) {
//        NSString *hours = [NSString stringWithFormat:@"%0.1f", [self.goal.targetHours floatValue]];
//        if (![self.targetHoursField.text isEqualToString:hours])
//            self.saveButton.enabled = YES;
//    }
    
}

//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    CGRect frame = textField.frame;
//    textField.frame = CGRectMake(140, frame.origin.y, 160, frame.size.height);
//}
@end

