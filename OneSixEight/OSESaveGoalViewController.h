//
//  OSEPlanViewController.h
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSEBaseViewController.h"

@interface OSESaveGoalViewController : OSEBaseViewController

- (id)initWithGoal:(Goal *)goal;

@property Goal *goal;

@end