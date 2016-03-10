//
//  DealCategoryController.h
//  美团
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealDropDownMenu.h"
@class Categories;
@interface DealCategoryController : UIViewController<DealDropDownMenuDelegate>
/** 当前选中的分类 */
@property (strong, nonatomic) Categories *selectedCategory;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubCategoryName;
@end
