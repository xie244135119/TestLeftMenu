//
//  XQMenuController.h
//  Test网易左边栏
//
//  Created by SunSet on 15-5-11.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#define AASLeftViewControllerWidth       250           //左侧视图宽度

#import <UIKit/UIKit.h>

@interface XQMenuController : UIViewController



@property(nonatomic, strong) UIViewController *leftViewController;        //左侧控制器
@property(nonatomic, strong) UIViewController *mainViewController;        //主控制器


//实例化
- (id)initWithLeftViewController:(UIViewController *)leftViewController
              mainViewController:(UIViewController *)mainViewController;

// 显示和隐藏左侧视图
- (void)showLeftView;
- (void)hideLeftView;



@end
