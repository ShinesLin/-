//
//  DealLocalTool.m
//  美团
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealLocalTool.h"

#define dealHistoryFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"dealHistroy.data"]

@interface DealLocalTool()
{
    NSMutableArray *_dealHistory;
}
@end

@implementation DealLocalTool
SingletonM(DealLocalTool)

- (NSMutableArray *)dealHistory
{
    if (!_dealHistory) {
        _dealHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:dealHistoryFile];
    }
    if (!_dealHistory) {
        _dealHistory = [NSMutableArray array];
    }
    return _dealHistory;
}

- (void)saveDealHistory:(Deals *)deal
{
    [self.dealHistory removeObject:deal];
    [self.dealHistory addObject:deal];
    
    [NSKeyedArchiver archiveRootObject:self.dealHistory toFile:dealHistoryFile];
}

@end
