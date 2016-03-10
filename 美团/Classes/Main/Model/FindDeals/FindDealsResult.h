//
//  FindDealsResult.h
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetSingleDealResult.h"
@interface FindDealsResult : GetSingleDealResult
/** 所有页面团购总数 */
@property (assign, nonatomic) int total_count;
@end
