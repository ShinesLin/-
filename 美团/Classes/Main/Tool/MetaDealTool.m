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
@end

@implementation MetaDealTool
SingletonM(MetaDealTool)

- (NSArray *)cities
{
    if (!_cities) {
        _cities = [Cities mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [CityGroups mj_objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
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

@end
