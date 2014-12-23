//
//  NSString+Extensions.h
//  TibetVoice
//
//  Created by TRS on 13-7-11.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
typedef enum {
    NSDictKeyURL = 0x00,    //URL
    NSDictKeyImage,         //图片
    NSDictKeyTitle,         //标题
    NSDictKeyContent        //描述内容
}NSDictKey;

@interface NSString (NSString_Extensions)

//utf-8数据转换为utf-8字符串
+ (NSString *)stringFromUTF8Data:(NSData *)data;

//gb2313数据转化为utf-8字符串
+ (NSString *)stringFromGB2312Data:(NSData *)data;

//格式化输出各种对象
+ (NSString *)stringFormatValue:(id)obj;

//根据文件大小bytes转化带单位的大小字符串
+ (NSString *)stringFileSizeFromBytes:(long long)bytes;

//计算中英文混排的字符串长度
+ (int)stringLength:(NSString  *)str;

//手机号码字符过滤
+ (NSString *)mobilePhoneFilter:(NSString *)str;

//根据生日计算星座
+ (NSString *)getAstroWithMonth:(int)m day:(int)d;

//年龄计算
+ (NSString *)ageValue:(NSString *)y month:(NSString *)m day:(NSString *)d;


//时间显示
+ (NSString *)timeValue:(NSTimeInterval)interval;

//根据播放时间长度格式化为小时分钟表示
+ (NSString *)videoPlayTimeValue:(double)time;

// 正则判断字符串是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 字符串转换为NSArray或NSDictionary
+ (id)JSONObjectWithString:(NSString *)str;

//根据dictionary获取相应字段的键值
+ (NSString *)valueForKey:(NSDictKey)key dict:(NSDictionary *)dict;

// 判断是否为纯数字
+ (BOOL)isNumber:(NSString *)text;

@end
