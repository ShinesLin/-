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
- (void)unSaveDealHistory:(Deals *)deal;
- (void)unSaveDealHistorys:(NSArray *)deal;

/**返回最近收藏团购数据*/
@property (nonatomic,strong,readonly)  NSMutableArray *dealCollect;

/** 保存最近收藏团购数据*/
- (void)saveDealCollect:(Deals *)deal;

/** 取消收藏团购数据*/
- (void)unSaveDealCollect:(Deals *)deal;
- (void)unSaveDealCollects:(NSArray *)deal;

@end
