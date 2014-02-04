//
//  Goal.h
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Goal : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * startDate;
@property (nonatomic, retain) NSDecimalNumber * targetHours;
@property (nonatomic, retain) NSDecimalNumber * loggedHours;

- (void)copyGoalFromGoal:(Goal *)goal withStartDate:(NSDate *)date;

@end
