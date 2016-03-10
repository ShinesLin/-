//
//  DealTopMenu.h
//  美团
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealTopMenu : UIView
/**顶部标题*/
@property (weak, nonatomic) IBOutlet UILabel *TopTitleView;
/**标题图标*/
@property (weak, nonatomic) IBOutlet UIButton *ImageButton;
/**子标题*/
@property (weak, nonatomic) IBOutlet UILabel *TitleView;

- (void)addTarget:(id)target action:(SEL)action;

+ (instancetype)menu;
@end
