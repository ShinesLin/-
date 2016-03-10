//
//  ListPriceCenterLine.m
//  美团
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "ListPriceCenterLine.h"
#import "UIView+Extension.h"
@implementation ListPriceCenterLine


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //设置绘图颜色
    [self.textColor set];
    //设置矩形框线
    CGFloat x = 0;
    CGFloat y = self.height * 0.5;
    CGFloat w = self.width;
    CGFloat h = 0.5;
   
    UIRectFill(CGRectMake(x, y, w, h));
}


@end
