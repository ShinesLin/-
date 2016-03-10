//
//  DealsTool.m
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//  业务类（负责团购的所有业务）

#import "DealsTool.h"
#import "ApiTool.h"
#import "MJExtension.h"

@implementation DealsTool
+ (void)findDeals:(FindDealsParams *)params success:(void (^)(FindDealsResult *))success failure:(void (^)(NSError *))failure
{
    //keyValue模型转字典
    [[ApiTool sharedApiTool]request:@"v1/deal/find_deals" params:params.mj_keyValues success:^(id json) {
        if (success) {
            FindDealsResult *obj = [FindDealsResult mj_objectWithKeyValues:json];//objectWithKeyValues字典转模型
            success(obj);//模型传给success
        }
    } failure:failure];

}

+ (void)getSingleDeal:(GetSingleDealParams *)params success:(void (^)(GetSingleDealResult *))success failure:(void (^)(NSError *))failure
{
    [[ApiTool sharedApiTool] request:@"v1/deal/get_single_deal" params:params.mj_keyValues success:^(id json) {
        if (success) {
            GetSingleDealResult *obj = [GetSingleDealResult mj_objectWithKeyValues:json];
            success(obj);
        }
    } failure:failure];
}

@end
