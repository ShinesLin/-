//
//  ApiTool.h
//  美团
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"

@interface ApiTool : NSObject

- (void)request:(NSString *)url params:(NSDictionary *) params success:(void(^)(id json))success failure:(void (^)(NSError * error))failure;

SingletonH(ApiTool)
@end
