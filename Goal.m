//
//  Goal.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//
//  http://www.codigator.com/tutorials/ios-core-data-tutorial-with-example/

#import "Goal.h"
#import "NSDateFormatter+OSE.h"

@implementation Goal

@dynamic name;
@dynamic startDate;
@dynamic targetHours;
@dynamic loggedHours;

- (void)copyGoalFromGoal:(Goal *)goal withStartDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter standardDateFormat];
    self.startDate = [dateFormatter stringFromDate:date];
    self.targetHours = goal.targetHours;
    self.name = goal.name;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
