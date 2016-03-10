//
//  DropDownMainCell.m
//  美团
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DropDownMainCell.h"

@implementation DropDownMainCell

#pragma mark -懒加载
- (UIImageView *)Rightaccessory
{
    if (_Rightaccessory == nil) {
        self.Rightaccessory = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_filter_arrow"]];
    }
    return _Rightaccessory;
}

#pragma mark -初始化
+ (instancetype)cellWithTableViewcell:(UITableView *)tableView
{
    static NSString *ID = @"main";
   
    DropDownMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DropDownMainCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView = selectedBg;

    };
    return self;
}

#pragma mark -公共方法
- (void)setItems:(id<DealDropDownMenuItem>)items
{
    _items = items;
    //设置标题
    self.textLabel.text = [items title];
    //设置图标
    if ([items respondsToSelector:@selector(image)]) {
        self.imageView.image = [UIImage imageNamed:[items image]];
    }
    
    if ([items respondsToSelector:@selector(highLightImage)]) {
        self.imageView.highlightedImage = [UIImage imageNamed:[items highLightImage]];
    }
    
    //设置箭头
    if ([items subTitle].count > 0) {
        self.accessoryView = self.Rightaccessory;
    }else{
        self.accessoryView = nil;
    }
}



@end
