//
//  ViewController.m
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.

#import "ViewController.h"
#import "TungTableController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"首页"];
    [self setNavRightBtn:@"提交"];
    
    TungTableController *table = [[TungTableController alloc]init];
    table.hasHeader =table.hasFooter = YES;
    table.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-114);
    table.parameter = @{@"cell" : @"PageCell",@"dataurl" : @"http://www.tibetbss.cn/api.php?mod=xzksPlazalist"};
    
    [self.view addSubview:table.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
