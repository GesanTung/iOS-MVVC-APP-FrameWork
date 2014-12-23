//
//  TungTableController.m
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "TungTableController.h"

@interface TungTableController ()

@end

@implementation TungTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addFooter
{
    if(!_hasFooter) {return;}
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        // 在此发起网络请求加载更多数据
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
        self.isRefresh = NO;
        //[self HTTPRequest:HTTPLevelList];
    };
    _footer = footer;
}

- (void)addHeader
{
    if(!_hasHeader) {self.isRefresh = YES;
        //[self HTTPRequest:HTTPLevelList];
        return;
    }
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        // 在此发起网络请求加载更多数据
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
        self.isRefresh = YES;
        if(_footer) {[_footer setHasMore:YES];}
//        [self HTTPRequest:HTTPLevelList];
    };
    
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
        [refreshView endRefreshingWithoutIdle];
    };
    
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

//刷新组件操作完成
- (void)didMJRefreshFinished:(MJRefreshBaseView *)refreshView
{
    //刷新列表和顶部推荐大图
    [self.tableView reloadData];
  
    //(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self endRefreshing];
}

//开始刷新
- (void)beginRefreshing
{
    [_header beginRefreshing];
}

//结束刷新
- (void)endRefreshing
{
    if(_header) {[_header endRefreshing];}
    if(_footer) {
        [_footer setHasMore:([_page integerValue] < [_total integerValue] - 1)];
        [_footer endRefreshing];
    }
}


@end
