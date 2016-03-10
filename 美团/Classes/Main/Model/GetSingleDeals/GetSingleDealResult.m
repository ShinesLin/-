//
//  GetSingleDealResult.m
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "GetSingleDealResult.h"
#import "MJExtension.h"
#import "Deals.h"
@implementation GetSingleDealResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"deals" : [Deals class]};
}
@end
