//
//  ListViewController.m
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "ListViewController.h"
#import "Globals.h"
@interface ListViewController ()<UIScrollViewDelegate>
//顶部二级导航菜单
@property (nonatomic, strong) UINavbarPickerView    *picker;

//中间区域列表容器
@property (nonatomic, strong) UIScrollView  *scrollView;

//中间区域列表视图控制器数组，用于控制某个视图控制器逻辑处理
@property (nonatomic, strong) NSMutableArray    *viewControllers;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUINavPicker
{
    if(_hasPicker) {
        UINavbarPickerViewCallback callback = ^(UINavbarPickerView *picker , int index) {
            [self pickerCallback:picker index:index];
        };
        _picker = [[[NSBundle mainBundle] loadNibNamed:@"UINavbarPickerView" owner:nil options:nil] lastObject];
        _picker.frame = CGRectMake(0, self.offset_y, kScreenWidth, kScreenHeight);
        _picker.callback = callback;
        [self.view addSubview:_picker];
        
        self.offset_y += _picker.frame.size.height;
    }
}
- (void)initUIScrollView
{
    //计算底部所占的工具条高度
    
    CGRect frame = CGRectMake(0, self.offset_y, kScreenWidth, kScreenHeight-self.offset_y);
    _viewControllers = [[NSMutableArray alloc] initWithCapacity:0];
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}

- (void)addUIListContentView:(id)JSON
{
    //兼容性检查
    if(JSON == nil || [JSON count] == 0) return;
    
    //清除原有子视图
    [_viewControllers removeAllObjects];
    for(id obj in _scrollView.subviews) {[obj performSelector:@selector(removeFromSuperview)];}
    
    //加载子视图
    NSUInteger total = [JSON count];
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = _scrollView.frame.size.height;
    
    //瀑布流标识，用于判断该视图是显示图片瀑布流还是一般的资讯列表

    for(int i = 0; i < total; i++) {
        //设置子视图的显示位置
        CGRect frame = CGRectMake(w * i, 0, w, h);
        int type = [[JSON[i] valueForKey:@"type"] intValue];
        switch (type) {
            case 1://列表
            {

            }
            break;
            default:
            {

            }
            break;
        }
    }
    _scrollView.scrollEnabled = (total > 1);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * total, _scrollView.frame.size.height);
    
    //滚动视图到对应显示
    [_scrollView setContentOffset:CGPointMake(_picker.index * _scrollView.frame.size.width, 0) animated:NO];
    
    //设置状态栏可回滚到顶部.刷新数据
    [self setViewScrollEnabled:_picker.index];
}

//设置列表中间区域内容布局
- (void)setUIListContentLayout
{
//    if(_hasPicker){
//        [self HTTPRequest:[NSString valueForKey:NSDictKeyURL dict:_dictPara] level:HTTPLevelChannel];
//    }else{
//        if(_dictPara)
//            [self addUIListContentView:@[_dictPara] ];
//    }
}

#pragma mark - UINavbarPickerCallback
- (void)pickerCallback:(UINavbarPickerView *)picker index:(int)index
{
    //滚动视图到对应显示
    [_scrollView setContentOffset:CGPointMake(index * _scrollView.frame.size.width, 0) animated:NO];
    
    //设置状态栏可回滚到顶部.刷新数据
    [self setUIReallyScrollView:index];
}

//设置状态栏可回滚到顶部
- (void)setViewScrollEnabled:(int)index
{
    //禁止scrollToTop属性，避免不能点击状态栏快速回滚到列表或瀑布流顶部
    for(int i = 0 ; i < _viewControllers.count; i++) {
        UIView *view = ((UIViewController *)_viewControllers[i]).view;
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).scrollsToTop = (i == index);
        }
    }
}

//设置状态栏可回滚到顶部.刷新数据
- (void)setUIReallyScrollView:(int)index
{
    //禁止scrollToTop属性，避免不能点击状态栏快速回滚到列表或瀑布流顶部
    [self setViewScrollEnabled:index];
    
    //刷新重新请求最新数据
    id obj = [_viewControllers objectAtIndex:index];
    if([obj respondsToSelector:@selector(beginRefreshing)]) {
        //[obj performSelector:@selector(beginRefreshing) withObject:nil afterDelay:0.3f];
    }
}

//手动代码控制选择顶部导航条的某个子栏目
- (void)selectLayoutPickerAtIndex:(int)index
{
    if(index < 0 || index >= _viewControllers.count) return;
    
    if(_picker) {[_picker selectPickerAtIndex:index];}
}
@end
