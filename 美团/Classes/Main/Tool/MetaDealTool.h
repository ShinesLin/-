//
//  MetaDealTool.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class Cities;
@interface MetaDealTool : NSObject

SingletonH(MetaDealTool)
/**
 *  所有的分类
 */
@property (strong, nonatomic, readonly) NSArray *categories;
/**
 *  所有的城市
 */
@property (strong, nonatomic,readonly) NSArray *cities;
/**
 *  所有的城市组
 */
@property (strong, nonatomic, readonly) NSArray *cityGroups;
/**
 *  所有的排序
 */
@property (strong, nonatomic, readonly) NSArray *sorts;
- (Cities *)cityWithName:(NSString *)name;
@end
