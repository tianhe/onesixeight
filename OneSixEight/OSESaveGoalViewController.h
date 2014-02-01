//
//  OSEPlanViewController.h
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEBaseViewController.h"

@interface OSESaveGoalViewController : OSEBaseViewController

- (id)initWithGoal:(Goal *)goal;
- (id)initWithDate:(NSDate *)date;

@property Goal *goal;

@end
