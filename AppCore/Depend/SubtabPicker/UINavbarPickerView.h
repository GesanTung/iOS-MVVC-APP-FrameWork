//
//  UINavbarPickerView.h
//  TibetVoice
//
//  Created by TRS on 13-7-4.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGHeightUINavbarPickerView      40.0

@class UINavbarPickerView;
typedef void (^UINavbarPickerViewCallback)(UINavbarPickerView *view, int index);

@interface UINavbarPickerView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBG;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIndicator;

@property (nonatomic, copy) UINavbarPickerViewCallback callback;    //回调函数
@property (nonatomic, retain) NSArray  *titles;         //传入参数
@property (nonatomic, readwrite) int   index;           //选中索引值
@property (nonatomic, assign) float    offset_x;        //第一个按钮的x坐标偏移量
@property (nonatomic, assign) float    itemWidth;       //所有button平均的宽度
@property (nonatomic, assign) BOOL     isWidthEqual;    //所有button的宽度是否相同 yes: self的宽度/count no:button文字的实际宽度
@property (nonatomic, assign) BOOL     isSyncScroll;    //yes.标志指示条同步滚动
@property (nonatomic, assign) BOOL     isArrow;         //箭头提示

//设置菜单数据
- (void)setNavBarPickerViewData:(NSArray *)array;

//设置菜单选中某个索引值
- (void)selectPickerAtIndex:(int)index;

//同步滚动菜单选中到某个索引值
- (void)scrollToItemAtIndex:(int)index;

//同步滚动选择器和指示条
- (void)syncPickerDidScroll:(CGFloat)offset;

@end
