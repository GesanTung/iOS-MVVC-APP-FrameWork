//
//  Defines.h
//  TRSMobile
//
//  Created by TRS on 14-3-12.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#ifndef TRSMobile_Defines_h
#define TRSMobile_Defines_h

/*
 *此文件为程序常调用使用的宏字段声明文件，与具体应用无关
 *
 */

/*********************************************************************/
/*
 *调试日志
 */

//日志调试开关
#define __APPSTORE___         0
#if	__APPSTORE___
#define NSLog(format, ...)
#else
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#endif

/*********************************************************************/
/*
 *常量定义
 */
#pragma mark -

//程序托管方法
#define GAppDelegate            (AppDelegate *)([UIApplication sharedApplication].delegate)

//系统支持URL操作宏定义
#define AppOpenURL(format, ...) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:format]]

//应用程序版本号
#define IOSAppVersion           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//应用程序执行包
#define IOSAppExecuteName       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"]

//应用程序名称
#define IOSAppProductName       [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"]

//判断模拟器
#define IOSIsSimulator          (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

//手机设备版本号
#define IOSDeviceVersion        [[UIDevice currentDevice].systemVersion floatValue]

//判断设备iPhone或iPad
#define IOSIsPad                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//是否iPhone5
#define IOSIsIPHONE5            ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//网络状态可用性
#define IsNetworkAvailable      ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable)

//下载路径
#define DownloadPath           [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"Download"]

//录音存放路径
#define RecordedAudiosPath      [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"Audios"]

//网络请求JSON前缀，如index.json
#define JSONExtensionPrefix     @"index"

/*********************************************************************/

//登录状态更改通知
#define NSNotificationDidUserStatusChanged  @"didUserStatusChanged"

//角度->弧度
#define DEGREES_TO_RADIANS(angle)	((angle) * M_PI/ 180.0)

//弧度->角度
#define RADIANS_TO_DEGREES(radians)	((radians) *180.0/ M_PI)

//屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


#pragma mark -
/*********************************************************************/

/*
 *第三方组件SDK使用申请的AppID定义
 */

//科大讯飞语音识别
#define IFlyMSCAppID                    @"5202f8aa"

//友盟数据统计分析
#define UMengMobClickAppID              @"5348978b56240b1775038a2c"

//聚合条码数据appkey
#define JuheBarcodeAppID                @"cdf2309ab68cdbd9a2b9f38d554d59b1"

//百度开放云端服务(Frontia)
#define BaiduFrontiaAppID               @"i6ZFkMzyDZ2Cj05lHD96rmSl"

//百度地图服务(LBS开放平台)
#define BaiduLBSServiceAK               @"ihjcRlSY74ypIYmhP0unxoqs"

//百度分享社会化组件授权APPID-新浪微博
#define BaiduShareAppIdSina             @"3482037709"

//百度分享社会化组件授权APPID-QQ
#define BaiduShareAppIdQQ               @"801492289"

//百度分享社会化组件授权APPID-微信
#define BaiduShareAppIdWeiXin           @"wx15bcbbedee4e18e1"

//百度分享社会化组件分享支持平台
#define BaiduSharePlatforms             @[FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_QQWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_RENREN,FRONTIA_SOCIAL_SHARE_PLATFORM_KAIXIN, FRONTIA_SOCIAL_SHARE_PLATFORM_QQFRIEND,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,FRONTIA_SOCIAL_SHARE_PLATFORM_SMS,FRONTIA_SOCIAL_SHARE_PLATFORM_EMAIL]

/*********************************************************************/

/*
 *应用相关
 */

//应用市场地址
#define IOSiTunesURL                    @"http://itunes.apple.com/lookup?id=722073137"

//应用打分地址
#define IOSiTunesReviewsURL             @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=722073137"

#endif
