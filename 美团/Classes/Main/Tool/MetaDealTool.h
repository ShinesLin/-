//
//  MetaDealTool.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class Cities,Region,Categories,Sorts;
@interface MetaDealTool : NSObject

SingletonH(MetaDealTool)
/**
 *  所有的分类
 */
@property (strong, nonatomic, readonly) NSArray *categories;
/**
 *  所有的城市
 */
@property (strong, nonatomic,readonly) NSArray *cities;
/**
 *  所有的城市组
 */
@property (strong, nonatomic, readonly) NSArray *cityGroups;
/**
 *  所有的排序
 */
@property (strong, nonatomic, readonly) NSArray *sorts;
- (Cities *)cityWithName:(NSString *)name;

/** 把选中的城市存储到沙盒中，在最近列表显示*/
- (void)saveSelctedCity:(NSString *)name;
/** 上次存了哪些城市*/
- (Cities *)selectCity;

/** 把用户选择的排序存入沙盒中*/
- (void)saveSelctedSort:(Sorts *)sort;
- (Sorts *)selctedSort;

/** 把用户选择的分类存入沙盒中*/
- (void)saveSelctedCategory:(Categories *)cateGory;

- (Categories *)selctedCategory;
@end
