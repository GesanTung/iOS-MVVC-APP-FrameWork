//
//  TRSMobileDefines.h
//  TRSMobile
//
//  Created by TRS on 14-3-12.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#ifndef TRSMobile_TRSDefines_h
#define TRSMobile_TRSDefines_h

/*
 *移动模板网络请求级别
 *
 */
typedef NS_ENUM(NSInteger, HTTPLevel) {
    HTTPLevelLayout = 0x00,         //一级框架，决定程序采用何种布局
    HTTPLevelChannel,               //二级框架，决定显示界面顶部分类选择
    HTTPLevelList,                  //三级框架，决定中间区域列表显示样式
    HTTPLevelDetail,                //四级框架，对应详细页面的数据请求
    HTTPLevelNormal                 //一般数据请求
};

/*
 *移动模板框架布局定义
 *
 */
typedef NS_ENUM(NSInteger, LayoutStyle) {
    LayoutStyleTabBar = 0x00,       //底部Tabbar菜单栏布局
    LayoutStyleGrid,                //九宫格布局
    LayoutStyleSideBarNormal,       //左右侧边栏菜单布局
    LayoutStyleSideBarOnlyRoot,     //侧边栏菜单布局，无左右侧边栏
    LayoutStyleSideBarOnlyLeft,     //侧边栏菜单布局，仅左侧边栏
    LayoutStyleSideBarOnlyRight,    //侧边栏菜单布局，仅右侧边栏
};

/*
 *移动模板字体颜色
 *
 */
#define UIColorBlack                0x000000
#define UIColorWhite                0xffffff
#define UIColorGrayLight            0x666666
#define UIColorGrayDark             0xEEEEEE
#define UIColorGrayDark1            0xCBCBCB
#define UIColorBlueLight            0x6CACE6
#define UIColorBlueDark             0x3b58aa
#define UIColorDarkRed              0xB22222
#define UIColorDefaultImageBG       0xDDDDDD
#endif
