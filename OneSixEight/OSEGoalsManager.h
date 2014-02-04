//
//  OSEGoalsManager.h
//  OneSixEight
//
//  Created by Tian Y He on 2/1/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goal.h"

@interface OSEGoalsManager : NSObject

@property NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSMutableArray *)fetchAllGoals;
- (NSMutableArray *)fetchGoalsFromWeekStarting:(NSDate *)date;
- (NSArray *)fetchAllStartDates;

- (Goal *)addGoalWithDate:(NSDate *)date;
- (Goal *)saveGoal:(Goal *)goal withTargetHours:(NSDecimalNumber *)targetHours name:(NSString *)name;
- (void)removeGoal:(Goal *)goal;

@end
