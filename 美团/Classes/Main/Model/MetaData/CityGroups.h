//
//  CityGroups.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroups : NSObject
/** 组标题 */
@property (copy, nonatomic) NSString *title;
/** 这组显示的城市 */
@property (strong, nonatomic) NSArray *cities;
@end
