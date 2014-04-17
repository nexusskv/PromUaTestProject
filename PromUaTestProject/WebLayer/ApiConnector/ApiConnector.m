//
//  ApiConnector.m
//  PromUaTestProject
//
//  Created by rost on 16.04.14.
//  Copyright (c) 2014 rost. All rights reserved.
//

#import "ApiConnector.h"
#import "TBXML+HTTP.h"




@interface ApiConnector ()

@property (strong, nonatomic) NSMutableArray *ordersMutArr;
@property (strong, nonatomic) Order *order;

@end


@implementation ApiConnector

@synthesize ordersMutArr;
@synthesize order;


#pragma mark - loadOrders
- (void)loadOrders
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       
        TBXMLSuccessBlock successBlock = ^(TBXML *tbxml) {
            if (tbxml.rootXMLElement)
            {
                ordersMutArr = [[NSMutableArray alloc] init];
                order = [[Order alloc] init];

                [self traverseElement:tbxml.rootXMLElement];        // PARSE DOWNLOADED XML
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"arrayUpdated" object:ordersMutArr];    // SEND SUCCESS NOTIFICATION
            }
        };
        
        TBXMLFailureBlock errorBlock = ^(TBXML *tbxml, NSError *error) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"arrayUpdated" object:error.description];   // SEND ERROR NOTIFICATION

        };
        
        [TBXML newTBXMLWithURL:[NSURL URLWithString:ORDERS_XML_URL] success:successBlock failure:errorBlock];   // ASYNC DOWNLOAD XML
    });
}
#pragma mark -


#pragma mark - traverseElement:
- (void)traverseElement:(TBXMLElement *)element
{
    do
    {
        if (element->firstChild)
            [self traverseElement:element->firstChild];

        
        if ([[TBXML elementName:element] isEqualToString:@"order"])
        {
            order = [[Order alloc] init];
            
            if (element->firstAttribute != NULL)        // SAVE ORDER ATTRIBUTES
            {
                order.idStr = [FORMAT_STRING:@"%s", element->firstAttribute->value];
                
                if (element->firstAttribute->next != NULL)
                    order.stateStr = [FORMAT_STRING:@"%s", element->firstAttribute->next->value];
            }
            
            if ([TBXML childElementNamed:@"name" parentElement:element])
                if ([TBXML childElementNamed:@"name" parentElement:element]->text != NULL)
                    order.nameStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"name" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"phone" parentElement:element])
                if ([TBXML childElementNamed:@"phone" parentElement:element]->text != NULL)
                    order.phoneStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"phone" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"email" parentElement:element])
                if ([TBXML childElementNamed:@"email" parentElement:element]->text != NULL)
                    order.emailStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"email" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"date" parentElement:element])
                if ([TBXML childElementNamed:@"date" parentElement:element]->text != NULL)
                    order.dateStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"date" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"address" parentElement:element])
                if ([TBXML childElementNamed:@"address" parentElement:element]->text != NULL)
                    order.addressStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"address" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"index" parentElement:element])
                if ([TBXML childElementNamed:@"index" parentElement:element]->text != NULL)
                    order.indexStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"index" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"paymentType" parentElement:element])
                if ([TBXML childElementNamed:@"paymentType" parentElement:element]->text != NULL)
                    order.payTypeStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"paymentType" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"deliveryType" parentElement:element])
                if ([TBXML childElementNamed:@"deliveryType" parentElement:element]->text != NULL)
                    order.delivTypeStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"deliveryType" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"payercomment" parentElement:element])
                if ([TBXML childElementNamed:@"payercomment" parentElement:element]->text != NULL)
                    order.commentStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"payercomment" parentElement:element]->text];
            
            if ([TBXML childElementNamed:@"priceBYR" parentElement:element])
                if ([TBXML childElementNamed:@"priceBYR" parentElement:element]->text != NULL)
                    order.priceStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"priceBYR" parentElement:element]->text];

            
            if ([TBXML childElementNamed:@"items" parentElement:element])
            {
                TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:[TBXML childElementNamed:@"items" parentElement:element]];
                
                Item *orderItem = [[Item alloc] init];
                
                if (item->firstAttribute->value != NULL)
                    orderItem.idStr = [FORMAT_STRING:@"%s", item->firstAttribute->value];
                
                if ([TBXML childElementNamed:@"name" parentElement:item])
                    if ([TBXML childElementNamed:@"name" parentElement:item]->text != NULL)
                        orderItem.nameStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"name" parentElement:item]->text];
                
                if ([TBXML childElementNamed:@"quantity" parentElement:item])
                    if ([TBXML childElementNamed:@"quantity" parentElement:item]->text != NULL)
                        orderItem.quantityStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"quantity" parentElement:item]->text];
                
                if ([TBXML childElementNamed:@"currency" parentElement:item])
                    if ([TBXML childElementNamed:@"currency" parentElement:item]->text != NULL)
                        orderItem.currencyStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"currency" parentElement:item]->text];
                
                if ([TBXML childElementNamed:@"image" parentElement:item])
                    if ([TBXML childElementNamed:@"image" parentElement:item]->text != NULL)
                        orderItem.imgUrlStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"image" parentElement:item]->text];
                
                if ([TBXML childElementNamed:@"url" parentElement:item])
                    if ([TBXML childElementNamed:@"url" parentElement:item]->text != NULL)
                        orderItem.itemUrlStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"url" parentElement:item]->text];
                
                if ([TBXML childElementNamed:@"price" parentElement:item])
                    if ([TBXML childElementNamed:@"price" parentElement:item]->text != NULL)
                        orderItem.priceStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"price" parentElement:item]->text];
                
                if ([TBXML childElementNamed:@"sku" parentElement:item])
                    if ([TBXML childElementNamed:@"sku" parentElement:item]->text != NULL)
                        orderItem.skuStr = [NSString stringWithUTF8String:[TBXML childElementNamed:@"sku" parentElement:item]->text];
                
                if ((orderItem.idStr) && (orderItem.nameStr) && (orderItem.priceStr))
                    order.itemObj = orderItem;
                
                
                if ((order.idStr) && (order.priceStr) && (orderItem.idStr))
                {
                    [ordersMutArr addObject:order];
                    order = nil;
                }
                orderItem = nil;
            }
        }       
    }
    while ((element = element->nextSibling));
}
#pragma mark -

@end
