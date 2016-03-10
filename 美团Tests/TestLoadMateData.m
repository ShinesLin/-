//
//  TestLoadMateData.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MetaDealTool.h"
#import "Cities.h"
@interface TestLoadMateData : XCTestCase

@end

@implementation TestLoadMateData

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadMetaDta
{
    MetaDealTool *tool = [MetaDealTool sharedMetaDealTool];
    XCTAssert(tool.cities.count>0,@"数据加载失败");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
