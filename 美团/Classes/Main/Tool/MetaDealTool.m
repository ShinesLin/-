//
//  MetaDealTool.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "MetaDealTool.h"
#import "Categories.h"
#import "Cities.h"
#import "CityGroups.h"
#import "Sorts.h"
#import "MJExtension.h"
#define SelectCityFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selected_city_names.plist"]
#define SelectSortFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selected_sort.plist"]
#define SelectCategoryFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selected_category.plist"]
@interface MetaDealTool()
{
    /** 所有的分类 */
    NSArray *_categories;
    /** 所有的城市 */
    NSArray *_cities;
    /** 所有的城市组 */
    NSArray *_cityGroups;
    /** 所有的排序 */
    NSArray *_sorts;
}
@property (nonatomic,strong) NSMutableArray *selectCityNames;

@end

@implementation MetaDealTool
SingletonM(MetaDealTool)

- (NSMutableArray *)selectCityNames
{
    if (!_selectCityNames) {
        _selectCityNames = [NSMutableArray arrayWithContentsOfFile:SelectCityFile];
    }
    if (!_selectCityNames) {
        _selectCityNames = [NSMutableArray array];
    }
    return _selectCityNames;
}

- (NSArray *)cities
{
    if (!_cities) {
        _cities = [Cities mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

- (NSArray *)cityGroups
{
    NSMutableArray *cityGoup = [NSMutableArray array];
    if (self.selectCityNames.count) {
        CityGroups *recentCityGroups = [[CityGroups alloc]init];
        recentCityGroups.title = @"最近";
        recentCityGroups.cities = self.selectCityNames;
        [cityGoup addObject:recentCityGroups];
    }
    
    NSArray *plistCityGroups = [CityGroups mj_objectArrayWithFilename:@"cityGroups.plist"];
    [cityGoup addObjectsFromArray:plistCityGroups];
    return cityGoup;
}

- (NSArray *)categories
{
    if (!_categories) {
        _categories = [Categories mj_objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

- (NSArray *)sorts
{
    if (!_sorts) {
        _sorts = [Sorts mj_objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}


- (Cities *)cityWithName:(NSString *)name
{
    if(name.length == 0) return nil;
    for (Cities *city in self.cities) {
        if ([city.name isEqualToString:name]) {
            return city;
        }
    }
    return nil;
}

- (void)saveSelctedCity:(NSString *)name
{
    if (name.length == 0) return;
    [self.selectCityNames removeObject:name];

    [self.selectCityNames insertObject:name atIndex:0];
    
    [self.selectCityNames writeToFile:SelectCityFile atomically:YES];
}

- (void)saveSelctedSort:(Sorts *)sort
{
    if (sort == nil) return;
    [NSKeyedArchiver archiveRootObject:sort toFile:SelectSortFile];
}

- (Cities *)selectCity
{
   NSString *cityName = [self.selectCityNames firstObject];
    
   Cities *city =[self cityWithName:cityName];
    if (city == nil) {
        city = [self cityWithName:@"北京"];
    }
    return city;
}

- (Sorts *)selctedSort
{
   Sorts *sort = [NSKeyedUnarchiver unarchiveObjectWithFile:SelectSortFile];
    if (sort == nil) {
        sort = [self.sorts firstObject];
    }
    return sort;
}

- (void)saveSelctedCategory:(Categories *)cateGory
{
    if (cateGory == nil) return;
    [NSKeyedArchiver archiveRootObject:cateGory toFile:SelectCategoryFile];
}

- (Categories *)selctedCategory
{
    Categories *cate = [NSKeyedUnarchiver unarchiveObjectWithFile:SelectCategoryFile];
    if (cate == nil) {
        cate = [self.categories firstObject];
    }
    return cate;
}
@end
