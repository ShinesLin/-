//
//  DealDropDownMenu.h
//  美团
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DealDropDownMenu;
@protocol DealDropDownMenuItem <NSObject>

@required
/** 标题文字*/
- (NSString *)title;
/** 子标题文字*/
- (NSArray *)subTitle;
@optional
/** 标题的图标*/
- (NSString *)image;
/** 标题的高亮图标*/
- (NSString *)highLightImage;

@end
/** DropdownMenuDelegate  */
@protocol DealDropDownMenuDelegate <NSObject>
- (void)dealDropDownMenu:(DealDropDownMenu *)dealDropDownMenu didSelectMain:(int)mainRow;
- (void)dealDropDownMenu:(DealDropDownMenu *)dealDropDownMenu didSelectSub:(int)subRow ofMain:(int)mainRow;

@optional

@end
@interface DealDropDownMenu : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

/** 显示模型数据，必须遵守DealDropDownMenuItem协议*/
@property (nonatomic,strong)  NSArray *items;

@property (nonatomic,weak) id<DealDropDownMenuDelegate>delegate;

+ (instancetype)menu;
- (void)selectMainRow:(NSUInteger)mainRow;
- (void)selectSubRow:(NSUInteger)subRow;

@end
