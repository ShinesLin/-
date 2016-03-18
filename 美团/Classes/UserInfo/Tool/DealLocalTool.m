//
//  DealLocalTool.m
//  美团
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealLocalTool.h"
#import "Deals.h"

#define dealHistoryFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dealHistroy.plist"]

#define dealCollectFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dealCollect.plist"]

@interface DealLocalTool()
{
    NSMutableArray *_dealHistory;
    NSMutableArray *_dealCollect;
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

- (NSMutableArray *)dealCollect
{
    if (!_dealCollect) {
        _dealCollect = [NSKeyedUnarchiver unarchiveObjectWithFile:dealCollectFile];
    }
    if (!_dealCollect) {
        _dealCollect = [NSMutableArray array];
    }
    return _dealCollect;
}

//浏览历史
- (void)saveDealHistory:(Deals *)deal
{
    [self.dealHistory removeObject:deal];
    [self.dealHistory insertObject:deal atIndex:0];
    //存入沙盒
    [NSKeyedArchiver archiveRootObject:self.dealHistory toFile:dealHistoryFile];
}

- (void)unSaveDealHistory:(Deals *)deal
{
    [self.dealHistory removeObject:deal];
    [NSKeyedArchiver archiveRootObject:self.dealHistory toFile:dealHistoryFile];
}

- (void)unSaveDealHistorys:(NSArray *)deal
{
    [self.dealHistory removeObjectsInArray:deal];
    [NSKeyedArchiver archiveRootObject:self.dealHistory toFile:dealHistoryFile];
}

//收藏
- (void)saveDealCollect:(Deals *)deal
{
    [self.dealCollect removeObject:deal];
    [self.dealCollect insertObject:deal atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:self.dealCollect toFile:dealCollectFile];
}

- (void)unSaveDealCollects:(NSArray *)deal
{
    [self.dealCollect removeObjectsInArray:deal];
    [NSKeyedArchiver archiveRootObject:self.dealCollect toFile:dealCollectFile];

}

- (void)unSaveDealCollect:(Deals *)deal
{
    [self.dealCollect removeObject:deal];
    [NSKeyedArchiver archiveRootObject:self.dealCollect toFile:dealCollectFile];
}

@end
