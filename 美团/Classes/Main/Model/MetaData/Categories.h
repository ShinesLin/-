//
//  Categories.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DealDropDownMenu.h"
@interface Categories : NSObject <DealDropDownMenuItem>
/** 类别名称 */
@property (copy, nonatomic) NSString *name;
/** 大图标 */
@property (copy, nonatomic) NSString *icon;
/** 大图标(高亮) */
@property (copy, nonatomic) NSString *highlighted_icon;
/** 小图标 */
@property (copy, nonatomic) NSString *small_icon;
/** 小图标(高亮) */
@property (copy, nonatomic) NSString *small_highlighted_icon;
/** 子类别 */
@property (strong, nonatomic) NSArray *subcategories;

@end
