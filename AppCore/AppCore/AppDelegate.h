//
//  AppDelegate.h
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMTabBarController;
@class PPRevealSideViewController;
@class KKNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//应用的主视窗
@property (strong, nonatomic) UIWindow *window;

//底部TabBar控制器
@property (strong, nonatomic) CMTabBarController            *tabBarController;

//底部有TabBar时顶层的根导航器，用于在TabBar子视图控制器PUSH操作时，显示的视图高度不够，默认减去了底部TabBar的高度
@property (strong, nonatomic) KKNavigationController        *navigationController;

//最外层的左右侧边栏控制器，此控制器为最高级别，在底部Tabbar或九宫格样式时默认不开启左右侧边栏即可
@property (strong, nonatomic) PPRevealSideViewController    *revealSideViewController;

@end

