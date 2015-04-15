//
//  UINavigationBarView.h
//  TibetVoice
//
//  Created by TRS on 13-7-2.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGHeightUINavigatinBarView      44.0

//回调函数
@class UINavigationBarView;
typedef void (^UINavigationBarViewCallback)(UINavigationBarView *view, NSInteger index);

@interface UINavigationBarView : UIView

//回调
@property (nonatomic, copy) UINavigationBarViewCallback callback;

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;

//左侧按钮
@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;

//右侧按钮
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;

//标题标签
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@end