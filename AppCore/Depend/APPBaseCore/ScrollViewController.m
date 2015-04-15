//
//  ScrollViewController.m
//  AppCore
//
//  Created by Gesantung on 15-4-15.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "ScrollViewController.h"

#import "Globals.h"
@interface ScrollViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setDataByList:(NSArray*)list className:(NSString*)name delegate:(id<ScrollViewDelegate>)delegate{
//    self.scrollContentView.frame = self.view.frame;
    [self.scrollContentView setFrameH:100];
    self.scrollContentView.backgroundColor = [UIColor redColor];
    __block float offset = 0;
     [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         BaseScrollCellView *item = [UIView viewWithXibString:name];
         [self.scrollContentView addSubview:item];
         item.delegate = delegate;
         [item setDict:obj];
         [item initCellView];
         if (_isHorizontal) {
             item.frame = CGRectMake(offset,0 ,  CGRectGetWidth(item.frame), CGRectGetHeight(self.view.frame));
             offset+=  CGRectGetWidth(item.frame);
         }
         else{
             item.frame = CGRectMake(0, offset, CGRectGetWidth(self.view.frame), CGRectGetHeight(item.frame));
             offset+=  CGRectGetHeight(item.frame);

         }
     }];
    self.scrollContentView.contentSize = CGSizeMake( CGRectGetWidth(self.view.frame),offset );
    self.view.layer.masksToBounds = YES;
}

@end
