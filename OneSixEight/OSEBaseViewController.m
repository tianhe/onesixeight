    //
//  OSEBaseViewController.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEBaseViewController.h"

@interface OSEBaseViewController ()

@end

@implementation OSEBaseViewController

- (id)initWithDateManager:(OSEDateManager *)dateManager goalsManager:(OSEGoalsManager *)goalsManager
{
    self = [super init];
    if (self) {
        self.dateManager = dateManager;
        self.goalsManager = goalsManager;
        self.dateFormatter = [NSDateFormatter standardDateFormat];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dateFormatter = [NSDateFormatter standardDateFormat];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
