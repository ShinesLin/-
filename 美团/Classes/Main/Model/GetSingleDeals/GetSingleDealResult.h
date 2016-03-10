//
//  GetSingleDealResult.h
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetSingleDealResult : NSObject
/** 本次API访问所获取的单页团购数量 */
@property (assign, nonatomic) int count;
/** 所有的团购 */
@property (strong, nonatomic) NSArray *deals;
@end
