//
//  DealViewCell.h
//  美团
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deals.h"
@class DealViewCell;

@protocol DealViewCellDelegete <NSObject>

@optional
- (void)dealCellClickCover:(DealViewCell *)dealCell;

@end
@interface DealViewCell : UICollectionViewCell

/** 团购模型*/
@property (nonatomic,strong)  Deals *deal;

/** 占位图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 标题文字*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 描述文字*/
@property (weak, nonatomic) IBOutlet UILabel *describLabel;
/** 现价*/
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
/** 原价*/
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
/** 销售量*/
@property (weak, nonatomic) IBOutlet UILabel *purseCountLabel;
/** 原价宽度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentPriceConstrain;
/** 现价宽度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listPriceConstrain;
/** 显示新单图片*/
@property (weak, nonatomic) IBOutlet UIImageView *dealNewView;
/** 打钩图片*/
@property (weak, nonatomic) IBOutlet UIImageView *clickImage;
/** 遮盖按钮*/
@property (weak, nonatomic) IBOutlet UIButton *cover;

@property (nonatomic,weak) id<DealViewCellDelegete> delegete;

- (IBAction)coverClick;

@end
