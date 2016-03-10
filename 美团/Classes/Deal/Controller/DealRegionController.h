//
//  DealRegionController.h
//  美团
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealDropDownMenu.h"
@class Region;
@interface DealRegionController : UIViewController<DealDropDownMenuDelegate>
//@property (nonatomic,copy) void (^changeCityBlock)();
@property (nonatomic,strong) NSArray *regions;

/** 当前选中的区域 */
@property (strong, nonatomic) Region *selectedRegion;
/** 当前选中的子区域名称 */
@property (copy, nonatomic) NSString *selectedSubRegionName;
@end
