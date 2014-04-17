//
//  DateFormatter.m
//  PromUaTestProject
//
//  Created by rost on 17.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "DateFormatter.h"


@implementation DateFormatter


#pragma mark - setDate:withFormat:
+ (NSString *)setDate:(NSString *)incVal withFormat:(NSString *)formatStr
{
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd.MM.yy HH:mm"];
    NSDate *startDate =	[outputFormatter dateFromString:incVal];
	[outputFormatter setDateFormat:formatStr];
	NSString *resultStr = [outputFormatter stringFromDate:startDate];

    return resultStr;
}
#pragma mark - 

@end
