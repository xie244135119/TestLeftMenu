//
//  MainViewController.m
//  Test网易左边栏
//
//  Created by SunSet on 15-5-11.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "MainViewController.h"

typedef void (^AASResponderEndBlock)(NSSet *touches);
@interface AASResponderView : UIView

// 结束响应block
@property(nonatomic, copy) AASResponderEndBlock touchBlock;

@end

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 视图加载
- (void)initContentView
{
    //表单
    UITableView *tab = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tab.backgroundColor = [UIColor blueColor];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellider = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = @"测试测试主视图主视图";
    return cell;
}


#pragma mark - UITableViewDelegate



@end










