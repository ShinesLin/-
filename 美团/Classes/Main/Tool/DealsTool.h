//
//  DealsTool.h
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindDealsParams.h"
#import "FindDealsResult.h"
#import "GetSingleDealParams.h"
#import "GetSingleDealResult.h"

@interface DealsTool : NSObject
/**
 *  搜索团购
 *
 *  @param params  请求参数
 *  @param success 请求成功返回结果
 *  @param failure 请求失败返回错误
 */
+ (void)findDeals:(FindDealsParams *)params success:(void (^)(FindDealsResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)getSingleDeal:(GetSingleDealParams *)params success:(void(^)(GetSingleDealResult *result))success failure:(void (^)(NSError *error))failure;
@end
