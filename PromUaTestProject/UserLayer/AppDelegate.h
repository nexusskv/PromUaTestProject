//
//  AppDelegate.h
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiConnector.h"
#import "OrdersViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nc;
@property (strong, nonatomic) OrdersViewController *orderVC;

@end
