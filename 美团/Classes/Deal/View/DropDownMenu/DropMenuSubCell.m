//
//  DropMenuSubCell.m
//  美团
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DropMenuSubCell.h"

@implementation DropMenuSubCell

#pragma mark -初始化
+ (instancetype)cellWithTableCell:(UITableView *)tableView
{
    static NSString *ID = @"sub";
    DropMenuSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DropMenuSubCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"bg_dropdown_rightpart"];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_right_selected"];
        self.selectedBackgroundView = selectedBg;

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
