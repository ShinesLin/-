//
//  Categories.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Categories.h"
#import "MJExtension.h"

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
//所有成员属性存入沙盒
MJCodingImplementation
@end
