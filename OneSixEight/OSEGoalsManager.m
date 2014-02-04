//
//  OSEGoalsManager.m
//  OneSixEight
//
//  Created by Tian Y He on 2/1/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEGoalsManager.h"
#import "NSDateFormatter+OSE.h"

@implementation OSEGoalsManager

- (id) initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    self = [super init];
    if (self) {
        self.managedObjectContext = managedObjectContext;
    }
    return self;
}

- (NSMutableArray *)fetchAllGoals
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];

    NSError *error;
    NSArray *fetchedGoals = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return [NSMutableArray arrayWithArray:fetchedGoals];
}

- (NSMutableArray *)fetchGoalsFromWeekStarting:(NSDate *)date
{
    NSString * startDate= [[NSDateFormatter standardDateFormat] stringFromDate:date];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"startDate == %@", startDate];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"targetHours" ascending:NO]];
    
    NSError *error;
    NSArray *fetchedGoals = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return [NSMutableArray arrayWithArray:fetchedGoals];
}

- (Goal *)addGoalWithDate:(NSDate *)date
{
    Goal *goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    goal.startDate = [[NSDateFormatter standardDateFormat] stringFromDate:date];
    
    NSError *error;
    [self.managedObjectContext save:&error];
    
    return goal;
}

- (Goal *)saveGoal:(Goal *)goal withTargetHours:(NSDecimalNumber *)targetHours name:(NSString *)name
{
    goal.targetHours = targetHours;
    goal.name = name;

    NSError *error;
    [self.managedObjectContext save:&error];
    
    return goal;
}

- (void)removeGoal:(Goal *)goal
{
    [self.managedObjectContext deleteObject:goal];
    NSError *error;
    [self.managedObjectContext save:&error];
}

- (NSArray *)fetchAllStartDates
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.propertiesToFetch = @[@"startDate"];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.returnsDistinctResults = YES;
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:NO]];
    
    NSError *error;
    NSArray *distinctStartDates = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return distinctStartDates;
}


@end
