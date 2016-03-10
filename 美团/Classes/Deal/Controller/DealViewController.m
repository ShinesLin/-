//
//  DealViewController.m
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealViewController.h"
#import "UIView+Extension.h"
#import "AwesomeMenuItem.h"
#import "UIButton+Extension.h"
#import "UIView+AutoLayout.h"
#import "UIBarButtonItem+Extension.h"
#import "DealTopMenu.h"
#import "DealSortController.h"
#import "DealRegionController.h"
#import "DealCategoryController.h"
#import "Cities.h"
#import "Sorts.h"
#import "Categories.h"
#import "Region.h"
#import "DealsTool.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "AwesomeMenu.h"
#import "DealViewCell.h"
#import "NoDataView.h"


@interface DealViewController ()<AwesomeMenuDelegate>

/** 点击顶部菜单后弹出的Popover */
/** 分类Popover */
@property (strong, nonatomic) UIPopoverController *categoryPopover;
/** 区域Popover */
@property (strong, nonatomic) UIPopoverController *regionPopover;
/** 排序Popover */
@property (strong, nonatomic) UIPopoverController *sortPopover;

/** 顶部菜单 */
/** 分类菜单 */
@property (weak, nonatomic) DealTopMenu *categoryMenu;
/** 区域菜单 */
@property (weak, nonatomic) DealTopMenu *regionMenu;
/** 排序菜单 */
@property (weak, nonatomic) DealTopMenu *sortMenu;

/** 选中的状态 */
@property (nonatomic, strong) Cities *selectedCity;
/** 当前选中的区域 */
@property (strong, nonatomic) Region *selectedRegion;
/** 当前选中的子区域名称 */
@property (copy, nonatomic) NSString *selectedSubRegionName;
/** 当前选中的排序 */
@property (strong, nonatomic) Sorts *selectedSort;
/** 当前选中的分类 */
@property (strong, nonatomic) Categories *selectedCategory;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubCategoryName;
/** 团购模型数据*/
@property (nonatomic,strong) NSMutableArray *deals;

@property (nonatomic,weak) NoDataView *dataView;
@end

@implementation DealViewController

static NSString * const reuseIdentifier = @"Cell";
- (NoDataView *)dataView
{
    if (_dataView == nil) {
        NoDataView *dataView = [[NoDataView alloc]init];
        dataView.image = [UIImage imageNamed:@"icon_deals_empty"];
        [self.view addSubview:dataView];
        self.dataView = dataView;
    }
    return _dataView;
}

- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加通知
    [self setuoNotification];
    
    [self setupUserMenu];
    
    [self setupLeftNavBarItem];
    
    [self setupRightNavBarItem];
   //集成刷新控件
    [self setupRefresh];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupLayout:self.view.width orientation:self.interfaceOrientation];
}

- (void)setupRefresh
{
    
}

#pragma mark - 处理屏幕的旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
#warning 这里要注意：由于是即将旋转，最后的宽度就是现在的高度
    // 总宽度
    CGFloat totalWidth = self.view.height;
    [self setupLayout:totalWidth orientation:toInterfaceOrientation];
}

/**
 *  调整布局
 *
 *  @param totalWidth 总宽度
 *  @param orientation 显示的方向
 */
- (void)setupLayout:(CGFloat)totalWidth orientation:(UIInterfaceOrientation)orientation
{
    //    self.collectionViewLayout == self.collectionView.collectionViewLayout;
    // 总列数
    int columns = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    // 每一行的最小间距
    CGFloat lineSpacing = 25;
    // 每一列的最小间距
    CGFloat interitemSpacing = (totalWidth - columns * layout.itemSize.width) / (columns + 1);
    
    layout.minimumInteritemSpacing = interitemSpacing;
    layout.minimumLineSpacing = lineSpacing;
    // 设置cell与CollectionView边缘的间距
    layout.sectionInset = UIEdgeInsetsMake(lineSpacing, interitemSpacing, lineSpacing, interitemSpacing);
}

