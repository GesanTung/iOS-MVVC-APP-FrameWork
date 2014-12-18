//
//  AppLayoutCenter.h
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ARCSingletonTemplate.h"

@interface AppLayoutCenter : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(AppLayoutCenter)

@property (nonatomic, retain) NSDictionary *appConfig;

- (void)loadFromBundleWithFileName:(NSString *)fileName;

- (id)themedValueForPath:(NSString *)themePath;

- (id)getTabBarList;
// Layout
- (UIViewController *)controllerWithDictionary:(NSDictionary *)propertyDict;
@end
