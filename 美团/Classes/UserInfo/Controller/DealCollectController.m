//
//  DealCollectController.m
//  美团
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealCollectController.h"
#import "DealLocalTool.h"
#import "Deals.h"

@interface DealCollectController ()

@end

@implementation DealCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.deals removeAllObjects];
    
    NSArray *dealCollect = [DealLocalTool sharedDealLocalTool].dealCollect;
    [self.deals addObjectsFromArray:dealCollect];
    [self.collectionView reloadData];
}

- (void)Delete
{
    [[DealLocalTool sharedDealLocalTool]unSaveDealCollects:self.willDeleteDeals];
}


- (NSString *)iconName
{
    return @"icon_collects_empty";
}
@end
