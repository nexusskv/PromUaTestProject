//
//  RootViewController.h
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

- (UITableView *)setTableByRect:(CGRect)frame andSeparator:(BOOL)sepFlag;

- (UISearchBar *)setSearchBarFromRect:(CGRect)searchRect andHolder:(NSString *)searchHolder;

- (void)showAlert:(NSString *)titleStr withMessage:(NSString *)msgStr;

@end
