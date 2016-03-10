//
//  Sorts.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先 */
typedef enum {
    SortValueDefault = 1, // 默认排序
    SortValueLowPrice, // 价格最低
    SortValueHighPrice, // 价格最高
    SortValuePopular, // 人气最高
    SortValueLatest, // 最新发布
    SortValueOver, // 即将结束
    SortValueClosest // 离我最近
} SortValue;

@interface Sorts : NSObject
@property (assign, nonatomic) int value;
@property (copy, nonatomic) NSString *label;
@end
