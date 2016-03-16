//
//  DealCollectController.m
//  美团
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealCollectController.h"
#import "UIBarButtonItem+Extension.h"

@interface DealCollectController ()

@end

@implementation DealCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_back" highLightImage:@"icon_back_highlighted" target:self action:@selector(back)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)iconName
{
    return @"icon_collects_empty";
}
@end
