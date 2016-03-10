//
//  ApiTool.m
//  美团
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "ApiTool.h"
#import "DPAPI.h"
@interface ApiTool() <DPRequestDelegate>
@property (nonatomic,strong) DPAPI *api;
@end
@implementation ApiTool

SingletonM(ApiTool)

- (DPAPI *)api
{
    if (_api == nil) {
        self.api = [[DPAPI alloc]init];
    }
    return _api;
}

- (void)request:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError * error))failure
{

    DPRequest *request =  [self.api requestWithURL:url params:[NSMutableDictionary dictionaryWithDictionary:params] delegate:self];
    request.success = success;
    request.failure = failure;
}

#pragma mark ----DPRequestDelegate代理方法
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if (request.success) {
        request.success(result);
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    if (request.failure) {
        request.failure(error);
    }
}

@end
