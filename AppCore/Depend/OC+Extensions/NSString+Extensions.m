//
//  NSString+Extensions.m
//  TibetVoice
//
//  Created by TRS on 13-7-11.
//  Copyright (c) 2013年 TRS. All rights reserved.
//


#import "NSString+Extensions.h"

@implementation NSString (NSString_Extensions)

//utf-8数据转换为utf-8字符串
+ (NSString *)stringFromUTF8Data:(NSData *)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return str;
}

//gb2313数据转化为utf-8字符串
+ (NSString *)stringFromGB2312Data:(NSData *)data
{
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    return  str;
}

//格式化输出各种对象
+ (NSString *)stringFormatValue:(id)obj
{
    NSString *str = @"";
    if(obj == nil || [obj isKindOfClass:[NSNull class]]) {
    }
    else if([obj isKindOfClass:[NSNumber class]]) {
        str = [(NSNumber *)obj stringValue];
    }
    else if([obj isKindOfClass:[NSString class]] && [(NSString *)obj length] && ![obj isEqualToString:@"null"]) {
        str = obj;
    }
    return str;
}

//根据文件大小bytes转化带单位的大小字符串
+ (NSString *)stringFileSizeFromBytes:(long long)bytes
{
    if(bytes >= 1024.0*1024.0*1024.0)//大于1G，则转化成MG单位的字符串
    {
        return [NSString stringWithFormat:@"%.2fG",bytes/1024.0/1024.0/1024.0];
    }else if(bytes >= 1024.0*1024.0)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%.2fM",bytes/1024.0/1024.0];
    }
    else if(bytes >= 1024.0 && bytes < 1024.0*1024.0) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%.2fK",bytes/1024.0];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%.2fB",(float)bytes];
    }
}

//判断字符串长度, 支持中英文 特殊字符混编
+ (int)stringLength:(NSString  *)str
{
    int len = 0;
    char* p = (char*) [str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*p) {
            p++;
            len++;
        }
        else {
            p++;
        }
    }
    return len;
}

//手机号码字符过滤
+ (NSString *)mobilePhoneFilter:(NSString *)str
{
    if(str == nil || [str length] == 0)
        return nil;
    NSMutableString *phone = [NSMutableString stringWithCapacity:0];
    for(int i = 0; i < [str length]; i++)
    {
        char ch = [str characterAtIndex:i];
        if(ch >= '0' && ch <= '9')
        {
            [phone appendFormat:@"%c", ch];
        }
    }
    return phone;
}

//根据生日计算星座
+ (NSString *)getAstroWithMonth:(int)m day:(int)d
{
    static NSString *astro_d = @"魔羯座";
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        return astro_d;
    }
    
    if(m==2 && d>29) {
        return astro_d;
    }
    else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return astro_d;
        }
    }
    result = [NSString stringWithFormat:@"%@座",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
}



//年龄计算
+ (NSString *)ageValue:(NSString *)y month:(NSString *)m day:(NSString *)d
{
    NSArray *array = [[[NSString stringWithFormat:@"%@", [NSDate date]] substringToIndex:10] componentsSeparatedByString:@"-"];
    int _year = [[array objectAtIndex:0] intValue] - [[self stringFormatValue:y] intValue];
    int _month= [[array objectAtIndex:1] intValue] - [[self stringFormatValue:m] intValue];
    int _day  = [[array objectAtIndex:2] intValue] - [[self stringFormatValue:d] intValue];
    
    if(_month < 0) { //当前月份为出生月份之前
        --_year;
    }
    else if(_month == 0 && _day <0) { //同月，但当前日期在出生日期之前
        --_year;
    }
    return [NSString stringWithFormat:@"%d岁", _year];
}

//判断星期几
+ (NSString *)getWeekByWeek:(int)week
{
    NSString*weekStr=nil;
    if(week==1)
    {
        weekStr=@"星期天";
    }else if(week==2){
        weekStr=@"星期一";
        
    }else if(week==3){
        weekStr=@"星期二";
        
    }else if(week==4){
        weekStr=@"星期三";
        
    }else if(week==5){
        weekStr=@"星期四";
        
    }else if(week==6){
        weekStr=@"星期五";
        
    }else if(week==7){
        weekStr=@"星期六";
    }
    
    return weekStr;
}

