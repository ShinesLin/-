//
//  Cities.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Cities.h"
#import "MJExtension.h"
#import "Region.h"

@implementation Cities
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"regions" : [Region class]};
}
@end
