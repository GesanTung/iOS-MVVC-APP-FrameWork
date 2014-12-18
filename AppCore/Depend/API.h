//
//  API.h
//  TRSMobile
//
//  Created by TRS on 14-3-12.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#ifndef TRSMobile_API_h
#define TRSMobile_API_h

/*
 *此文件为网络交互相关的定义说明文件
 *
 */

/*********************************************************************/

/*
 * 本地JSON文件数据
 *
 */

//程序主框架数据地址
#define URLLayoutTop        @"file://layout_root.json"

//左侧菜单栏目地址
#define URLLayoutSideBarL   @"file://layout_sideL.json"

//右侧菜单栏目地址
#define URLLayoutSideBarR   @"file://layout_sideR.json"



/*********************************************************************/

/*
 * 网络数据请求JSON文件地址
 *
 */
//活动详情
#define URLHTTPActivityDetail    @"http://trscom.vicp.cc/discuz/api.php?mod=activitydetail&tid="
//报名名单
#define URLHTTPActivityApply    @"http://trscom.vicp.cc/discuz/api.php?mod=activitymingd&tid="
//报名提交
#define URLHTTPActivitySubmit    @"http://trscom.vicp.cc/discuz/api.php?mod=activitybaom&tid="
/*********************************************************************/

/*
 * 论坛接口调用相关
 */

/*
 * 论坛登录域名
 */
#define URLHTTPBBSDomain    @"http://bbs.ycen.com.cn/"

/*
 * 论坛登录-管理员登录
 */
#define URLHTTPLoginAdmin   @"http://bbs.ycen.com.cn/api/mobile/index.php?module=login"


/*
 * 论坛登录-普通用户注册预加载
 */

#define URLHTTPPreRegister  @"http://bbs.ycen.com.cn/api.php?mod=user&action=preregister"


/*
 * 论坛登录-普通用户注册
 */
#define URLHTTPRegister(formhash, usernamecode, username, passwordcode, password, passwordcode2, password2, emailcode, email, verifycode, verify)     [NSString stringWithFormat:@"http://bbs.ycen.com.cn/member.php?mod=register&inajax=yes&ajaxdata=json&regsubmit=yes&formhash=%@&%@=%@&%@=%@&%@=%@&%@=%@&seccodehash=%@&seccodeverify=%@", formahash, usernamecode, username, passwordcode, password, passwordcode2, password2, emailcode, email, verifycode, verify]

/*
 * 论坛登录-普通用户登录
 */
#define URLHTTPLoginUser(username, password)  [NSString stringWithFormat:@"http://bbs.ycen.com.cn/api/mobile/index.php?module=login&loginsubmit=yes&username=%@&password=%@", username, password]

/*
 * 图片数据上传接口
 */
#define URLHTTPImageUpload(formhash)  [NSString stringWithFormat:@"http://bbs.ycen.com.cn/api/mobile/?module=forumupload&type=image&simple=1&formhash=%@", formhash]

/*上传图片和文字信息
 *意见反馈的版块id即Fid是49, 爆料的板块id即Fid是110, 拍客的板块id即Fid是111
 */
#define URLHTTPUpload(fid, formhash, subject) [NSString stringWithFormat: @"http://bbs.ycen.com.cn/api/mobile/?module=newthread&fid=%d&formhash=%@&topicsubmit=yes&subject=%@", fid, formhash, subject]

/*********************************************************************/

/*
 * 第三方数据接口
 *
 */



/*第三方公交查询接口---公交线路查询
 *参数 GetLinesInfoByLine()  city:城市， line:公交线路
 */
#define URLHTTPBusByLine(city, line)    [NSString stringWithFormat:@"http://webservice.36wu.com/mapService.asmx/GetLinesInfoByLine?city=%@&line=%@&UserId=257804F8B4D540D0BE207F62E8770277", city, line]

/*第三方公交查询接口---公交站点查询
 *参数 GetStationInfoByName()  city:城市， name:站点名
 */
#define URLHTTPBusByName(city, name)    [NSString stringWithFormat:@"http://webservice.36wu.com/mapService.asmx/GetStationInfoByName?city=%@&name=%@&UserId=257804F8B4D540D0BE207F62E8770277", city, name]

/*第三方公交查询接口---公交换乘查询
 *参数 GetTransferInfoByStation() city:城市， sstation:起点站， estation:终点点
 */
#define URLHTTPBusByStation(city, sstation, estation)    [NSString stringWithFormat:@"http://webservice.36wu.com/mapService.asmx/GetTransferInfoByStation?city=%@&startStation=%@&endStation=%@&UserId=257804F8B4D540D0BE207F62E8770277", city, sstation, estation]



/*第三方应用JuHe---站到站查询查询
 *参数 请求站到站查询接口 sstation : 出发站，estation: 终点站
 */
#define URLHTTPTrainS(sstation, estation) [NSString stringWithFormat:@"http://apis.juhe.cn/train/s2s?start=%@&end=%@&key=a07194a1b7d1168f8da992f3e9dffc6e", sstation, estation]

/*第三方应用JuHe---车次详情查询
 *参数 请求车次查询接口 traincode : 车次名称
 */
#define URLHTTPTrain(traincode) [NSString stringWithFormat:@"http://apis.juhe.cn/train/s?name=%@&key=a07194a1b7d1168f8da992f3e9dffc6e", traincode]

/*第三方应用JuHe---实时余票查询
 *参数 12306实时余票查询接口 sstation : 出发站，estation: 终点站 date : 出发日期
 */
