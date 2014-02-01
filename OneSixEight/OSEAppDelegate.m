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
#import "OSEImproveViewController.h"
#import "OSECalendarViewController.h"
#import "OSEDateManager.h"

@implementation OSEAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    OSEDateManager *dateManager = [[OSEDateManager alloc] initWithDate:[NSDate thisSunday]];
    
    UIViewController *viewController0 = [[OSECalendarViewController alloc] initWithDateManager:dateManager];
    UIViewController *viewController1 = [[OSEPlanViewController alloc] initWithDateManager:dateManager];
    UIViewController *viewController2 = [[OSEDoViewController alloc] initWithDateManager:dateManager];
    UIViewController *viewController3 = [[OSECheckViewController alloc] initWithDateManager:dateManager];
    UIViewController *viewController4 = [[OSEImproveViewController alloc] initWithDateManager:dateManager];
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController0, navController1, navController2, viewController3, viewController4, nil];
    
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
        NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                                   stringByAppendingPathComponent: @"Goals.sqlite"]];
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                       initWithManagedObjectModel:[self managedObjectModel]];
        if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                      configuration:nil URL:storeUrl options:nil error:&error]) {
            /*Error for store creation should be handled in here*/
        }
    }
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSMutableArray *)getAllGoals {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *fetchedGoals = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return [NSMutableArray arrayWithArray:fetchedGoals];
}

- (NSMutableArray *)fetchGoalsFromWeekStarting:(NSDate *)date
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate == %@", date];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedGoals = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return [NSMutableArray arrayWithArray:fetchedGoals];
}

- (void)removeGoal:(Goal *)goal {
    [self.managedObjectContext deleteObject:goal];
//    [self.managedObjectContext save];
}


@end
