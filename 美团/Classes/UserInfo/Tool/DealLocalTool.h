//
//  DealLocalTool.h
//  美团
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//  处理团购的本地数据（浏览记录和收藏记录）

#import <Foundation/Foundation.h>
#import "Singleton.h"


@class Deals;
@interface DealLocalTool : NSObject
SingletonH(DealLocalTool)

/** 返回最近浏览团购数据*/
@property (nonatomic,strong,readonly) NSMutableArray *dealHistory;
/** 保存最近浏览的团购数据*/
- (void)saveDealHistory:(Deals *)deal;

@end
