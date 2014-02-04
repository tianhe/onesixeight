//
//  OSEImproveViewController.h
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEBaseViewController.h"
#import "OSENotesManager.h"
#import "OSENoteCell.h"
#import "OSESaveNoteViewController.h"

@interface OSENotesViewController : OSEBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithDateManager:(OSEDateManager *)dateManager notesManager:(OSENotesManager *)notesManager;

@end
