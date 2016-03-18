//
//  DealLocalViewController.h
//  美团
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealListViewController.h"

@interface DealLocalViewController : DealListViewController<DealViewCellDelegete>
/** 返回按钮*/
@property (nonatomic,strong) UIBarButtonItem *backItem;
/** 全选*/
@property (nonatomic,strong) UIBarButtonItem *selecteAll;
/** 全部选*/
@property (nonatomic,strong) UIBarButtonItem *unselectAll;
/** 删除*/
@property (nonatomic,strong) UIBarButtonItem *selectDelete;
- (NSArray *)willDeleteDeals;
@end
