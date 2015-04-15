//
//  AppLayoutCenter.m
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "AppLayoutCenter.h"
#import "KKNavigationController.h"
@interface NSDictionary (TKThemed)

- (id)TKObjectForKey:(id)aKey;
- (id)TKValueForKeyPath:(NSString *)keyPath;

@end

@implementation NSDictionary (TKThemed)

- (id)TKObjectForKey:(id)aKey {

    return [self objectForKey:aKey];
}

- (id)TKValueForKeyPath:(NSString *)keyPath {

    return [self valueForKeyPath:keyPath];
}
@end

@implementation AppLayoutCenter
SYNTHESIZE_SINGLETON_FOR_CLASS(AppLayoutCenter)

@synthesize appConfig = _appConfig;

- (id)themedValueForPath:(NSString *)themePath
{
    return [self.appConfig TKValueForKeyPath:themePath];
}
- (id)getTabBarList
{
    return [self.appConfig TKValueForKeyPath:@"tabbar.tabbaritem"];
}
- (void)loadFromBundleWithFileName:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    self.appConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
}

- (UIViewController *)controllerWithDictionary:(NSDictionary *)propertyDict {
    if (!propertyDict) return nil;
    NSAssert([propertyDict isKindOfClass:[NSDictionary class]], @"Expected a dictionary where a %@ was found", NSStringFromClass([propertyDict class]));
    
    UIViewController *controller = nil;
    
    NSString *controllerName = [propertyDict TKObjectForKey:@"classname"];
    NSAssert([controllerName isKindOfClass:[NSString class]], @"The controller name should be a string");
    
    //Instantiate
    NSString *nibName = [propertyDict TKObjectForKey:@"nibName"];
    NSBundle *nibBundle = [NSBundle bundleWithPath:[propertyDict TKObjectForKey:@"nibBundle"]];
    if (nibName) {
        controller = [[NSClassFromString(controllerName) alloc] initWithNibName:nibName bundle:nibBundle];
    }
    else {
        controller = [[NSClassFromString(controllerName) alloc] init];
    }
    
    NSAssert(controller != nil, @"The controller named %@ can not be created", controllerName);
    NSAssert([controller isKindOfClass:[UIViewController class]], @"The controller %@ should be kind of UIViewController", controllerName);
    
    //Properties
    NSString *title = [propertyDict TKObjectForKey:@"title"];
    if (title) {
        controller.title = NSLocalizedString(title, nil);
    }
    
    //Subcontrollers
    NSArray *subControllers = [propertyDict TKObjectForKey:@"subControllers"];
    if (([controller respondsToSelector:@selector(setViewControllers:)]) && subControllers) {
        NSAssert([subControllers isKindOfClass:[NSArray class]], @"Subcontrollers should be an array");
        
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:subControllers.count];
        for (NSDictionary *subController in subControllers) {
            UIViewController *vc = [self controllerWithDictionary:subController];
            if (vc) {
                [vcs addObject:vc];
            }
        }
        [controller performSelector:@selector(setViewControllers:) withObject:vcs];
    }
    
    //Navigation bar
    BOOL inNavigationController = [[propertyDict TKObjectForKey:@"isNavigationController"] boolValue];
    if (inNavigationController) {
        KKNavigationController *nc = [[KKNavigationController alloc] initWithRootViewController:controller];
        int barStyle = [[propertyDict TKObjectForKey:@"navBarStyle"] intValue];
        nc.navigationBar.barStyle = barStyle;
        controller = nc;
    }
    
    return controller;
}


@end
