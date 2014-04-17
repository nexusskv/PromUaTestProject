//
//  ItemCell.h
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : RootCell

@property (strong, nonatomic) UILabel *numOrderLbl;
@property (strong, nonatomic) UILabel *customerLbl;
@property (strong, nonatomic) UILabel *dateLbl;
@property (strong, nonatomic) UILabel *phoneLbl;
@property (strong, nonatomic) UILabel *emailLbl;
@property (strong, nonatomic) UILabel *addressLbl;

@property (strong, nonatomic) UIImageView *itemImgView;
@property (strong, nonatomic) UILabel *itemTitleLbl;
@property (strong, nonatomic) UILabel *itemCostLbl;
@property (strong, nonatomic) UILabel *itemCostTotalLbl;

@end
