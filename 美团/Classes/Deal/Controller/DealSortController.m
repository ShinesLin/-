//
//  DealSortController.m
//  美团
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealSortController.h"
#import "MetaDealTool.h"
#import "UIView+Extension.h"
#import "Sorts.h"
#import "UIButton+Extension.h"
#pragma mark -自定义按钮
@interface LSbutton : UIButton
@property (nonatomic,strong) Sorts *sort;
@end

@implementation LSbutton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bgImage = @"btn_filter_normal";
        self.selectedBgImage = @"btn_filter_selected";
        self.titleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setSort:(Sorts *)sort
{
    _sort = sort;
    self.title = sort.label;
}

@end

#pragma mark -控制器代码
@interface DealSortController ()
@property (nonatomic,weak) LSbutton *selectedButton;
@end

@implementation DealSortController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置自定义xib中popover的尺寸
    self.preferredContentSize = self.view.size;
    
    //取出sort里的排序数据
    NSArray *sorts = [MetaDealTool sharedMetaDealTool].sorts;
    NSUInteger count = sorts.count;
    CGFloat btnX = 20;
    CGFloat margin = 15;
    CGFloat btnW = self.view.width - 2*btnX;
    CGFloat contsizeH = 0;
    for (NSUInteger i = 0; i < count; i++) {
        //创建按钮
        LSbutton *btn = [[LSbutton alloc]init];
        btn.sort = sorts[i];
        //设置尺寸
        btn.x = btnX;
        btn.width = btnW;
        btn.height = 30;
        btn.y = margin + i * (btn.height + margin);
        //添加监听事件
        [btn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchDown];
        contsizeH = btn.maxY + margin;
        [self.view addSubview:btn];
    }
    
    UIScrollView *scroll = (UIScrollView *)self.view;
    scroll.contentSize = CGSizeMake(0, contsizeH);
}

- (void)selectedBtnClick:(LSbutton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    //发出通知
#define SelectedSort @"SelectedSort"
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SortDidSelectNotification" object:nil userInfo:@{ SelectedSort : button.sort}];
   
}

- (void)setSelectedSort:(Sorts *)selectedSort
{
    _selectedSort = selectedSort;
    for (LSbutton *button in self.view.subviews) {
        if ([button isKindOfClass:[LSbutton class]] && button.sort == selectedSort) {
            self.selectedButton.selected = NO;
            button.selected = YES;
            self.selectedButton = button;
        }
    }
}

@end
