//
//  Restrictions.h
//  美团
//
//  Created by apple on 16/3/13.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restrictions : NSObject
/** 是否需要预约，0：不是，1：是 */
@property (assign, nonatomic) BOOL is_reservation_required;

/** 是否支持随时退款，0：不是，1：是 */
@property (assign, nonatomic) BOOL is_refundable;

/** 附加信息(一般为团购信息的特别提示) */
@property (copy, nonatomic) NSString *special_tips;
@end
