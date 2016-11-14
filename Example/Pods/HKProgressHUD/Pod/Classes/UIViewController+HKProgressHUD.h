//
//  UIViewController+HKProgressHUD.h
//  HKProgressHUD
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HKProgressHUD.h"

@interface UIViewController (HKProgressHUD)

/**
 *  获取绑定到当前 view 的 HKProgressHUD，如果没有则自动创建
 */
@property (strong, nonatomic, readonly) HKProgressHUD *hk_progressHUD;

#pragma mark - Show & Hide Progress
/** 显示 UIActivityIndicatorView 与文字信息，直到主动取消 */
- (void)hk_showActivityWithMessage:(NSString *)message;
/** 显示圆形进度条与文字信息，直到主动取消 */
- (void)hk_showProgress:(CGFloat)progress withMessage:(NSString *)message;
/** 隐藏 ProgressHUD */
- (void)hk_hideProgressHUD;

#pragma mark - Show Messages
/** 显示一段纯文字，直到主动取消 */
- (void)hk_showText:(NSString *)text;
/** 显示错误消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showErrorMessage:(NSString *)text;
/** 显示成功消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showSucceedMessage:(NSString *)text;
/** 显示提示消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showInfoMessage:(NSString *)text;
/** 显示警告消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showAlertMessage:(NSString *)text;
/** 显示自定义的 iocn 和消息内容，直到主动取消 */
- (void)hk_showImage:(UIImage *)image withMessage:(NSString *)message;


/** 显示一段纯文字，1秒后自动隐藏 */
- (void)hk_autoShowText:(NSString *)text;
/** 显示错误消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowErrorMessage:(NSString *)text;
/** 显示成功消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowSucceedMessage:(NSString *)text;
/** 显示提示消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowInfoMessage:(NSString *)text;
/** 显示警告消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowAlertMessage:(NSString *)text;
/** 显示自定义的 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowImage:(UIImage *)image withMessage:(NSString *)message;

@end
