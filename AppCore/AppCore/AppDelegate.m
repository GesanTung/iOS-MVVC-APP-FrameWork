//
//  AppDelegate.m
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "AppDelegate.h"
#import "AppLayoutCenter.h"
#import "Globals.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // Override point for customization after application launch.
    //注册应用启动的一些服务
    //to do配置app样式
    [self loadApp];
    
    //请求服务器一级框架决定应用框架显示

    [self.window makeKeyAndVisible];
   //to do注册服务
    

    return YES;
}
-(void)loadApp{
    [[AppLayoutCenter sharedAppLayoutCenter]loadFromBundleWithFileName:@"applayout"];
    //根据返回的数据决定底部TabBar的显示. 类型为Tabbar且count=1时，默认不显示Tabbabr。
    id datas = [[AppLayoutCenter sharedAppLayoutCenter]getTabBarList];
    int c_total = [datas count];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3];
    [datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *controller = [[AppLayoutCenter sharedAppLayoutCenter]controllerWithDictionary:obj];
        [arr addObject:controller];
    }];

    //底部TabBar控制器
    self.tabBarController = [[CMTabBarController alloc] initWithViewControllers:arr];
    
    //此处设置底部TabBar显示数据，放在"设置主视窗"后，是因为tabBar是在tabBarController的loadView()函数加载的，放在前面设置数据时，而tabBar未被初始化.
    self.tabBarController.tabBar.hidden = (c_total == 1);
    [self.tabBarController.tabBar setItems:datas animated:YES];
    
    //底部有TabBar时顶层的根导航器，用于在TabBar子视图控制器PUSH操作时，显示的视图高度不够，默认减去了底部TabBar的高度
    self.navigationController = [[KKNavigationController alloc] initWithRootViewController:self.tabBarController];
    self.navigationController.navigationBarHidden = YES;
    
    //最外层的左右侧边栏控制器，此控制器为最高级别，在底部Tabbar或九宫格样式时默认不开启左右侧边栏即可
    self.revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:self.navigationController];
    self.revealSideViewController.type = PPRevealSideOnObove;
    //禁用左右侧边栏控制器的滑出弹跳效果
    [self.revealSideViewController resetOption:PPRevealSideOptionsBounceAnimations];
    
    //设置主视窗
    self.window.rootViewController = self.revealSideViewController;
    
    self.revealSideViewController.directionsToShowBounce = PPRevealSideDirectionNone;
}
- (void)updateThisUI:(NSString *)url level:(HTTPLevel)level JSON:(id)JSON
{

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
