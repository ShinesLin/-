//
//  DealRegionController.m
//  美团
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealRegionController.h"
#import "DealDropDownMenu.h"
#import "UIView+AutoLayout.h"
#import "MetaDealTool.h"
#import "Cities.h"
#import "CitiesController.h"
#import "Region.h"

@interface DealRegionController ()
- (IBAction)changeCity;
@property (nonatomic,weak) DealDropDownMenu *menu;

@end

@implementation DealRegionController
- (DealDropDownMenu *)menu
{
    if (!_menu) {
        //拿到顶部工具条View
        UIView *topView = [self.view.subviews firstObject];
        
        DealDropDownMenu *menu = [DealDropDownMenu menu];
        //    MetaDealTool *tool = [MetaDealTool sharedMetaDealTool];
        //    Cities *city = [tool cityWithName:@"北京"];
        //    menu.items = city.regions;
        [self.view addSubview:menu];
        // ALEdgeTop == topView的ALEdgeTop
        [menu autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView];
        // 除开顶部，其他方向距离父控件的间距都为0
        [menu autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        self.preferredContentSize = CGSizeMake(400, 480);
        menu.delegate = self;
        self.menu = menu;
    }
    return _menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

# pragma mark - 公共方法
- (void)setRegions:(NSArray *)regions
{
    _regions = regions;
    self.menu.items = regions;
}

- (void)setSelectedRegion:(Region *)selectedRegion
{
    _selectedRegion = selectedRegion;
    NSUInteger mainRow = [self.menu.items indexOfObject:selectedRegion];
    [self.menu selectMainRow:mainRow];
}

- (void)setSelectedSubRegionName:(NSString *)selectedSubRegionName
{
    _selectedSubRegionName = [selectedSubRegionName copy];
    NSUInteger subRow = [self.selectedRegion.subregions indexOfObject:selectedSubRegionName];
    [self.menu selectSubRow:subRow];
}

- (IBAction)changeCity {
   
    UIPopoverController *popOver =  [self valueForKeyPath:@"_popoverController"];
    [popOver dismissPopoverAnimated:YES];
    
    CitiesController *cityVc = [[CitiesController alloc]init];
    cityVc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:cityVc animated:YES completion:nil];
    
    
}

#pragma mark - DealDropDownMenuDelegate代理方法
- (void)dealDropDownMenu:(DealDropDownMenu *)dealDropDownMenu didSelectMain:(int)mainRow
{
    Region *Selectregions = dealDropDownMenu.items[mainRow];
    if (Selectregions.subregions.count == 0) {
#define  SelectRegion @"RegionDidSelect"
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RegionDidSelectNotification" object:nil userInfo:@{SelectRegion :Selectregions}];
    }
    
}

- (void)dealDropDownMenu:(DealDropDownMenu *)dealDropDownMenu didSelectSub:(int)subRow ofMain:(int)mainRow
{
    NSMutableDictionary *useInfo = [NSMutableDictionary dictionary];
    Region *selectmainRow = dealDropDownMenu.items[mainRow];
#define SelectedRegion @"RegionDidSelect"
    useInfo[SelectRegion] = selectmainRow;
#define SelectedSubRegionName @"SelectedSubRegionName"
    useInfo[SelectedSubRegionName] = selectmainRow.subregions[subRow];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"RegionDidSelectNotification" object:nil userInfo:useInfo];
    
}
@end
