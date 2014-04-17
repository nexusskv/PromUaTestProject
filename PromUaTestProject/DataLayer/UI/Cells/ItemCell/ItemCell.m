//
//  ItemCell.m
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

@synthesize numOrderLbl, customerLbl, dateLbl, phoneLbl, emailLbl, addressLbl;
@synthesize itemImgView;
@synthesize itemTitleLbl, itemCostLbl, itemCostTotalLbl;


#pragma mark - Constructor
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if ([reuseIdentifier isEqualToString:@"OrderInfo"])
        {
            numOrderLbl         = [self setLabelWithFrame:CGRectMake(10.0f, 20.0f, 300.0f, 20.0f)];
            customerLbl         = [self setLabelWithFrame:CGRectMake(10.0f, 40.0f, 300.0f, 20.0f)];
            dateLbl             = [self setLabelWithFrame:CGRectMake(10.0f, 60.0f, 300.0f, 20.0f)];
            phoneLbl            = [self setLabelWithFrame:CGRectMake(10.0f, 80.0f, 300.0f, 20.0f)];
            emailLbl            = [self setLabelWithFrame:CGRectMake(10.0f, 100.0f, 300.0f, 20.0f)];
            addressLbl          = [self setLabelWithFrame:CGRectMake(10.0f, 120.0f, 300.0f, 30.0f)];
            
            [self addSubview:numOrderLbl];
            [self addSubview:customerLbl];
            [self addSubview:dateLbl];
            [self addSubview:phoneLbl];
            [self addSubview:emailLbl];
            [self addSubview:addressLbl];
        }
        
        if ([reuseIdentifier isEqualToString:@"ItemInfo"])
        {
            itemImgView      = [self setImageFromRect:CGRectMake(10.0f, 10.0f, 100.0f, 90.0f)];
            
            itemTitleLbl     = [self setLabelWithFrame:CGRectMake(125.0f, 20.0f, 175.0f, 20.0f)];
            itemCostLbl      = [self setLabelWithFrame:CGRectMake(125.0f, 40.0f, 175.0f, 20.0f)];
            itemCostTotalLbl = [self setLabelWithFrame:CGRectMake(125.0f, 70.0f, 175.0f, 20.0f)];
            itemCostTotalLbl.font = [UIFont boldSystemFontOfSize:16.0f];
            
            [self addSubview:itemImgView];
            [self addSubview:itemTitleLbl];
            [self addSubview:itemCostLbl];
            [self addSubview:itemCostTotalLbl];
        }
    }
    
    return self;
}
#pragma mark -

@end
