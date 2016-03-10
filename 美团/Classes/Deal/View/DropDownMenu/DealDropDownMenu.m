//
//  DealDropDownMenu.m
//  美团
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealDropDownMenu.h"
#import "DropDownMainCell.h"
#import "DropMenuSubCell.h"

@implementation DealDropDownMenu

+ (instancetype)menu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DealDropDownMenu" owner:nil options:nil]lastObject];
}

#pragma mark -公共方法
- (void)setItems:(NSArray *)items
{
    _items = items;
    //刷新表格，调用下面两个数据源方法
    [self.mainTableView reloadData];
    [self.subTableView reloadData];
}

- (void)selectMainRow:(NSUInteger)mainRow
{
    [self.mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:mainRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.subTableView reloadData];
}

- (void)selectSubRow:(NSUInteger)subRow
{
    [self.subTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:subRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDataSource数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return self.items.count;
    }else{
        //得到mainTableView选中的行
       NSInteger mainRow = [self.mainTableView indexPathForSelectedRow].row;
        id<DealDropDownMenuItem> item = self.items[mainRow];
        return [item subTitle].count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        DropDownMainCell *mainCell = [DropDownMainCell cellWithTableViewcell:tableView];
        mainCell.items = self.items[indexPath.row];
        return mainCell;
    }else{
        DropMenuSubCell *subCell = [DropMenuSubCell cellWithTableCell:tableView];
        NSInteger mainRow = [self.mainTableView indexPathForSelectedRow].row;
        id<DealDropDownMenuItem> item = self.items[mainRow];
        subCell.textLabel.text = [item subTitle][indexPath.row];
        return subCell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {//左边主表
        [self.subTableView reloadData];
        //通知代理
        if ([self.delegate respondsToSelector:@selector(dealDropDownMenu:didSelectMain:)]) {
            [self.delegate dealDropDownMenu:self didSelectMain:indexPath.row];
        }
    }else{//右边从表
        if ([self.delegate respondsToSelector:@selector(dealDropDownMenu:didSelectSub:ofMain:)]) {
            
            int mainRow = [self.mainTableView indexPathForSelectedRow].row;
            [self.delegate dealDropDownMenu:self didSelectSub:indexPath.row ofMain:mainRow];
        }
    }
}


//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    if (tableView == self.mainTableView) {
//        cell.textLabel.text = [NSString stringWithFormat:@"main ---%d",indexPath.row];
//    }else{
//        cell.textLabel.text = [NSString stringWithFormat:@"sub-----%d",indexPath.row];
//    }
//
//    return cell;

/**
 *  一个UI控件即将被添加到窗口中就调用
 */
//- (void)willMoveToWindow:(UIWindow *)newWindow
//{
    //    self.mainTableView.backgroundColor = [UIColor redColor];
    //    self.subTableView.backgroundColor = [UIColor blueColor];
//}
@end
