//
//  Deals.m
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Deals.h"
#import "MJExtension.h"
#import "Business.h"
@implementation Deals
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"businesss" : [Business class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}

- (BOOL)isEqual:(Deals *)other
{
    return [self.deal_id isEqualToString:other.deal_id];
}

MJCodingImplementation

@end
