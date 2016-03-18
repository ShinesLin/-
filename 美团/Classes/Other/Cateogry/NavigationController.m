//
//  NavigationController.m
//  美团
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *Baritem = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:29/250.0 green:177/250.0 blue:157/250.0 alpha:1.0];
    [Baritem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    //不可选状态
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [Baritem setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
