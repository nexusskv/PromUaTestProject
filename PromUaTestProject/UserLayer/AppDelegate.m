//
//  AppDelegate.m
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize nc;
@synthesize orderVC;


#pragma mark - application:didFinishLaunchingWithOptions:
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    // LOADING ORDERS FROM SERVER API
    ApiConnector *apiConnector   = [[ApiConnector alloc] init];
    [apiConnector loadOrders];
    
    // SET ROOT VIEW CONTROLLER
    orderVC = [[OrdersViewController alloc] init];
    nc = [[UINavigationController alloc] initWithRootViewController:orderVC];
    self.window.rootViewController = nc;
 
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark -

@end
