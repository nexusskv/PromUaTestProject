//
//  Item.h
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *quantityStr;
@property (nonatomic, strong) NSString *currencyStr;
@property (nonatomic, strong) NSString *imgUrlStr;
@property (nonatomic, strong) NSString *itemUrlStr;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *skuStr;

@end
