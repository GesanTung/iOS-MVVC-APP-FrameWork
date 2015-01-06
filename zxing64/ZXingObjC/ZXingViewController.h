//
//  ZXingViewController.h
//  TRSMobile
//
//  Created by zhouting on 14/12/8.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingObjC/ZXingObjC.h>
//#import "ZXingObjC.h"
#define ZXingBundleWavPath  [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ZXing.bundle/zxing_found.wav"]

@class ZXingViewController;
@protocol ZXingViewControllerDelegate <NSObject>
@optional

- (void)zXingViewController:(ZXingViewController *)controller didScanResult:(ZXResult *)result;

- (void)zXingViewControllerDidCancel:(ZXingViewController *)controller;

@end

@interface ZXingViewController : UIViewController<ZXCaptureDelegate>

@property (nonatomic, assign) id<ZXingViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL isScanning;

@end
