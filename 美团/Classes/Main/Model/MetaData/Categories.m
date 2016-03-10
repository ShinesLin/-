//
//  Categories.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Categories.h"

@implementation Categories
- (NSString *)title
{
    return _name;
}

- (NSArray *)subTitle
{
    return _subcategories;
}

- (NSString *)image
{
    return _small_icon;
}

- (NSString *)highLightImage
{
    return _small_highlighted_icon;
}

@end
