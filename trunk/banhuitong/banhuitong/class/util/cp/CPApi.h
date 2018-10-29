//
//  CPApi.h
//  CPAuthTest
//
//  Created by mac0001 on 2/20/14.
//  Copyright (c) 2014 Bob Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @brief 该类为CP插件SDK所有请求类的基类
 *
 */
@interface CPBaseReq : NSObject
/** 证件类型*/
@property (nonatomic, retain) NSString *cerType;
/** 证件号码*/
@property (nonatomic, retain) NSString *cerNo;
/** 证件姓名*/
@property (nonatomic, retain) NSString *cerName;
/** 银行卡号*/
@property (nonatomic, retain) NSString *cardNo;
/** 卡号预留手机*/
@property (nonatomic, retain) NSString *cardMobile;
/** 用户自定义数据*/
@property (nonatomic, retain) NSDictionary *userInfo;
@end

/*! @brief 认证业务功能发送消息至银联后台的接口
 *
 */
@interface CPAuthReq : CPBaseReq
/** 系统编号
 * @note 此编号为银联电子统一分配
 */
@property (nonatomic, retain) NSString *appSysId;
/** 签名
 * @note 用商户私钥对相关要素作签名
 */
@property (nonatomic, retain) NSString *sign;
@end

/*! @brief 该类为CP插件SDK所有响应类的基类
 *
 */
@interface CPBaseResp : NSObject
/** 响应码*/
@property (nonatomic, assign) NSString *respCode;
/** 响应提示字符串*/
@property (nonatomic, retain) NSString *respMsg;
@end

/*! @brief 认证业务功能响应的接口
 *
 *
 */
@interface CPAuthResp : CPBaseResp
/** 证件类型*/
@property (nonatomic, retain) NSString *cerType;
/** 证件号码*/
@property (nonatomic, retain) NSString *cerNo;
/** 证件姓名*/
@property (nonatomic, retain) NSString *cerName;
/** 银行卡号*/
@property (nonatomic, retain) NSString *cardNo;
/** 卡号预留手机*/
@property (nonatomic, retain) NSString *cardMobile;
@end

/*! @brief 接收并处理来自CP插件的事件消息
 *
 */
@protocol CPApiDelegate <NSObject>
@required
/*! @brief 收到CP插件的回应
 *
 * 当完成相关业务后，可收到的回应
 * @param resp具体的回应内容，是自动释放的
 */
- (void)onResp:(CPBaseResp *)resp;
@end

/*! @brief CP插件Api接口函数类
 *
 */
@interface CPApi : NSObject

/*! @brief CPApi的成员函数，调起CP插件
 *
 * @attention 请保证在主线程中调用此函数
 * @param VC 视图控制器，该对象必须添加并实现CPApiDelegate
 * @param req 请求参数
 *
 */
+ (void)openAuthPluginAtViewController:(id)VC
                           withReq:(CPBaseReq *)req;
@end
