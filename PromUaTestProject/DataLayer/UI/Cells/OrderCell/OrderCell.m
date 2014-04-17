//
//  OrderCell.m
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "OrderCell.h"


@implementation OrderCell

@synthesize generalInfoLbl, descripInfoLbl, timeLbl;

#pragma mark - Constructor
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        generalInfoLbl = [self setLabelWithFrame:CGRectMake(10.0f, 10.0f, 250.0f, 20.0f)];
        descripInfoLbl = [self setLabelWithFrame:CGRectMake(10.0f, 30.0f, 270.0f, 20.0f)];
        timeLbl        = [self setLabelWithFrame:CGRectMake(270.0f, 10.0f, 40.0f, 20.0f)];
        
        [self addSubview:generalInfoLbl];
        [self addSubview:descripInfoLbl];
        [self addSubview:timeLbl];
    }
    return self;
}
#pragma mark -

@end
