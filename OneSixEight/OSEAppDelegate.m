//
//  OSEAppDelegate.m
//  OneSixEight
//
//  Created by Tian Y He on 1/18/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEAppDelegate.h"
#import "OSEPlanViewController.h"
#import "OSECheckViewController.h"
#import "OSEDoViewController.h"
#import "OSENotesViewController.h"
#import "OSECalendarViewController.h"
#import "OSEDateManager.h"
#import "OSEGoalsManager.h"

@implementation OSEAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    OSEDateManager *dateManager = [[OSEDateManager alloc] initWithDate:[NSDate thisSunday]];
    OSEGoalsManager *goalManager = [[OSEGoalsManager alloc] initWithManagedObjectContext:self.managedObjectContext];
    OSENotesManager *notesManager = [[OSENotesManager alloc] initWithManagedObjectContext:self.managedObjectContext];
    
    UIViewController *viewController0 = [[OSECalendarViewController alloc] initWithDateManager:dateManager goalsManager:goalManager];
    UIViewController *viewController1 = [[OSEPlanViewController alloc] initWithDateManager:dateManager goalsManager:goalManager];
    UIViewController *viewController2 = [[OSEDoViewController alloc] initWithDateManager:dateManager goalsManager:goalManager];
    UIViewController *viewController3 = [[OSECheckViewController alloc] initWithDateManager:dateManager goalsManager:goalManager];
    UIViewController *viewController4 = [[OSENotesViewController alloc] initWithDateManager:dateManager notesManager:notesManager];
    
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController0, navController1, navController2, navController3, navController4, nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if (notification) {
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        cal.timeZone = [NSTimeZone defaultTimeZone];
        NSDateComponents *component = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
        component.hour = 17;
        NSDate *fireDate = [cal dateFromComponents:component];
        
        if([fireDate compare:[NSDate date]] == NSOrderedAscending){
            fireDate = [fireDate dateByAddingTimeInterval:24*60*60];
        }
        
        notification.fireDate = fireDate;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = NSDayCalendarUnit;
        notification.alertBody = @"Need to update your accomplishments?";
        notification.alertAction = @"OK";
        notification.applicationIconBadgeNumber = 1;
        [app scheduleLocalNotification:notification];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    UIApplication *app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext == nil) {
        NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator: coordinator];
        }
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil)
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        NSError *error = nil;

        NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Goals.sqlite"]];
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption:[NSNumber numberWithBool:YES]};
        
        if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                      configuration:nil URL:storeUrl options:options error:&error]) {
            /*Error for store creation should be handled in here*/
        }
    }
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
