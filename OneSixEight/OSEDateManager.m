//
//  OSEWeekManager.m
//  OneSixEight
//
//  Created by Tian Y He on 2/1/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEDateManager.h"

@implementation OSEDateManager

- (id) initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.date = date;
    }
    return self;
}
@end
