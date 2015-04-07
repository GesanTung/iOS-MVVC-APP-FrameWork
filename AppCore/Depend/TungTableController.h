//
//  TungTableController.h
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "MJRefresh.h"
#import "DataLog.h"
@interface TungTableController : UITableViewController
{
    DataLog  *loglayer;
}
@property(nonatomic,strong)DataLog  *loglayer;
@property(nonatomic,strong)MJRefreshHeaderView *header;
@property(nonatomic,strong)MJRefreshFooterView *footer;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary *parameter;
@property(nonatomic,strong)NSNumber *page;
@property(nonatomic,strong)NSNumber *pageSize;
@property(nonatomic,strong)NSNumber *total;

@property (nonatomic,assign) int gPageIndex;

@property (nonatomic,assign) int gPageTotal;
//刷新标识
@property (nonatomic, assign) BOOL isRefresh;
//标识列表头
@property (nonatomic, assign) BOOL hasHeader;
//标识列表脚
@property (nonatomic, assign) BOOL hasFooter;
@end
