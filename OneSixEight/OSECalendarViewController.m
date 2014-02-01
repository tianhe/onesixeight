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
    [previousWeekButton setTitle:@"Last Week" forState:UIControlStateNormal];
    [previousWeekButton addTarget:self action:@selector(previousWeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousWeekButton];
    
    UIButton *nextWeekButton = [UIButton standardQuarterButton];
    [previousWeekButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    float x = [UIScreen mainScreen].bounds.size.width - 20 - nextWeekButton.frame.size.width;
    [nextWeekButton setOriginAtX:x andY:50];
    [nextWeekButton setTitle:@"Next Week" forState:UIControlStateNormal];
    [nextWeekButton addTarget:self action:@selector(nextWeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextWeekButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    [self _updateDate];
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

#pragma mark - private methods

- (void)_updateDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *date = [formatter stringFromDate:self.dateManager.date];
    self.dateLabel.text = date;
}


@end
