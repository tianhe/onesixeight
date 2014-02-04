//
//  OSENotesManager.m
//  OneSixEight
//
//  Created by Tian Y He on 2/3/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSENotesManager.h"

@implementation OSENotesManager

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    self = [super init];
    if (self) {
        self.managedObjectContext = managedObjectContext;
    }
    return self;
}

- (NSMutableArray *)fetchAll
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    request.entity = entity;

    NSError *error;
    NSArray *fetchedNotes = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return [NSMutableArray arrayWithArray:fetchedNotes];
}

- (Note *)addNoteWithDate:(NSDate *)date
{
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    note.date = date;
    
    NSError *error;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"%@", error.description);
    }
    
    return note;
}

- (Note *)saveNote:(Note *)note withText:(NSString *)text
{
    note.text = text;
    
    NSError *error;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"%@", error.description);
    }
    return note;
}

@end
