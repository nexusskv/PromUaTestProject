//
//  OrderDetailsViewController.m
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "ItemCell.h"


@interface OrderDetailsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    dispatch_queue_t imageQueue;
}
@end


@implementation OrderDetailsViewController

@synthesize selectedOrder;

#pragma mark - Constructor
- (id)init
{
    self = [super init];
    if (self)
    {
        imageQueue = dispatch_queue_create("com.company.app.imageQueue", NULL);     // CREATE CUSTOM QUEUE FOR ASYNC IMAGE LOADING
    }
    return self;
}
#pragma mark - 


#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [FORMAT_STRING:@"№ %@", self.selectedOrder.idStr];     // SET TITLE FOR NAVIGATION BAR
    
    UITableView *detailTable = [self setTableByRect:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, VIEW_HEIGHT)     // CREATE DETAIL TABLE
                                       andSeparator:YES];
    detailTable.delegate    = self;
    detailTable.dataSource  = self;
    [self.view addSubview:detailTable];
}
#pragma mark -


#pragma mark - TableView Delegate & DataSourse Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 110.0f;
    
    if (indexPath.row == 0)
        rowHeight = 180.0f;
	return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *orderId  = @"OrderInfo";       // SET ID FOR ORDER CELL
    static NSString *itemId   = @"ItemInfo";        // SET ID FOR ITEM CELL
    
	ItemCell *cell = nil;
    
    if (cell == nil)
    {
        if (indexPath.row > 0)
        {
            cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemId];     // CREATE ITEM CELL
            
            Item *item = self.selectedOrder.itemObj;        // SET ITEM_CELL DATE_SOURCE
            
            dispatch_async(imageQueue, ^{                                                                   // ASYNC IMAGE LOADING
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.imgUrlStr]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.itemImgView.image = [UIImage imageWithData:imageData] ;
                });
            });
            
            cell.itemTitleLbl.text = item.nameStr;                                                          // SET VALUES FOR LABELS
            cell.itemCostLbl.text  = [FORMAT_STRING:@"%@ %@ |  1 шт.", item.quantityStr, item.currencyStr];
            cell.itemCostTotalLbl.text = [FORMAT_STRING:@"%@ %@", item.quantityStr, item.currencyStr];
            
            cell.selectionStyle      = UITableViewCellSelectionStyleNone;       // DISABLE SELECT FOR CELL
            
            return cell;
        }
        else
            {
                cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderId];    // CREATE ORDER CELL
                
                cell.numOrderLbl.text = [FORMAT_STRING:@"Номер заказа: %@", selectedOrder.idStr];               // SET VALUES FOR LABELS
                cell.customerLbl.text = [FORMAT_STRING:@"Заказчик: %@", selectedOrder.nameStr];
                cell.dateLbl.text     = [FORMAT_STRING:@"Дата: %@", [DateFormatter setDate:selectedOrder.dateStr withFormat:@"dd.MM.yy HH:mm"]];
                cell.phoneLbl.text    = [FORMAT_STRING:@"Телефон: %@", selectedOrder.phoneStr];
                cell.emailLbl.text    = [FORMAT_STRING:@"Email: %@", selectedOrder.emailStr];
                
                NSString *addrStr = [FORMAT_STRING:@"Адрес доставки: %@", selectedOrder.addressStr];
                
                if (selectedOrder.indexStr)
                    addrStr = [FORMAT_STRING:@"Адрес доставки: %@, %@", selectedOrder.indexStr, selectedOrder.addressStr];
                
                cell.addressLbl.text = addrStr;
                
                cell.selectionStyle      = UITableViewCellSelectionStyleNone;       // DISABLE SELECT FOR CELL
                
                return cell;
            }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, 40.0f)];  // SET CUSTOM VEW FOR FOOTER
    
    UILabel *totalLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, 40.0f)];  // SET CUSTOM LABEL FOR FOOTER
    totalLbl.font = [UIFont boldSystemFontOfSize:24.0f];
    totalLbl.text = [FORMAT_STRING:@"%@ %@", self.selectedOrder.itemObj.quantityStr, self.selectedOrder.itemObj.currencyStr];
    totalLbl.textColor = [UIColor blackColor];
    totalLbl.textAlignment = NSTextAlignmentCenter;
    [totalLbl setBackgroundColor:[UIColor lightGrayColor]];
    
    [footerView addSubview:totalLbl];
    return footerView;
}
#pragma mark - 


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
