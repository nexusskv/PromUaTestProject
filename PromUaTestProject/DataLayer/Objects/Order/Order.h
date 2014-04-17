//
//  Order.h
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Order : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *stateStr;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) NSString *emailStr;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) NSString *addressStr;
@property (nonatomic, strong) NSString *indexStr;
@property (nonatomic, strong) NSString *payTypeStr;
@property (nonatomic, strong) NSString *delivTypeStr;
@property (nonatomic, strong) NSString *commentStr;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) Item *itemObj;

@end
