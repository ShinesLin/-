//
//  UIBarButtonItem+Extension.m
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
