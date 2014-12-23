//
//  MJRefreshFooterView.m
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshFooterView.h"
#import "MJRefreshConst.h"

@interface MJRefreshFooterView()
{
    BOOL _withoutIdle;
}
@end

@implementation MJRefreshFooterView

+ (instancetype)footer
{
    return [[MJRefreshFooterView alloc] init];
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        // 移除刷新时间
		[_lastUpdateTimeLabel removeFromSuperview];
        _lastUpdateTimeLabel = nil;
        
        //由于设置判断有无更多引起的，需重设状态更改statusLabel显示的文字
        _hasMore = YES;
        [self setState:MJRefreshStateNormal];
        //增加结束
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat h = frame.size.height;
    if (_statusLabel.center.y != h * 0.5) {
        CGFloat w = frame.size.width;
        _statusLabel.center = CGPointMake(w * 0.5, h * 0.5);
    }
}

#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 1.移除以前的监听器
    [_scrollView removeObserver:self forKeyPath:MJRefreshContentSize context:nil];
    // 2.监听contentSize
    [scrollView addObserver:self forKeyPath:MJRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
    
    // 3.父类的方法
    [super setScrollView:scrollView];
    
    // 4.重新调整frame
    [self adjustFrame];
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //wujianjun 2014-03-17 增加有无更多判断标志
    if(!self.hasMore) { //当没有更多时，调整footer显示到底部，并且直接返回避免footer显示的文字提示为"上拉加载更多".
        [self adjustFrame];
        return;
    }

    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([MJRefreshContentSize isEqualToString:keyPath]) {
        [self adjustFrame];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrame
{
    // 内容的高度
    CGFloat contentHeight = _scrollView.contentSize.height;
    // 表格的高度
    CGFloat scrollHeight = _scrollView.frame.size.height - _scrollViewInitInset.top - _scrollViewInitInset.bottom;
    CGFloat y = MAX(contentHeight, scrollHeight);
    // 设置边框
    self.frame = CGRectMake(0, y, _scrollView.frame.size.width, MJRefreshViewHeight);
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(MJRefreshState)state
{
    //wujianjun 2014-03-17 增加有无更多判断标志
    //if (_state == state) return; /*屏蔽此语句，在需重设状态更改statusLabel显示的文字时若状态相同直接返回无法设置*/
    //屏蔽结束
    
    MJRefreshState oldState = _state;
    
    [super setState:state];
    
	switch (state)
    {
		case MJRefreshStatePulling:
        {
            _statusLabel.text = MJRefreshFooterReleaseToRefresh;
            
            [UIView animateWithDuration:MJRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = _scrollViewInitInset.bottom;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
		case MJRefreshStateNormal:
        {
            //wujianjun 2014-03-17 增加有无更多判断标志
            _statusLabel.text = _hasMore ? MJRefreshFooterPullToRefresh : MJRefreshFooterPullMoreNone;
            _arrowImage.hidden = !_hasMore;
            //修改结束
            
            // 刚刷新完毕
            CGFloat animDuration = MJRefreshAnimationDuration;
            CGFloat deltaH = [self contentBreakView];
            CGPoint tempOffset = CGPointZero;
            
            if (MJRefreshStateRefreshing == oldState && deltaH > 0 && !_withoutIdle) {
                tempOffset = _scrollView.contentOffset;
                animDuration = 0;
            }
            
            [UIView animateWithDuration:animDuration animations:^{
                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = _scrollViewInitInset.bottom;
                _scrollView.contentInset = inset;
            }];
            
            if (animDuration == 0) {
                _scrollView.contentOffset = tempOffset;
            }
			break;
        }
            
        case MJRefreshStateRefreshing:
        {
            _statusLabel.text = MJRefreshFooterRefreshing;
            _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            [UIView animateWithDuration:MJRefreshAnimationDuration animations:^{
                UIEdgeInsets inset = _scrollView.contentInset;
                CGFloat bottom = MJRefreshViewHeight + _scrollViewInitInset.bottom;
                CGFloat deltaH = [self contentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                inset.bottom = bottom;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
        default:
            break;
	}
}

- (void)endRefreshingWithoutIdle
{
    _withoutIdle = YES;
    [self endRefreshing];
    _withoutIdle = NO;
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)contentBreakView
{
    CGFloat h = _scrollView.frame.size.height - _scrollViewInitInset.bottom - _scrollViewInitInset.top;
    return _scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
// 合理的Y值(刚好看到上拉刷新控件时的contentOffset.y，取相反数)
- (CGFloat)validY
{
    CGFloat deltaH = [self contentBreakView];
    if (deltaH > 0) {
        return deltaH -_scrollViewInitInset.top;
    } else {
        return -_scrollViewInitInset.top;
    }
}

// view的类型
- (int)viewType
{
    return MJRefreshViewTypeFooter;
}

- (void)free
{
    [super free];
    [_scrollView removeObserver:self forKeyPath:MJRefreshContentSize];
}

@end