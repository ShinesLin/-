//
//  UIBarButtonItem+Extension.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action;
@end
