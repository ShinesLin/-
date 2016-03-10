//
//  SearchCityController.m
//  美团
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "SearchCityController.h"
#import "MetaDealTool.h"
#import "Cities.h"

@interface SearchCityController ()
@property (nonatomic,strong) NSArray *resultCities;
@end

@implementation SearchCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    //取得全部城市数组
    NSArray *allCities = [MetaDealTool sharedMetaDealTool].cities;
    NSString *lowerSearchText = searchText.lowercaseString;
    //过滤器
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name.lowercaseString contains %@ or pinYin.lowercaseString contains %@ or pinYinHead.lowercaseString contains %@", lowerSearchText, lowerSearchText, lowerSearchText];
    self.resultCities = [allCities filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    Cities *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%lu个搜索结果",(unsigned long)self.resultCities.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 2.发出通知
    Cities *city = self.resultCities[indexPath.row];
#define SelectedCity @"SelectedCity"
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CityDidSelectNotification" object:nil userInfo:@{SelectedCity : city}];
    
}
@end
