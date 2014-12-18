//
//  CMTabBar.m
//
//  Created by Constantine Mureev on 13.03.12.
//  Copyright (c) 2012 Team Force LLC. All rights reserved.
//

#import "CMTabBar.h"
#import "UIControl+Blocks.h"
#import "Globals.h"
#import "TabImageButton.h"
@interface CMTabBar()

//修正程序在第一次启动时，在IOS6.0版本上显示顶部有20px黑色区域未显示问题。
@property (nonatomic, assign) BOOL          firstAppear;
@property (nonatomic, assign) BOOL          useGlossEffect;
@property (nonatomic, retain) NSArray*      buttons;
@property (nonatomic, retain) UIImageView*  backgroundImageView;
@property (nonatomic, retain) UIImageView*  selectedImageView;

@end


@implementation CMTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTabBar];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initTabBar];
}

- (void)initTabBar
{
    self.backgroundColor = [UIColor colorWithRGB:UIColorWhite alpha:1.0];
    self.firstAppear = YES; //修正程序在第一次启动时，在IOS6.0版本上显示顶部有20px黑色区域未显示问题。
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[self defaultBackgroundImage]];
    self.backgroundImageView.contentMode = UIViewContentModeBottom;
    self.backgroundImageView.center = CGPointMake(self.center.x, self.frame.size.height/2);
    self.backgroundImageView.backgroundColor = [UIColor clearColor];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:self.backgroundImageView];
    
    self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    self.selectedImageView.image = [self defaultSelectionIndicatorImage];
    self.selectedImageView.backgroundColor = [UIColor clearColor];
    self.selectedImageView.contentMode = UIViewContentModeBottom;
    self.selectedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:self.selectedImageView];
    
    UIView *topLine=[UIView new];
    topLine.frame=CGRectMake(0, 0, kScreenWidth, 0.2);
    topLine.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:topLine];
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    //修正程序在第一次启动时，在IOS6.0版本上显示顶部有20px黑色区域未显示问题。
    if (self.firstAppear || (_selectedIndex != selectedIndex && selectedIndex < [self.buttons count]) ) {
        [self willChangeValueForKey:@"selectedIndex"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:willSelectItemAtIndex:currentIndex:)]) {
            [self.delegate tabBar:self willSelectItemAtIndex:selectedIndex currentIndex:_selectedIndex];
        }
        [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton* pButton = (UIButton*)obj;
            [pButton setSelected:NO];
        }];
        // check only for first selection
        if (_selectedIndex < [self.buttons count]) {
            UIButton* oldButton = [self.buttons objectAtIndex:_selectedIndex];
            [oldButton setImage:[oldButton imageForState:UIControlStateDisabled] forState:UIControlStateNormal];
        }
        
        UIButton* newButton = [self.buttons objectAtIndex:selectedIndex];
       // [newButton setImage:[newButton imageForState:UIControlStateSelected] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.25 //吴建军2014-02-25 修改动画效果和时间
                         animations:^{
                             self.selectedImageView.center = CGPointMake(newButton.center.x, self.selectedImageView.center.y);
                             [[self.buttons objectAtIndex:_selectedIndex] setSelected:NO];
                             [[self.buttons objectAtIndex:selectedIndex] setSelected:YES];
                         }
                         completion:^(BOOL finished) {
                             NSUInteger prviousIndex = _selectedIndex;
                             _selectedIndex = selectedIndex;
                             
                             [self didChangeValueForKey:@"selectedIndex"];
                             if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:prviousIndex:)]) {
                                 [self.delegate tabBar:self didSelectItemAtIndex:_selectedIndex prviousIndex:prviousIndex];
                             }
                         }];
        
        //修正程序在第一次启动时，在IOS6.0版本上显示顶部有20px黑色区域未显示问题。
        self.firstAppear = NO;
    }
}

- (void)setItems:(NSArray*)tabBarItems animated:(BOOL)animated {
    
    // Add KVO for each UITabBarItem
    for (UIButton* button in self.buttons) {
        [button removeActionCompletionBlocksForControlEvents:UIControlEventTouchUpInside];
        [button removeFromSuperview];
    }
    
    NSMutableArray* newButtons = [NSMutableArray array];
    NSUInteger offset = 0;
    if (!IOSIsPad && self.frame.size.width >= 768) {
        offset = self.frame.size.width / 4;
    }
    
    int total = tabBarItems.count;
    CGSize buttonSize = CGSizeMake((self.frame.size.width - offset * 2) / total, self.frame.size.height);
    for (int i=0; i < total; i++) {
        NSDictionary *dict = tabBarItems[i];
        UIButton* lButton;
        NSString *icon = dict[@"icon"];
        if(icon.length){
            TabImageButton* button = [[TabImageButton alloc] initWithFrame:CGRectMake(i * buttonSize.width + offset, 0, buttonSize.width, buttonSize.height)];
            button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            
            button.titleLabel.font = [UIFont systemFontOfSize:10.0];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [button setTitle:dict[@"title"] forState:UIControlStateNormal];
            [self addSubview:button];
            [button setImage:[UIImage imageNamed:dict[@"icon"]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s_%@",dict[@"icon"]]] forState:UIControlStateSelected];
            lButton=button;
        }
        else{
            UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonSize.width + offset, 0, buttonSize.width, buttonSize.height)];
            button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            
            button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [button setTitle:dict[@"title"] forState:UIControlStateNormal];
            [self addSubview:button];
            lButton=button;
        }

        [lButton addActionCompletionBlock:^(id sender) {
            self.selectedIndex = i;
        } forControlEvents:UIControlEventTouchUpInside];
        
        if (i == self.selectedIndex) {
            [lButton setSelected:YES];
           // [button setImage:[button imageForState:UIControlStateSelected] forState:UIControlStateNormal];
            self.selectedImageView.center = CGPointMake(lButton.center.x, self.selectedImageView.center.y);
        }
        [newButtons addObject:lButton];
    }
    
    self.buttons = newButtons;
    
    //调整选中指示条
    CGRect frame = self.selectedImageView.frame;
    frame.origin.x = 0.0f;
    frame.size.width = buttonSize.width;
    self.selectedImageView.frame = frame;
}

- (UIImage*)defaultBackgroundImage
{
    return nil;
}

- (UIImage*)defaultSelectionIndicatorImage
{
    return nil;
}

@end
