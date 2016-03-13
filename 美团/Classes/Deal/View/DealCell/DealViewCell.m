//
//  DealViewCell.m
//  美团
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@implementation DealViewCell

- (void)setDeal:(Deals *)deal
{
    _deal = deal;
    /**显示图片*/
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    /**显示文字标题*/
    self.titleLabel.text = deal.title;
    /**显示描述文字*/
    self.describLabel.text = deal.desc;
    self.describLabel.numberOfLines = 0;
    /**显示现价*/
   
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", deal.current_price];
    self.currentPriceConstrain.constant = [self.currentPriceLabel.text sizeWithAttributes:@{NSFontAttributeName : self.currentPriceLabel.font}].width + 1;
    
    /**显示原价*/
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%@",deal.list_price];
    self.listPriceConstrain.constant = [self.listPriceLabel.text sizeWithAttributes:@{NSFontAttributeName : self.listPriceLabel.font}].width + 1;
    /**显示销售量*/
    self.purseCountLabel.text = [NSString stringWithFormat:@"已售出%d",deal.purchase_count];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *today = [fmt stringFromDate:[NSDate date]];
    
    self.dealNewView.hidden =([deal.publish_date compare:today] == NSOrderedDescending);
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}

@end
