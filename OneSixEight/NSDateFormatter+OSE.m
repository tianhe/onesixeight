//
//  NSDateFormatter+OSE.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "NSDateFormatter+OSE.h"

@implementation NSDateFormatter (OSE)

+ (NSDateFormatter *)standardDateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    
    return dateFormatter;
}
@end
