//
//  MJRefreshTableFooterView.h
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshBaseView.h"
#import <Foundation/Foundation.h>
@interface MJRefreshFooterView : MJRefreshBaseView

//有无更多判断标志
@property (nonatomic, assign) BOOL hasMore;

+ (instancetype)footer;

@end