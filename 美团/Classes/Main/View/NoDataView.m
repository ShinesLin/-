//
//  NoDataView.m
//  美团
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "NoDataView.h"
#import "UIView+AutoLayout.h"
@implementation NoDataView
+(instancetype)noDataView
{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)didMoveToSuperview
{
    //填充整个父控件
    [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

@end
