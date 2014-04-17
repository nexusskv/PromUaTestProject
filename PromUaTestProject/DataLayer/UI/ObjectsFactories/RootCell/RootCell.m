//
//  RootCell.m
//  PromUaTestProject
//
//  Created by rost on 17.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "RootCell.h"

@implementation RootCell

#pragma mark - Constructor
- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code
    }
    return self;
}
#pragma mark - 


#pragma mark - setLabelWithFrame:
- (UILabel *)setLabelWithFrame:(CGRect)lblRect
{
    UILabel *setLbl = [[UILabel alloc] initWithFrame:lblRect];

    setLbl.backgroundColor = [UIColor clearColor];
    setLbl.textColor       = [UIColor darkGrayColor];
    setLbl.font            = [UIFont fontWithName:@"Helvetica" size:13.5f];
    setLbl.textAlignment   = NSTextAlignmentLeft;
    setLbl.lineBreakMode   = NSLineBreakByWordWrapping;
    setLbl.numberOfLines   = 0;
    
    return setLbl;
}
#pragma mark -


#pragma mark - setImageFromRect:
- (UIImageView *)setImageFromRect:(CGRect)imgRect
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgRect];
    
    //imgView.autoresizingMask      = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imgView.contentMode = UIViewContentModeScaleAspectFit;

    return imgView;
}
#pragma mark -


#pragma mark - setSelected:animated:
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -

@end
