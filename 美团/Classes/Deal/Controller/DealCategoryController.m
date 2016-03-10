//
//  DealCategoryController.m
//  美团
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealCategoryController.h"
#import "DealDropDownMenu.h"
#import "UIView+Extension.h"
#import "MetaDealTool.h"
#import "Categories.h"
@interface DealCategoryController ()
@property (nonatomic,weak) DealDropDownMenu *menu;
@end

@implementation DealCategoryController

- (void)loadView
{
    DealDropDownMenu *menu = [DealDropDownMenu menu];
    menu.delegate = self;
    menu.items = [MetaDealTool sharedMetaDealTool].categories;
    self.menu = menu;
    self.view = menu;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(400, 480);
    //    self.preferredContentSize = self.view.size;
    
}
#warning 重点掌握以下两个代理方法

#pragma mark - dealDropDownMenu代理方法
- (void)dealDropDownMenu:(DealDropDownMenu *)dealDropDownMenu didSelectMain:(int)mainRow
{
    Categories *selectMainrow = dealDropDownMenu.items[mainRow];
    if (selectMainrow.subcategories.count == 0) {
#define SelectCategory @"CategoryDidSelect"
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CategoryDidSelectNotification" object:nil userInfo:@{SelectCategory : selectMainrow}];
    }
}

- (void)dealDropDownMenu:(DealDropDownMenu *)dealDropDownMenu didSelectSub:(int)subRow ofMain:(int)mainRow
{
    NSMutableDictionary *useInfo = [NSMutableDictionary dictionary];
    Categories *selecttMainrow = dealDropDownMenu.items[mainRow];
    #define SelectedCategory @"CategoryDidSelect"
    useInfo[SelectedCategory] = selecttMainrow;
    #define SelectedSubCategoryName @"SelectedSubCategoryName"
    useInfo[SelectedSubCategoryName] = selecttMainrow.subcategories[subRow];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CategoryDidSelectNotification" object:nil userInfo:useInfo];
}

#pragma mark - 公共方法
- (void)setSelectedCategory:(Categories *)selectedCategory
{
    _selectedCategory = selectedCategory;
    NSUInteger mainRow = [self.menu.items indexOfObject:selectedCategory];
    [self.menu selectMainRow:mainRow];
    
}

- (void)setSelectedSubCategoryName:(NSString *)selectedSubCategoryName
{
    _selectedSubCategoryName = [selectedSubCategoryName copy];
    NSUInteger subRow = [self.selectedCategory.subcategories indexOfObject:selectedSubCategoryName];
    [self.menu selectSubRow:subRow];
    
}

@end
