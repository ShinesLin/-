//
//  CitiesController.m
//  美团
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "CitiesController.h"
#import "NavigationController.h"
#import "CityGroups.h"
#import "MetaDealTool.h"
#import "SearchCityController.h"
#import "UIView+AutoLayout.h"

@interface CitiesController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)closeCity;

@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)coverClick;

/**导航栏顶部间距约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navTopLayouconstraint;

/** 城市组数据 */
@property (strong, nonatomic) NSArray *cityGroups;
@property (nonatomic,weak) SearchCityController *searchCityVC;
@end

@implementation CitiesController
#pragma mark - 懒加载
- (SearchCityController *)searchCityVC
{
    if (!_searchCityVC) {
        SearchCityController *searchCityVC = [[SearchCityController alloc]init];
        [self addChildViewController:searchCityVC];
        self.searchCityVC = searchCityVC;
    }
    return _searchCityVC;
}

- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [MetaDealTool sharedMetaDealTool].cityGroups;
    }
    return _cityGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -UISearchBarDelegate代理方法
//开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    [searchBar setShowsCancelButton:YES animated:YES];
    
    self.navTopLayouconstraint.constant = -62;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.cover.alpha = 0.6;
    }];
}


//结束编辑
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 如果正在dissmis，就不要执行后面代码
    if (self.isBeingDismissed) return;
    
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [searchBar setShowsCancelButton:NO animated:YES];
    self.navTopLayouconstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.cover.alpha = 0;
    }];
    
     searchBar.text = nil;
    //移除城市搜索结果界面
    [self.searchCityVC.view removeFromSuperview];

}

/** 当搜索框文字发生改变时调用*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchCityVC.view removeFromSuperview];
    if (searchText.length > 0) {
        
        [self.view addSubview:self.searchCityVC.view];
        [self.searchCityVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.searchCityVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:searchBar];
    }
    //传递城市搜索条件
    self.searchCityVC.searchText = searchText;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}

#pragma mark -让控制器在fromsheet情况下正常退出
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

#pragma mark -UITableViewDataSource数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CityGroups *group = self.cityGroups[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    CityGroups *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    return cell;
}

#pragma mark -UITableViewDelegate代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CityGroups *group = self.cityGroups[section];
    return group.title;
}

 //Shift + Control + 单击 == 查看在xib\storyboard中重叠的所有UI控件


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // 将cityGroups数组中所有元素的title属性值取出来，放到一个新的数组
    return [self.cityGroups valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 2.发出通知
    CityGroups *group = self.cityGroups[indexPath.section];
    NSString *cityName = group.cities[indexPath.row];
    Cities *city = [[MetaDealTool sharedMetaDealTool] cityWithName:cityName];
#define SelectedCity @"SelectedCity"
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CityDidSelectNotification" object:nil userInfo:@{SelectedCity : city}];
}

- (IBAction)closeCity {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)coverClick {
    [self.view endEditing:YES];
}
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSMutableArray *titles = [NSMutableArray array];
//    for (CityGroups *citys in self.citiesgroup) {
//        [titles addObject:citys];
//    }
//    return titles;
//}
@end
