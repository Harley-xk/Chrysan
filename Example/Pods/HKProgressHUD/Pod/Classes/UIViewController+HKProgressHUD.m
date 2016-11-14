//
//  UIViewController+HKProgressHUD.m
//  HKProgressHUD
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <objc/runtime.h>

#import "HKProgressHUD.h"
#import "UIViewController+HKProgressHUD.h"

@implementation UIViewController (HKProgressHUD)

- (HKProgressHUD *)hk_progressHUD
{
    HKProgressHUD *hud = objc_getAssociatedObject(self, @selector(hk_progressHUD));
    if (hud == nil) {
        hud = [self hk_setupProgressHUD];
    }
    return hud;
}

- (void)setHk_progressHUD:(HKProgressHUD *)hk_progressHUD
{
    objc_setAssociatedObject(self, @selector(hk_progressHUD), hk_progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HKProgressHUD *)hk_setupProgressHUD
{
    UIView *rootView = self.view;
    if ([self.view isKindOfClass:[UIScrollView class]] && self.view.superview != nil) {
        rootView = self.view.superview;
    }
    
    HKProgressHUD *hud = [HKProgressHUD setupWithView:rootView];
    self.hk_progressHUD = hud;
    self.hk_progressHUD.offsetY = -64;
    return hud;
}

#pragma mark - Show & Hide Progress
/** 显示 UIActivityIndicatorView 与文字信息，直到主动取消 */
- (void)hk_showActivityWithMessage:(NSString *)message
{
    [self.hk_progressHUD showActivityWithMessage:message];
}
/** 显示圆形进度条与文字信息，直到主动取消 */
- (void)hk_showProgress:(CGFloat)progress withMessage:(NSString *)message
{
    [self.hk_progressHUD showProgress:progress withMessage:message];
}

/** 隐藏 ProgressHUD */
- (void)hk_hideProgressHUD
{
    [self.hk_progressHUD hide];
}

#pragma mark - Show Messages
/** 显示一段纯文字，直到主动取消 */
- (void)hk_showText:(NSString *)text
{
    [self.hk_progressHUD showText:text];
}

/** 显示错误消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showErrorMessage:(NSString *)text
{
    [self.hk_progressHUD showErrorMessage:text];
}

/** 显示成功消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showSucceedMessage:(NSString *)text
{
    [self.hk_progressHUD showSucceedMessage:text];
}

/** 显示提示消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showInfoMessage:(NSString *)text
{
    [self.hk_progressHUD showInfoMessage:text];
}

/** 显示警告消息 iocn 和消息内容，直到主动取消 */
- (void)hk_showAlertMessage:(NSString *)text
{
    [self.hk_progressHUD showAlertMessage:text];
}

/** 显示自定义的 iocn 和消息内容，直到主动取消 */
- (void)hk_showImage:(UIImage *)image withMessage:(NSString *)message
{
    [self.hk_progressHUD showImage:image withMessage:message];
}

/** 显示一段纯文字，1秒后自动隐藏 */
- (void)hk_autoShowText:(NSString *)text
{
    [self.hk_progressHUD autoShowText:text];
}

/** 显示错误消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowErrorMessage:(NSString *)text
{
    [self.hk_progressHUD autoShowErrorMessage:text];
}
/** 显示成功消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowSucceedMessage:(NSString *)text
{
    [self.hk_progressHUD autoShowSucceedMessage:text];
}
/** 显示提示消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowInfoMessage:(NSString *)text
{
    [self.hk_progressHUD autoShowInfoMessage:text];
}
/** 显示警告消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowAlertMessage:(NSString *)text
{
    [self.hk_progressHUD autoShowAlertMessage:text];
}
/** 显示自定义的 iocn 和消息内容，1秒后自动隐藏 */
- (void)hk_autoShowImage:(UIImage *)image withMessage:(NSString *)message
{
    [self.hk_progressHUD autoShowImage:image withMessage:message];
}

@end
