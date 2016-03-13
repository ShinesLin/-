//
//  DealDetalsController.h
//  美团
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deals;
@class ListPriceCenterLine;
@interface DealDetalsController : UIViewController<UIWebViewDelegate>
@property (nonatomic,strong)  Deals *deal;

- (IBAction)goBack;
- (IBAction)buy;
- (IBAction)collect;
- (IBAction)share;
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 描述*/
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;
/** 原价*/
@property (weak, nonatomic) IBOutlet UILabel *listLabel;
/** 现价*/
@property (weak, nonatomic) IBOutlet ListPriceCenterLine *currentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWithConstraint;
/** 团购展示图片*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/** 支持随时退*/
@property (weak, nonatomic) IBOutlet UIButton *refoundableAnyTimebtn;
/** 支持过期退*/
@property (weak, nonatomic) IBOutlet UIButton *refoundableexpirebtn;
/** 过期时间*/
@property (weak, nonatomic) IBOutlet UIButton *leftTime;
/** 销售量*/
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

@end
