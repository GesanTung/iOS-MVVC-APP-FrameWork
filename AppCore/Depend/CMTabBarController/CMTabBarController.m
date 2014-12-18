//
//  CMTabBarController.m
//
//  Created by Constantine Mureev on 13.03.12.
//  Copyright (c) 2012 Team Force LLC. All rights reserved.
//

#import "CMTabBarController.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface CMTabBarController ()

@property (assign) BOOL         firstAppear;

- (CGRect)frameForViewControllers;

@end


@implementation CMTabBarController

@synthesize firstAppear;
@synthesize viewControllers, selectedIndex, tabBar=_tabBar, delegate;
@dynamic selectedViewController;

static CMTabBarController* sharedInstance = nil;

- (instancetype)initWithViewControllers:(NSArray *)controllers
{
    if(self = [super init]) {
        self.viewControllers = controllers;
        [self initTabBar];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    self.viewControllers = nil;
    self.tabBar.delegate = nil;
    self.tabBar = nil;
    self.delegate = nil;
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor whiteColor];
    self.firstAppear = YES;
    for (UIViewController* vc in self.viewControllers) {
        [vc loadView];
    }
}

- (void)initTabBar
{
    /*此处可自行修改根据项目定义Tabbar样式，或从xib文件加载*/
    CGRect frame_tab = CGRectMake(0, self.view.frame.size.height - CGHeightTabbar, [[UIScreen mainScreen] bounds].size.width, CGHeightTabbar);
    self.tabBar = [[CMTabBar alloc] initWithFrame:frame_tab];
    self.tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.tabBar.delegate = self;
    [self.view addSubview:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (firstAppear) {
        // Custom logic
        
        //修正程序在第一次启动时，在IOS6.0版本上显示顶部有20px黑色区域未显示问题。
        [self.tabBar setSelectedIndex:self.selectedIndex];
        /*
        NSMutableArray* tabBarItems = [NSMutableArray array];
        CGRect newFrame = [self frameForViewControllers];
        for (UIViewController* vc in self.viewControllers) {
            [tabBarItems addObject:vc.tabBarItem];
            // Update frame to real size ()
            vc.view.frame = newFrame;
        }
        [self.view addSubview:self.selectedViewController.view];        
        [self.view bringSubviewToFront:self.tabBar];
        */
        
        self.firstAppear = NO;
    }

    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [self.selectedViewController viewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];    
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [self.selectedViewController viewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [self.selectedViewController viewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [self.selectedViewController viewDidDisappear:animated];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIViewController* vc in self.viewControllers) {
        [vc viewDidLoad];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    for (UIViewController* vc in self.viewControllers) {
        [vc viewDidUnload];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    for (UIViewController* vc in self.viewControllers) {
        [vc shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    for (UIViewController* vc in self.viewControllers) {
        [vc willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    for (UIViewController* vc in self.viewControllers) {
        [vc didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    for (UIViewController* vc in self.viewControllers) {
        [vc willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (UIViewController*)selectedViewController {
    return [self.viewControllers objectAtIndex:self.tabBar.selectedIndex];
}

#pragma mark - Private
- (CGRect)frameForViewControllers {
    CGFloat height = self.view.bounds.size.height;
    return CGRectMake(0, 0, self.view.bounds.size.width, height);
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(id)tabBar willSelectItemAtIndex:(NSUInteger)index currentIndex:(NSUInteger)currentIndex {
    UIViewController* willSelectViewController = (UIViewController*)[self.viewControllers objectAtIndex:index];
    CGRect frame = [self frameForViewControllers];
    if (!CGRectEqualToRect(frame, willSelectViewController.view.frame)) {
        willSelectViewController.view.frame = frame;
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [self.selectedViewController viewWillDisappear:NO];
        [willSelectViewController viewWillAppear:NO];
    }
}

- (void)tabBar:(id)tabBar didSelectItemAtIndex:(NSUInteger)index prviousIndex:(NSUInteger)prviousIndex {
    UIViewController* currentViewController = (UIViewController*)[self.viewControllers objectAtIndex:prviousIndex];
    [currentViewController.view removeFromSuperview];
    
    [self.view addSubview:self.selectedViewController.view];        
    [self.view bringSubviewToFront:self.tabBar];
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        [currentViewController viewDidDisappear:NO];
        [self.selectedViewController viewDidAppear:NO];
    }
}

@end
