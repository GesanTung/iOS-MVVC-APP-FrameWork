//
//  CMTabBar.h
//
//  Created by Constantine Mureev on 13.03.12.
//  Copyright (c) 2012 Team Force LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGHeightTabbar  44.0

@protocol CMTabBarDelegate <NSObject>

@optional
- (void)tabBar:(id)tabBar willSelectItemAtIndex:(NSUInteger)index currentIndex:(NSUInteger)currentIndex;
- (void)tabBar:(id)tabBar didSelectItemAtIndex:(NSUInteger)index prviousIndex:(NSUInteger)prviousIndex;

@end


@interface CMTabBar : UIView

@property (nonatomic, assign) id<CMTabBarDelegate>  delegate;
@property (nonatomic, assign) NSUInteger            selectedIndex;

- (void)setItems:(NSArray*)tabBarItems animated:(BOOL)animated;

@end
