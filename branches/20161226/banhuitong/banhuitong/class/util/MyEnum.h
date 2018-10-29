//
//  MyEnum.h
//  banhuitong
//
//  Created by user on 15-12-30.
//  Copyright (c) 2015年 banhuitong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEnum : NSObject

typedef enum{
    /**
     * 未提交
     */
    UN_SUBMITTED = 0,
    /**
     * 待项目经理审批。
     */
    MGR_AUDITING = 1,
    /**
     * 待风控审批。
     */
    RISK_CTRL_MGR_AUDITING = 10,
    /**
     * 待评委会审批。
     */
    BUS_SEC_AUDITING = 20,
    /**
     * 待业务副总批准上线
     */
    BUS_VP_AUDITING = 30,
    /**
     * 募集中
     */
    RAISING = 40,
    /**
     * 募集满
     */
    RAISED_FULL = 50,
    /**
     * 业务副总已确认满标
     */
    BUS_VP_CONFIRMED_FULL = 60,
    /**
     * 财务已核收服务费
     */
    CHECKED_FEE = 70,
    /**
     * 业务副总已批准放款
     */
    BUS_VP_CONFIRMED_LOAN = 80,
    /**
     * 正在还款
     */
    REPAYING = 90,
    /**
     * 已逾期
     */
    TIME_OUT = 100,
    /**
     * 已展期
     */
    EXTENSION = 110,
    /**
     * 已结清
     */
    COMPLETED = 999,
    /**
     * 已流标
     */
    FAILED = -1
}EntStatusType;

typedef enum {
    RECHARGE = 1, WITHDRAW = 2, TENDER = 3, REPAY = 4,
    REWARD = 5, FEE = 6, INCOME = 7, OTHER = 99
    
} InComeDetailType;

typedef enum {
    IN = 1, OUT = 2
} JxInComeDetailType;


typedef enum  {
    INVEST_OF_ALL = 0xFFFF,
    INVEST_OF_FINANCING = 1,
    INVEST_OF_REPAYING = 2,
    INVEST_OF_REPAYOVER = 3,
    INVEST_OF_FAILED = 4
}InvestPrjStatus;

typedef enum  {
    /**
     * 无效
     */
    MY_BHB_INVALID = 0,
    
    /**
     * 待审核
     */
    MY_BHB_AUDITING = 1,
    
    /**
     * 募集期
     */
    MY_BHB_RAISING = 2,

    /**
     * 封闭期
     */
    MY_BHB_CLOSED = 3,
    
    /**
     * 已结束
     */
    MY_BHB_COMPLETED = 4
}BhbPhaseType;

typedef enum  {
    CA_PROCESSING = 0,
    CA_DONE = 1,
    CA_CANCEL = 2,
    CA_ABOLISH = -1,
    CA_AGAIN = 3,
    CA_APPLIABLE = 10
}CreditPrjStatusType;

@end
