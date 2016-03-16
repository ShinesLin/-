//
//  DealListViewController.h
//  美团
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealViewCell.h"
@interface DealListViewController : UICollectionViewController
/** 团购模型数据*/
@property (nonatomic,strong) NSMutableArray *deals;
- (NSString *)iconName;
@end
