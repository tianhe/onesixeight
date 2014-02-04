//
//  Note.h
//  OneSixEight
//
//  Created by Tian Y He on 2/3/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * date;

@end
