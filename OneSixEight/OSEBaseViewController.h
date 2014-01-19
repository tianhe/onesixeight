//
//  OSEBaseViewController.h
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goal.h"
#import "OSEAppDelegate.h"
#import "NSDateFormatter+OSE.h"
#import "UITextField+OSE.h"
#import "UIView+OSE.h"
#import "UILabel+OSE.h"
#import "UIButton+OSE.h"

@interface OSEBaseViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSDateFormatter *dateFormatter;

@end
