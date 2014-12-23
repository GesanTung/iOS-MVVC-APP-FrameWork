//
//  TungTableController.h
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface TungTableController : UITableViewController
@property(nonatomic,strong)MJRefreshHeaderView *header;
@property(nonatomic,strong)MJRefreshFooterView *footer;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(nonatomic,strong)NSNumber *page;
@property(nonatomic,strong)NSNumber *pageSize;
@property(nonatomic,strong)NSNumber *total;
//刷新标识
@property (nonatomic, assign) BOOL isRefresh;
//标识列表头
@property (nonatomic, assign) BOOL hasHeader;

//标识列表脚
@property (nonatomic, assign) BOOL hasFooter;
@end
