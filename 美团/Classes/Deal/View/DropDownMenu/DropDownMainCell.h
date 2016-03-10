//
//  DropDownMainCell.h
//  美团
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealDropDownMenu.h"

@interface DropDownMainCell : UITableViewCell
+ (instancetype)cellWithTableViewcell:(UITableView *)tableView;
@property (nonatomic,strong) UIImageView *Rightaccessory;
@property (nonatomic,strong)  id<DealDropDownMenuItem> items;

@end
