//
//  OSENotesManager.h
//  OneSixEight
//
//  Created by Tian Y He on 2/3/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface OSENotesManager : NSObject

@property NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSMutableArray *)fetchAll;

- (Note *)addNoteWithDate:(NSDate *)date;
- (Note *)saveNote:(Note *)note withText:(NSString *)text;

@end
