//
//  LeftViewController.m
//  Test网易左边栏
//
//  Created by SunSet on 15-5-11.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initContentView];
    
    NSLog(@" %f ",self.view.frame.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 视图加载
- (void)initContentView
{
    self.view.layer.borderWidth = 1;
    //表单
    UITableView *tab = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tab.backgroundColor = [UIColor redColor];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    
    //自动匹配父视图的大小
    tab.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
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
    cell.textLabel.text = @"测试测试左视图左视图";
    return cell;
}


@end








