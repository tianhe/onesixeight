//
//  OSESaveNoteViewController.h
//  OneSixEight
//
//  Created by Tian Y He on 2/3/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEBaseViewController.h"
#import "Note.h"
#import "OSENotesManager.h"

@interface OSESaveNoteViewController : OSEBaseViewController

- (id)initWithNote:(Note *)note andNotesManager:(OSENotesManager *)notesManager;
- (id)initWithDateManager:(OSEDateManager *)dateManager andNotesManager:(OSENotesManager *)notesManager;

@end
