//
//  NSDate+OSE.m
//  OneSixEight
//
//  Created by Tian Y He on 1/27/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "NSDate+OSE.h"

@implementation NSDate (OSE)

+ (NSDate *)thisSunday
{
    NSDate *today = [NSDate date];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [cal components:NSWeekdayCalendarUnit fromDate:today];
    int weekday = [comp weekday];
    
    NSDate *thisSunday = [today dateByAddingTimeInterval:-(weekday-1)*60*60*24];

    NSDateComponents *dateComp= [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:thisSunday];
    [dateComp setHour:0];
    [dateComp setMinute:0];
    [dateComp setSecond:0];
    
    return [cal dateFromComponents:dateComp];
}

@end