#pragma mark - 监听通知
- (void)setuoNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityDidSelceted:) name:@"CityDidSelectNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortDidSelected:) name:@"SortDidSelectNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryDidSelected:) name:@"CategoryDidSelectNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regionDidSelected:) name:@"RegionDidSelectNotification" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cityDidSelceted:(NSNotification *)note
{
    #define SelectedCity @"SelectedCity"
    self.selectedCity = note.userInfo[SelectedCity];
    self.selectedRegion = self.selectedCity.regions[1];
    self.regionMenu.TopTitleView.text =[NSString stringWithFormat:@"%@ - 全部",self.selectedCity.name];
    self.regionMenu.TitleView.text = nil;
    //更换显示数据区域
    DealRegionController *regionVC = (DealRegionController *)self.regionPopover.contentViewController;
    regionVC.regions = self.selectedCity.regions;
    [self.regionPopover dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

- (void)sortDidSelected:(NSNotification *)note
{
    #define SelectedSort @"SelectedSort"
    self.selectedSort = note.userInfo[SelectedSort];
    self.sortMenu.TitleView.text = self.selectedSort.label;
    [self.sortPopover dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

- (void)categoryDidSelected:(NSNotification *)note
{
     #define SelectCategory @"CategoryDidSelect"
    self.selectedCategory =note.userInfo[SelectCategory];
    #define SelectedSubCategoryName @"SelectedSubCategoryName"
    self.selectedSubCategoryName = note.userInfo[SelectedSubCategoryName];
    
    self.categoryMenu.ImageButton.image = self.selectedCategory.icon;
    self.categoryMenu.ImageButton.highlightedImage = self.selectedCategory.highlighted_icon;
    self.categoryMenu.TopTitleView.text = self.selectedCategory.name;
    self.categoryMenu.TitleView.text = self.selectedSubCategoryName;
    
    [self.categoryPopover dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

- (void)regionDidSelected:(NSNotification *) note
{
#define SelectedRegion @"RegionDidSelect"
      self.selectedRegion = note.userInfo[SelectedRegion];
#define SelectedSubRegionName @"SelectedSubRegionName"
      self.selectedSubRegionName = note.userInfo[SelectedSubRegionName];
    self.regionMenu.TopTitleView.text = [NSString stringWithFormat:@"%@ - %@",self.selectedCity.name,self.selectedRegion.name];
    self.regionMenu.TitleView.text = self.selectedSubRegionName;
    
    [self.regionPopover dismissPopoverAnimated:YES];
    [self loadNewDeals];
}

#pragma mark - 加载团购数据
- (void)loadNewDeals
{
    FindDealsParams *params = [[FindDealsParams alloc]init];
    //城市
    params.city = self.selectedCity.name;
    //排序
    if (self.selectedSort) {
        params.sort = @(self.selectedSort.value);
    }
    //除开“全部分类”和"全部"以外的词语都可以发送
    if (self.selectedCategory && ![self.selectedCategory.name isEqualToString:@"全部分类"]) {
        if (self.selectedSubCategoryName && ![self.selectedSubCategoryName isEqualToString:@"全部"]) {
            params.category = self.selectedSubCategoryName;;
        }else{
            params.category = self.selectedCategory.name;
        }
    }
    //区域
    if (self.selectedRegion &&![self.selectedRegion.name isEqualToString:@"全部"]) {
        if (self.selectedSubRegionName && ![self.selectedSubRegionName isEqualToString:@"全部"]) {
            params.region = self.selectedSubRegionName;
        }else{
            params.region = self.selectedRegion.name;
        }
    }
   
    [DealsTool findDeals:params success:^(FindDealsResult *result) {
        // 清空之前的所有数据
        [self.deals removeAllObjects];
        // 添加新的数据
        [self.deals addObjectsFromArray:result.deals];
        // 刷新表格
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        //[MBProgressHUD showError:@"加载团购失败,请稍后再试"];
    }];
}

#pragma mark - 懒加载UIPopoverController
- (UIPopoverController *)categoryPopover
{
    if (_categoryPopover == nil) {
        DealCategoryController *vc = [[DealCategoryController alloc]init];
        _categoryPopover = [[UIPopoverController alloc]initWithContentViewController:vc];
    }
    return _categoryPopover;
}

- (UIPopoverController *)regionPopover
{
    if (_regionPopover == nil) {
        DealRegionController *rc = [[DealRegionController alloc]init];
        
        _regionPopover = [[UIPopoverController alloc]initWithContentViewController:rc];
    }
   
    return _regionPopover;
}

- (UIPopoverController *)sortPopover
{
    if (_sortPopover == nil) {
        DealSortController *sc = [[DealSortController alloc]init];
        _sortPopover = [[UIPopoverController alloc]initWithContentViewController:sc];
    }
    return _sortPopover;
}

#pragma mark 导航栏
- (void)setupLeftNavBarItem
{
    UIBarButtonItem *Logo = [UIBarButtonItem itemWithImage:@"icon_meituan_logo" highLightImage:@"icon_meituan_logo" target:nil action:nil];
    Logo.customView.userInteractionEnabled = NO;
    
    DealTopMenu *categoryMenu = [DealTopMenu menu];
    [categoryMenu addTarget:self action:@selector(categoryMenuClick)];
    UIBarButtonItem *catagories = [[UIBarButtonItem alloc]initWithCustomView:categoryMenu];
    self.categoryMenu = categoryMenu;
    
    DealTopMenu *regionMenu = [DealTopMenu menu];
    regionMenu.ImageButton.image = @"icon_district";
    regionMenu.ImageButton.highlightedImage = @"icon_district_highlighted";
    [regionMenu addTarget:self action:@selector(RegionMenuClick)];
    UIBarButtonItem *region = [[UIBarButtonItem alloc]initWithCustomView:regionMenu];
    self.regionMenu = regionMenu;
    
    DealTopMenu *sortMenu = [DealTopMenu menu];
    sortMenu.ImageButton.image = @"icon_sort";
    sortMenu.ImageButton.highlightedImage = @"icon_sort_highlighted";
    sortMenu.TopTitleView.text = @"排序";
    [sortMenu addTarget:self action:@selector(SortMenuClick)];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc]initWithCustomView:sortMenu];
    self.sortMenu = sortMenu;
    
    
    self.navigationItem.leftBarButtonItems = @[Logo,catagories,region,sort];
}

#pragma mark - 导航栏左边处理事件
- (void)categoryMenuClick
{
    DealCategoryController *vc = (DealCategoryController *)self.categoryPopover.contentViewController;
    vc.selectedCategory = self.selectedCategory;
    vc.selectedSubCategoryName = self.selectedSubCategoryName;
    
    [self.categoryPopover presentPopoverFromRect:self.categoryMenu.bounds inView:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)RegionMenuClick
{
    DealRegionController *vc = (DealRegionController *)self.regionPopover.contentViewController;
    vc.selectedRegion = self.selectedRegion;
    vc.selectedSubRegionName = self.selectedSubRegionName;
    
    [self.regionPopover presentPopoverFromRect:self.regionMenu.bounds inView:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)SortMenuClick
{
    DealSortController *vc = (DealSortController *)self.sortPopover.contentViewController;
    vc.selectedSort = self.selectedSort;
    [self.sortPopover presentPopoverFromRect:self.sortMenu.bounds inView:self.sortMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - 导航栏右边处理事件
- (void)setupRightNavBarItem
{
    UIBarButtonItem *Mapitem = [UIBarButtonItem itemWithImage:@"icon_map" highLightImage:@"icon_map_highlighted" target:self action:@selector(mapClick)];
    Mapitem.customView.width = 50;
    Mapitem.customView.height = 27;
    
    UIBarButtonItem *Searchitem = [UIBarButtonItem itemWithImage:@"icon_search" highLightImage:@"icon_search_highlighted" target:self action:@selector(SearchClick)];
    Searchitem.customView.width = Mapitem.customView.width;
    Searchitem.customView.height = Mapitem.customView.height;
    
    self.navigationItem.rightBarButtonItems = @[Mapitem,Searchitem];
}

- (void)mapClick
{
    
}

- (void)SearchClick
{
    
}

//创建一个path菜单
- (AwesomeMenuItem *)itemWithContent:(NSString *)content highlightedContentImage:(NSString *)highlightedContentImage
{
    UIImage *bg = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
    return [[AwesomeMenuItem alloc]initWithImage:bg
                                highlightedImage:nil
                                    ContentImage:[UIImage imageNamed:content]
                         highlightedContentImage:[UIImage imageNamed:highlightedContentImage]];
}

#pragma mark - 左下角菜单按钮
- (void)setupUserMenu
{
    AwesomeMenuItem *MineMenu = [self itemWithContent:@"icon_pathMenu_mine_normal" highlightedContentImage:@"icon_pathMenu_mine_highlighted"];
    
    AwesomeMenuItem *CollectMenu = [self itemWithContent:@"icon_pathMenu_collect_normal" highlightedContentImage:@"icon_pathMenu_collect_highlighted"];
    
    AwesomeMenuItem *ScanlMenu = [self itemWithContent:@"icon_pathMenu_scan_normal" highlightedContentImage:@"icon_pathMenu_scan_highlighted"];
    
    AwesomeMenuItem *MoreMenu = [self itemWithContent:@"icon_pathMenu_more_normal" highlightedContentImage:@"icon_pathMenu_more_highlighted"];
    
     NSArray *items = @[MineMenu,CollectMenu,ScanlMenu,MoreMenu];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc]
        initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"]
        highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"]
        ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"]
        highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem menuItems:items];
    
    [self.view addSubview:menu];
    //添加约束
     menu.menuWholeAngle = M_PI_2;
    CGFloat menuH = 200;
    [menu autoSetDimensionsToSize:CGSizeMake(200, menuH)];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    //添加模糊效果
    UIImageView *bgImageview = [[UIImageView alloc]init];
    bgImageview.image = [UIImage imageNamed:@"icon_pathMenu_background"];
    [menu insertSubview:bgImageview atIndex:0];
    
    [bgImageview autoSetDimensionsToSize:bgImageview.image.size];
    [bgImageview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [bgImageview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
     menu.startPoint = CGPointMake(menu.image.size.width * 0.5, menuH - bgImageview.image.size.height * 0.5);
    //禁止旋转
    menu.rotateAddButton = NO;
    menu.alpha = 0.3;
    menu.delegate = self;
    
}

#pragma mark AwesomeMenuDelegate代理方法

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    
    NSLog(@"didSelectIndex-%d", idx);
    [self awesomeMenuWillAnimateClose:menu];
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    
    menu.alpha = 1.0;
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    // 恢复图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
    [UIView animateWithDuration:0.25 animations:^{
        menu.alpha = 0.3;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return self.deals.count;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning 判断是否有团购数据，设置view可见性
    self.dataView.hidden = self.deals.count > 0;
#warning Incomplete implementation, return the number of items
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DealViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deal" forIndexPath:indexPath];
    cell.deal = self.deals[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


@end
