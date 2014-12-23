//
//  UINavbarPickerView.m
//  TibetVoice
//
//  Created by TRS on 13-7-4.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import "UINavbarPickerView.h"
#import "Globals.h"

@interface UINavbarPickerView ()

//左箭头
@property (nonatomic, retain) IBOutlet UIImageView *iconLeft;

//右箭头
@property (nonatomic, retain) IBOutlet UIImageView *iconRight;

//内容当前页数
@property (nonatomic, assign) int cpage;

//内容总页数
@property (nonatomic, assign) int tpage;


@end

@implementation UINavbarPickerView 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    _itemWidth = 64.0;                  //所有按钮的默认宽度
    _scrollView.scrollsToTop = NO;      //禁用scrollview的回滚到顶部属性
    _imageViewIndicator.hidden = YES;   //默认隐藏指示图标条
    _imageViewIndicator.backgroundColor = [UIColor colorWithRGB:UIColorDarkRed alpha:1.0];
    
    _iconRight.image = [UIImage imageNamed:@"icon_a_箭头右.png"];
    _iconLeft.image = [UIImage imageWithCGImage:_iconRight.image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];
}

- (void) setNavBarPickerViewData:(NSArray *)array
{
    //有效性检查
    if(array == nil || array.count == 0) return;
    
    //清除原有子视图
    for(id obj in _scrollView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj performSelector:@selector(removeFromSuperview)];
        }
    }
    
    //加载子视图
    _titles = array;    
    int total = array.count;
    CGFloat x  = self.offset_x;
    CGFloat padding = 0.0; //按钮中间的默认间隔距离
    CGFloat w = _isWidthEqual ? ((self.frame.size.width - padding * (total + 1)) / total) : _itemWidth;
    for ( int i = 0; i < total; i++) {
        id obj = array[i];
        NSString *title = [obj isKindOfClass:[NSString class]] ? obj : [NSString valueForKey:NSDictKeyTitle dict:obj];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.backgroundColor = [UIColor clearColor];
        button.userInteractionEnabled = YES;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithRGB:UIColorGrayLight] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRGB:UIColorDarkRed] forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_isWidthEqual || w == _itemWidth) {//button宽度按title长度进行变化
            button.frame = CGRectMake(x, 0, w, self.frame.size.height);
            x += (w + padding);
        }else
        {
            int buttonWidth = [title sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(150, 28) lineBreakMode:NSLineBreakByCharWrapping].width;
            button.frame = CGRectMake(x, 0, buttonWidth + padding, self.frame.size.height);
            x += buttonWidth + padding;
        }
        [_scrollView addSubview:button];
    }
    _iconRight.hidden = !_isArrow;
    _imageViewIndicator.hidden = NO; //开启指示图标条的显示
    _scrollView.contentSize = CGSizeMake(fmaxf(x + 2*padding, _scrollView.frame.size.width), _scrollView.frame.size.height);
    
    //计算页数
    if(_isArrow) {
        CGFloat pageWidth = _scrollView.frame.size.width;
        _tpage = floor((_scrollView.contentSize.width - pageWidth / 2) / pageWidth) + 1;
        _iconRight.hidden = !(_tpage > 1);
    }
    
    self.isSyncScroll = YES;
    [self scrollToItemAtIndex:_index];
}

- (void)scrollToItemAtIndex:(int)index
{
	_index = index;
	
    UIButton *selectView = nil;
    for (UIView *view in _scrollView.subviews) {
        if([view isKindOfClass:[UIButton class] ]) {
            [(UIButton *)view setSelected:NO];
            [((UIButton *)view).titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
            if(view.tag == index) {
                selectView = (UIButton *)view;
            }
        }
    }
    [selectView setSelected:YES];
    [selectView.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect frame = _imageViewIndicator.frame;
                         frame.origin.x = selectView.frame.origin.x;
                         frame.size.width = selectView.frame.size.width;
                         [_imageViewIndicator setFrame:frame];
                     }
                     completion:^(BOOL finish){
                         if(_scrollView.contentSize.width > _scrollView.frame.size.width) {
                             CGFloat desiredX = selectView.center.x - (_scrollView.bounds.size.width/2);
                             if(desiredX < 0.0) desiredX = 0.0;
                             if (desiredX > _scrollView.contentSize.width - _scrollView.bounds.size.width) {
                                 desiredX = _scrollView.contentSize.width - _scrollView.bounds.size.width;
                             }
                             if (!(_scrollView.bounds.size.width > _scrollView.contentSize.width)) {
                                 [_scrollView setContentOffset:CGPointMake(desiredX, 0) animated:YES];
                             }
                         }
                     }
     ];
}

- (void)syncPickerDidScroll:(CGFloat)offset
{
    CGRect frame = _imageViewIndicator.frame;
    frame.origin.x = offset;
    [_imageViewIndicator setFrame:frame];
}

- (void)selectPickerAtIndex:(int)index
{
    if(self.index == index) {return;}
    
	[self scrollToItemAtIndex:index];
    if (self.callback) {
        self.isSyncScroll = NO;
        self.callback(self,index);
        self.isSyncScroll = YES;
    }
}

- (void)didButtonSelected:(UIButton *)sender
{
    [self selectPickerAtIndex:sender.tag];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_isArrow && _tpage > 1) { //计算滚动到的当前页数
        CGFloat pageWidth = _scrollView.frame.size.width;
        _cpage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        if(_cpage == 0) {
            _iconLeft.hidden = YES;
            _iconRight.hidden = NO;
        }
        else if(_cpage > 0 && _cpage < _tpage - 1) {
            _iconLeft.hidden = _iconRight.hidden = NO;;
        }
        else {
            _iconLeft.hidden = NO;
            _iconRight.hidden = YES;
        }
    }
}

@end
