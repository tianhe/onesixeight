//
//  OSEPlanViewController.h
//  OneSixEight
//
//  Created by Tian Y He on 1/20/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEBaseViewController.h"

@interface OSEPlanViewController : OSEBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property UITableView *tableView;
@property UILabel *totalLabel;
@end