#define URLHTTPTrainTicket(sstation, estation, date) [NSString stringWithFormat:@"http://apis.juhe.cn/train/yp?key=a07194a1b7d1168f8da992f3e9dffc6e&from=%@&to=%@&date=%@", sstation, estation, date]

/*第三方应用JuHe---车辆违章查询
 *参数 api: 1. 获取支持城市参数接口 citys 4. 车辆（号牌）种类编号查询 hpzl
 */
#define URLHTTPWZ(api)       [NSString stringWithFormat:@"http://v.juhe.cn/wz/%@?key=60ea1720911433ebe94bf460b23292e6", api]

/*第三方应用JuHe---车辆违章查询
 *参数 2.请求违章查询接口 city:城市代码，hphm:车牌号码，hpzl:车牌种类编号 engineno:发动机号 classno:车架号后6位 registno:车辆登记证书号(可选)
 */
#define URLHTTPWZQ(city, hphm, hpzl, engineno, classno)         [NSString stringWithFormat:@"http://v.juhe.cn/wz/query?city=%@&hphm=%@&hpzl=%@&engineno=%@&classno=%@&key=60ea1720911433ebe94bf460b23292e6", city, hphm, hpzl, engineno, classno]

/*第三方应用JuHe---航班查询
 *参数 请求航线查询接口 scity : 出发城市三字代码，ecity:到达城市三字代码， date:出发日期 2014-04-20
 */
#define URLHTTPFlightJuHe(scity, ecity, date)  [NSString stringWithFormat:@"http://apis.juhe.cn/plan/s2s?start=%@&end=%@&date=%@&key=81528557ab7c1f2ea6c7fee21c88bf8f", scity, ecity, date]

/*第三方应用JuHe---身份证信息查询
 *参数 请求身份证信息查询接口 cardno:身份证号码
 */
#define URLHTTPIDInfo(cardno) [NSString stringWithFormat:@"http://apis.juhe.cn/idcard/index?key=4f42e9fd3f105dee90e26504a3b5cded&cardno=%@",cardno]

/*第三方应用JuHe---身份证挂失查询
 *参数 请求身份证挂失查询接口 cardno:身份证号码
 */
#define URLHTTPIDLeak(cardno) [NSString stringWithFormat:@"http://apis.juhe.cn/idcard/leak?key=4f42e9fd3f105dee90e26504a3b5cded&cardno=%@",cardno]

/*第三方应用JuHe---身份证挂失查询
 *参数 请求身份证挂失查询接口 cardno:身份证号码
 */
#define URLHTTPIDLoss(cardno) [NSString stringWithFormat:@"http://apis.juhe.cn/idcard/loss?key=4f42e9fd3f105dee90e26504a3b5cded&cardno=%@",cardno]

/*第三方应用JuHe---手机号码归属地查询
 *参数 请求手机号码归属地查询接口 phone:手机号码
 */
#define URLHTTPPhone(phone) [NSString stringWithFormat:@"http://apis.juhe.cn/mobile/get?key=3cf7bbee8d5f079e1f2ce4811a1cd827&phone=%@",phone]

/*第三方应用JuHe---ip地址查询
 *参数 请求ip地址查询接口 ip:需要查询的IP地址或域名
 */
#define URLHTTPIP(ip) [NSString stringWithFormat:@"http://apis.juhe.cn/ip/ip2addr?key=df85baa16cc71f7a3c08142bd0c63acd&ip=%@",ip]

/*第三方应用JuHe---苹果序列号查询
 *参数 请求苹果序列号查询接口 ip:需要查询的IP地址或域名
 */
#define URLHTTPAppleSN(sn) [NSString stringWithFormat:@"http://apis.juhe.cn/appleinfo/index?sn=%@&key=be1f830157373b25cdfeb4ec82a6920c",sn]

/*第三方应用JuHe---移动联通基站查询
 *参数 请求电信基站查询接口 sid:SID; nid:NID; cellid:基站号(bid)
 */
#define URLHTTPCell(mnc, lac, cell) [NSString stringWithFormat:@"http://v.juhe.cn/cell/get?mnc=%d&cell=%@&lac=%@&key=506828b8794fa86fe0afc16fa6cc21c9", mnc, lac, cell]

/*第三方应用JuHe---电信基站查询
 *参数 请求电信基站查询接口 sid:SID; nid:NID; cellid:基站号(bid)
 */
#define URLHTTPCDMA(sid, nid, cellid) [NSString stringWithFormat:@"http://v.juhe.cn/cdma/?sid=%@&nid=%@&cellid=%@&key=a9d1708348e904352f42417ae67e2467", sid, nid, cellid]

/*第三方应用JuHe---天气信息查询
 *参数 请求根据城市名查询天气接口 cityname:城市名，如："苏州"
 */
#define URLHTTPWeatherJuHe(cityname) [NSString stringWithFormat:@"http://v.juhe.cn/weather/index?cityname=%@&key=30a8392dd96ea99f11a0c39c4a87194f",cityname]



/*第三方36wu---ISBN信息查询
 *参数 请求ISBN信息查询接口 isbn:10位或13位isbn编号
 */
#define URLHTTPISBN(isbn) [NSString stringWithFormat:@"http://api.36wu.com/ISBN/GetIsbnInfo?isbn=%@",isbn]


/*第三方36wu---快递/物流查询
 *参数 请求快递查询接口 postid:快递或物流单号
 */
#define URLHTTPPost(postid) [NSString stringWithFormat:@"http://api.36wu.com/Express/GetExpressInfo?postid=%@",postid]

/*********************************************************************/

#endif
