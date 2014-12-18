//
//  BaseViewController.m
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationBarView.h"
#import "Globals.h"
@interface BaseViewController ()
@property (nonatomic,strong) UINavigationBarView *navigationBarView;
@end

@implementation BaseViewController
@synthesize navigationBarView = _navigationBarView ;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUINavbar];
}

- (void)initUINavbar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UINavigationBarViewCallback callback = ^(UINavigationBarView *view, NSInteger index) {
        switch (index) {
            case 0:
                [self leftButtonTouch];
                break;
            case 1:
                [self rightButtonTouch];
                break;
            default:
                break;
        }
    };
    
    //顶部导航条
    _navigationBarView = [UIView viewWithXibString:@"UINavigationBarView"];
    [_navigationBarView setBackgroundColor:[UIColor colorWithRGB:UIColorBlueDark]];
    _navigationBarView.callback = callback;
    _navigationBarView.labelTitle.text = @"活动";
    [_navigationBarView.buttonLeft setImage:[UIImage imageNamed:@"icon_t_返回.png"] forState:UIControlStateNormal];
    [self.view addSubview:_navigationBarView];
}
- (void)setNavTitle:(NSString*)text{
    _navigationBarView.labelTitle.text = text;
}
- (void)setNavLeftBtn:(NSString*)content{
    if([content rangeOfString:@".png"].location == NSNotFound){
         [_navigationBarView.buttonLeft setTitle:content forState:UIControlStateNormal];
    }
    else{
        [_navigationBarView.buttonLeft setImage:[UIImage imageNamed:content] forState:UIControlStateNormal];
    }
}
- (void)setNavRightBtn:(NSString*)content{
    if([content rangeOfString:@".png"].location == NSNotFound){
        [_navigationBarView.buttonRight setTitle:content forState:UIControlStateNormal];
    }
    else{
        [_navigationBarView.buttonRight setImage:[UIImage imageNamed:content] forState:UIControlStateNormal];
    }
}
- (void)leftButtonTouch{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonTouch{
    
}



@end
