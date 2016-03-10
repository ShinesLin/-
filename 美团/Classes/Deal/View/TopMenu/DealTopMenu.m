//
//  DealTopMenu.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealTopMenu.h"
#import "UIButton+Extension.h"
@implementation DealTopMenu

+ (instancetype)menu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DealTopMenu" owner:nil options:nil] lastObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
#warning 禁止默认的拉伸现象
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self.ImageButton addTarget:target action:action];
}
@end
