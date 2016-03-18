//
//  DealListViewController.m
//  美团
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealListViewController.h"
#import "UIView+AutoLayout.h"
#import "UIView+Extension.h"
#import "DealViewCell.h"
#import "DealDetalsController.h"
#import "NoDataView.h"
#import <MJRefresh.h>

@interface DealListViewController ()<DealViewCellDelegete>

@property (nonatomic,weak) NoDataView *dataView;
@end

@implementation DealListViewController

static NSString * const reuseIdentifier = @"Cell";
- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

- (NoDataView *)dataView
{
    if (_dataView == nil) {
        NoDataView *dataView = [NoDataView noDataView];
        dataView.image = [UIImage imageNamed: self.iconName];
        [self.view insertSubview:dataView belowSubview:self.collectionView];
        self.dataView = dataView;
    }
    return _dataView;
}

- (id)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(305, 305);
    return [super initWithCollectionViewLayout:flow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseView];

}

- (void)setupBaseView
{
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.alwaysBounceVertical = YES;
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealViewCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupLayout:self.view.width orientation:self.interfaceOrientation];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning 判断是否有团购数据，设置view可见性
    self.dataView.hidden = (self.deals.count > 0);
    //判断尾部控件可见性
#warning Incomplete implementation, return the number of items
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DealViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deal" forIndexPath:indexPath];
    cell.delegete = self;
    cell.deal = self.deals[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DealDetalsController *vc = [[DealDetalsController alloc]init];
    vc.deal = self.deals[indexPath.item];
    [self presentViewController:vc animated:YES completion:nil ];
}
@end
