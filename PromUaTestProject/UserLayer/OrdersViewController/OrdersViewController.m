//
//  OrdersViewController.m
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrderCell.h"
#import "OrderDetailsViewController.h"


@interface OrdersViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *ordersCopyMutArr;
@property (assign, nonatomic) BOOL isSearching;
@end


@implementation OrdersViewController

@synthesize ordersArr;
@synthesize ordersCopyMutArr;
@synthesize isSearching;


#pragma mark - Constructor
- (id)init
{
    self = [super init];
    if (self)
    {
        // SET OBSERVER FOR ORDERS DOWNLOAD & GET DATA_SOURCE IN ARRAY
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable:) name:@"arrayUpdated" object:nil];
    }
    return self;
}
#pragma mark -


#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    
    self.title = @"Заказы";         // SET TITLE FOR NAVIGATION BAR
    
    self.isSearching = NO;          // SET DEFAULT FLAG FOR SEARCH PROCESS
}
#pragma mark -


#pragma mark - createUI
- (void)createUI
{
    // ADD SEARCH BAR
    UISearchBar *searchBar = [self setSearchBarFromRect:CGRectMake(0.0f, 0.0f, VIEW_WIDTH, 40.0f) andHolder:@"Поиск"];
    searchBar.searchBarStyle = UISearchBarStyleProminent;
    searchBar.delegate       = self;
    [self.view addSubview:searchBar];
    
    // ADD ORDERS TABLE
    UITableView *ordersTable = [self setTableByRect:CGRectMake(0.0f, 40.0f, VIEW_WIDTH, VIEW_HEIGHT - 40.0f)
                                       andSeparator:YES];
    ordersTable.tag = ORDER_TABLE_TAG;
    ordersTable.delegate    = self;
    ordersTable.dataSource  = self;
    [self.view addSubview:ordersTable];
}
#pragma mark -


#pragma mark - updateTable:
- (void)updateTable:(NSNotification *)receivedNotif
{
    if ([receivedNotif.object isKindOfClass:[NSArray class]])       // CHECK RECIEVED NOTIFICATION FOR DATA_SOURCE
    {
        self.ordersArr = receivedNotif.object;                      // SET DATA_SOURCE FOR ORDERS TABLE
        
        dispatch_async(dispatch_get_main_queue(), ^{                // ASYNC REFRESH TABLE
            if ([self.ordersArr count] > 0)
            {
                [self reloadTable];
                
                ordersCopyMutArr = [[NSMutableArray alloc] initWithArray:self.ordersArr];  // SET BACKUP OF DATA_SOURCE FOR WORK CANCEL OF FILTERING
            }
        });
    }
    else
        if ([receivedNotif.object isKindOfClass:[NSString class]])  // CHECK RECIEVED NOTIFICATION FOR ERROR
           [self showAlert:@"Ошибка" withMessage:(NSString *)receivedNotif.object]; // SHOW ERROR AS ALERT
}
#pragma mark -


#pragma mark - TableView Delegate & DataSourse Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ordersArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *titlesId       = @"TitlesIdentifier";
    
	OrderCell *cell = nil;
    
    if (cell == nil)
    {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titlesId];      // CREATE CUSTOM CELL
        
        Order *order = [self.ordersArr objectAtIndex:indexPath.row];                // SET DATASOURCE FOR CELL
        
        cell.generalInfoLbl.text = [FORMAT_STRING:@"%@ - %@", order.idStr, order.nameStr];      // SET VALUES FOR LABELS IN CELL
        cell.descripInfoLbl.text = [FORMAT_STRING:@"%@ %@ - %@", order.itemObj.priceStr, order.itemObj.currencyStr, order.itemObj.nameStr];
        cell.timeLbl.text        = [DateFormatter setDate:order.dateStr withFormat:@"HH:mm"];
        
        cell.selectionStyle      = UITableViewCellSelectionStyleGray;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderDetailsViewController *orderDetaisVC = [[OrderDetailsViewController alloc] init];      // JUMP TO DETAILS PAGE WITH SELECTED ORDER
    orderDetaisVC.selectedOrder = [self.ordersArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:orderDetaisVC animated:YES];
}
#pragma mark -