//时间显示
+ (NSString *)timeValue:(NSTimeInterval)interval
{
	NSTimeInterval _interval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:interval] ];
	
	NSString *result = nil;
	int temp = 0;
	if(_interval <60) { //60秒以内
		result = @"刚刚";
	}
	else if((temp = _interval/60) <60) { //1小时以内
		result = [NSString stringWithFormat:@"%d分钟前", temp];
	}
	else if((temp = temp/60) <24 ) { //超过60分钟今天内的
		result = [NSString stringWithFormat:@"%d小时前", temp];
	}
    else if((temp = temp/24) <1){ //今天
		result = [NSString stringWithFormat:@"今天"];
	}
    else if((temp = temp/24) <2){ //昨天
		result = [NSString stringWithFormat:@"昨天"];
	}
    else if((temp = temp/24) <3){ //前天
		result = [NSString stringWithFormat:@"前天"];
	}
	else if((temp = temp/24) <7){ //一个月内的
		result = [NSString stringWithFormat:@"%d天前", temp];
	}
    else if((temp = temp/24) <30){ //一个月内的
		result = [NSString stringWithFormat:@"%d天前", temp];
	}
	else if((temp = temp/30) <12){ //等于或超过1个月（规定一个月为30天
		result = [NSString stringWithFormat:@"%d月前", temp];
	}
	else{ //比1年更久的时间
		/*
        temp = temp/12;
		result = [NSString stringWithFormat:@"%d年前", temp];
        */
       // result = [NSDate stringByStringFormat:@"yyyy-MM-dd HH:mm" data:[NSDate dateWithTimeIntervalSince1970:interval] ];
	}
	
    return result;
}


//根据播放时间长度格式化为小时分钟表示
+ (NSString *)videoPlayTimeValue:(double)time
{
    NSString *result = nil;
    int hour = 0, min = 0, sec = 0;
    if(time > 60*60) {
        hour = time / (60 * 60);
		time -= hour * (60 * 60);
	}
	if(time > 60) {
        min = time / 60;
		time -= min * 60;
	}
	sec = time;
	
    if(hour > 0)
        result = [NSString stringWithFormat:@"%0.2d:%0.2d:%0.2d", hour, min, sec];
    else
        result = [NSString stringWithFormat:@"%0.2d:%0.2d", min, sec];
    
    return result;
}


// 正则判断字符串是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 字符串转换为NSArray或NSDictionary
+ (id)JSONObjectWithString:(NSString *)str
{
    if(str == nil || str.length == 0) return nil;
    
    NSError *error = nil;
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
    if(error) {NSLog(@"__%s__, error : %@", __FUNCTION__, error.localizedDescription);}
    
    return JSON;
}


#pragma mark -

//根据dictionary获取相应字段的键值
#define kItemsURL       @[@"URL", @"url", @"link", @"docpuburl", @"imageurl"]
#define kItemsImage     @[@"pic", @"spic", @"image", @"images",@"icon"]
#define kItemsTitle     @[@"title", @"name", @"cname", @"urltitle", @"doctitle"]
#define kItemsContent   @[@"content", @"abstract", @"desc", @"docabstract", @"ir_abstract"]

+ (NSString *)valueForKey:(NSDictKey)key dict:(NSDictionary *)dict
{
    NSString *result = nil;
    NSArray *array = nil;
    switch (key) {
        case NSDictKeyURL:
            array = kItemsURL;
            break;
            
        case NSDictKeyImage:
            array = kItemsImage;
            break;
            
        case NSDictKeyTitle:
            array = kItemsTitle;
            break;

        case NSDictKeyContent:
            array = kItemsContent;
            break;
            
        default:
            break;
    }
    
    //遍历词典的各个键值，获取对应的数据
    for(NSString *key in array) {
        result = dict[key]; //查询到数据后，跳出循环返回结果.
        if(result) {break;}
    }
    
    return result;
}
+ (BOOL)isNumber:(NSString *)text{
    NSString * regex        = @"(/^[0-9]*$/)";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:text];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }

}
@end
