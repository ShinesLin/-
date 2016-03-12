//
//  DealDetalsController.h
//  美团
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deals;
@interface DealDetalsController : UIViewController<UIWebViewDelegate>
@property (nonatomic,strong)  Deals *deal;

@end