#pragma mark - SearchBar Delegate methods
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if ([searchBar isFirstResponder])
        [searchBar resignFirstResponder];               // HIDE KEYBOARD
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ((searchText.length > 2) && (!isSearching))      // SET CONDITION FOR START SEARCH
    {
        self.isSearching = YES;                         // SET FLAG FOR SEARCH PROCESS SENTINEL
        [self filterByWord:searchText];                 // CALL SEARCH METHOD BY INPUT STRING
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self restoreData];                                 // RESTORE START DATA
    if ([searchBar isFirstResponder])
        [searchBar resignFirstResponder];               // HIDE KEYBOARD
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];                   // HIDE KEYBOARD
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}
#pragma mark -


#pragma mark - filterByWord:
- (void)filterByWord:(NSString *)wordFilter
{
    __block NSMutableArray *filteredMutArr = [[NSMutableArray alloc] init];

    dispatch_queue_t fetchQ = dispatch_queue_create("OrdersSort", NULL);  // CREATE CUSTOM QUEUE
    dispatch_async(fetchQ, ^{
        if ([filteredMutArr count] == 0)            // CHECK FOR DUPLICATE CONDITION
        {
            for (Order *order in self.ordersArr)    // SEARCH BY ORDER ID
            {
                NSRange nameRange = [order.idStr rangeOfString:wordFilter options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                if(nameRange.location != NSNotFound)
                {
                    [filteredMutArr addObject:order];
                }
            }
        }
    });
    
        dispatch_async(fetchQ, ^{
            if ([filteredMutArr count] == 0)            // CHECK FOR DUPLICATE CONDITION
            {
                for (Order *order in self.ordersArr)    // SEARCH BY CUSTOMER NAME
                {
                    NSRange nameRange = [order.nameStr rangeOfString:wordFilter options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                    if(nameRange.location != NSNotFound)
                    {
                        [filteredMutArr addObject:order];
                    }
                }
            }
        });
            
        dispatch_async(fetchQ, ^{
            if ([filteredMutArr count] == 0)            // CHECK FOR DUPLICATE CONDITION
            {
                for (Order *order in self.ordersArr)    // SEARCH BY PHONE
                {
                    NSRange nameRange = [order.phoneStr rangeOfString:wordFilter options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                    if(nameRange.location != NSNotFound)
                    {
                        [filteredMutArr addObject:order];
                    }
                }
            }
        });

        dispatch_async(fetchQ, ^{
            if ([filteredMutArr count] == 0)            // CHECK FOR DUPLICATE CONDITION
            {
                for (Order *order in self.ordersArr)    // SEARCH BY SKU
                {
                    NSRange nameRange = [order.itemObj.skuStr rangeOfString:wordFilter options:(NSLiteralSearch|NSDiacriticInsensitiveSearch)];
                    if(nameRange.location != NSNotFound)
                    {
                        [filteredMutArr addObject:order];
                    }
                }
            }
        });

        dispatch_async(fetchQ, ^{
            if ([filteredMutArr count] == 0)            // CHECK FOR DUPLICATE CONDITION
            {
                for (Order *order in self.ordersArr)    // SEARCH BY TITLE OF ITEM
                {
                    NSRange nameRange = [order.itemObj.nameStr rangeOfString:wordFilter options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                    if(nameRange.location != NSNotFound)
                    {
                        [filteredMutArr addObject:order];
                    }
                }
            }
        });

    
    dispatch_async(fetchQ, ^{
        if ([filteredMutArr count] > 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ordersArr = nil;
                self.ordersArr = filteredMutArr;    // SET FILTERED DATA_SOURCE TO GENERAL DATA_SOURCE
                
                [self reloadTable];     // ASYNC REFRESH TABLE
            });
        }
        self.isSearching = NO;          // SET DISABLE FLAG FOR SEARCH PROCESS SENTINEL
    });
    
}
#pragma mark -


#pragma mark - restoreData
- (void)restoreData
{
    self.ordersArr = nil;
    self.ordersArr = ordersCopyMutArr;          // RESTORE DATA
    
    [self reloadTable];
}
#pragma mark -


#pragma mark - reloadTable
- (void)reloadTable
{
    UITableView *orderTable = (UITableView *)[self.view viewWithTag:ORDER_TABLE_TAG];
    [orderTable reloadData];
}
#pragma mark - 


#pragma mark - Destructor
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];     // REMOVE OBSERVERs
}
#pragma mark -


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
