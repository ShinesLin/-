//
//  DealSortController.h
//  美团
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Sorts;
@interface DealSortController : UIViewController
/** 当前选中的排序 */
@property (strong, nonatomic) Sorts *selectedSort;
@end
