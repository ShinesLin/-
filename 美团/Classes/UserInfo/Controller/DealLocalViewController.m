//
//  DealLocalViewController.m
//  美团
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealLocalViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "Deals.h"

@interface DealLocalViewController ()
#define EditText @"编辑"
#define DoneText @"完成"
@end

@implementation DealLocalViewController

#pragma mark - 懒加载

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [UIBarButtonItem itemWithImage:@"icon_back" highLightImage:@"icon_back_highlighted" target:self action:@selector(back)];
    }
    return _backItem;
}

- (UIBarButtonItem *)selecteAll
{
    if (!_selecteAll) {
        _selecteAll = [[UIBarButtonItem alloc]initWithTitle:@" 全选 " style:UIBarButtonItemStylePlain target:self action:@selector(select)];
    }
    return _selecteAll;
}

- (UIBarButtonItem *)unselectAll
{
    if (!_unselectAll) {
        _unselectAll = [[UIBarButtonItem alloc]initWithTitle:@" 全不选 " style:UIBarButtonItemStylePlain target:self action:@selector(unselect)];
    }
    return _unselectAll;
}

- (UIBarButtonItem *)selectDelete
{
    if (!_selectDelete) {
        _selectDelete = [[UIBarButtonItem alloc]initWithTitle:@" 删除 " style:UIBarButtonItemStylePlain target:self action:@selector(Delete)];
        self.selectDelete.enabled = NO;
    }
    return _selectDelete;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //返回
    self.navigationItem.leftBarButtonItems = @[self.backItem];
    
    //编辑
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:EditText style:UIBarButtonItemStylePlain target:self action:@selector(eidt)];
}

- (void)eidt
{
    NSString *title = self.navigationItem.rightBarButtonItem.title;
    if ([title isEqualToString:EditText]) {
        self.navigationItem.rightBarButtonItem.title = DoneText;
        //进入编辑状态
        for (Deals *deal in self.deals) {
            deal.Edting = YES;
        }
        [self.collectionView reloadData];
        
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.selecteAll,self.unselectAll,self.selectDelete];
    }else {
        self.navigationItem.rightBarButtonItem.title = EditText;
        for (Deals *deal in self.deals) {
            deal.Edting = NO;
            deal.Checking = NO;
           
        }
        [self.collectionView reloadData];
        // 控制删除item的状态和文字
        [self dealCellClickCover:nil];
        
        self.navigationItem.leftBarButtonItems = @[self.backItem];
    }
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//全选
- (void)select
{
    for (Deals *deal in self.deals) {
        deal.Checking = YES;
    }
    [self.collectionView reloadData];
    [self dealCellClickCover:nil];
}

//全bu选
- (void)unselect
{
    for (Deals *deal in self.deals) {
        deal.Checking = NO;
    }
    [self.collectionView reloadData];
    [self dealCellClickCover:nil];
}

//删除
- (void)Delete
{
    
}

#pragma mark - DealViewCellDelegete代理方法
- (void)dealCellClickCover:(DealViewCell *)dealCell
{
    BOOL defaultEnable = NO;
    int deleteCount = 0;
    for (Deals *deal in self.deals) {
        if (deal.isChecking) {
            defaultEnable = YES;
            deleteCount++;
        }
    }
    self.selectDelete.enabled = defaultEnable;
    if (deleteCount) {
        self.selectDelete.title = [NSString stringWithFormat:@" 删除(%d)",deleteCount];
    }else{
        self.selectDelete.title = @" 删除 ";
    }
    
}

- (NSArray *)willDeleteDeals
{
    NSMutableArray *deleteDeals = [NSMutableArray array];
    for (Deals *deal in self.deals) {
        if (deal.isChecking) {
            [deleteDeals addObject:deal];
            deal.Edting = NO;
            deal.Checking = NO;
        }
    }
    
    [self.deals removeObjectsInArray:deleteDeals];
    [self.collectionView reloadData];
    [self dealCellClickCover:nil];
    
    return deleteDeals;
}
//清除状态
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (Deals *deal in self.deals) {
        deal.Checking = NO;
        deal.Edting = NO;
    }
}

@end
