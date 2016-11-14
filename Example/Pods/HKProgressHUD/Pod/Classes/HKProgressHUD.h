//
//  HKProgressHUD.h
//  HKProgressHUD
//
//  Created by Harley.xk on 15/12/15.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HKProgressHUD.h"
#import "UIViewController+HKProgressHUD.h"

@interface HKProgressHUD : UIView

/**
 *  创建HUD，并且自动添加到视图
 */
+ (HKProgressHUD *)setupWithView:(UIView *)view;

/** 水平方向的偏移 */
@property (assign, nonatomic) CGFloat offsetX;
/** 竖直方向的偏移 */
@property (assign, nonatomic) CGFloat offsetY;

/**
 *  显示 progressHUD 时遮住原始 view 的颜色，默认为透明
 */
@property (strong, nonatomic) UIColor *maskColor;
/**
 *  ProgressHUD 的背景色，默认为 黑色，alpha = 0.85
 */
@property (strong, nonatomic) UIColor *backgroundColor;
/**
 *  ProgressHUD 的 icon 及文字颜色，默认为白色
 *  @attention 若要设置的使 tintColor 在自定义图片上生效，该图片必须为 Template 模式
 */
@property (strong, nonatomic) UIColor *tintColor;

#pragma mark - Show & Hide Progress
/** 显示 UIActivityIndicatorView 与文字信息，直到主动取消 */
- (void)showActivityWithMessage:(NSString *)message;
/** 显示圆形进度条与文字信息，直到主动取消 */
- (void)showProgress:(CGFloat)progress withMessage:(NSString *)message;
/** 隐藏 ProgressHUD */
- (void)hide;

#pragma mark - Show Messages
/** 显示一段纯文字，直到主动取消 */
- (void)showText:(NSString *)text;
/** 显示错误消息 iocn 和消息内容，直到主动取消 */
- (void)showErrorMessage:(NSString *)text;
/** 显示成功消息 iocn 和消息内容，直到主动取消 */
- (void)showSucceedMessage:(NSString *)text;
/** 显示提示消息 iocn 和消息内容，直到主动取消 */
- (void)showInfoMessage:(NSString *)text;
/** 显示警告消息 iocn 和消息内容，直到主动取消 */
- (void)showAlertMessage:(NSString *)text;
/** 显示自定义的 iocn 和消息内容，直到主动取消 */
- (void)showImage:(UIImage *)image withMessage:(NSString *)message;

/** 显示一段纯文字，1秒后自动隐藏 */
- (void)autoShowText:(NSString *)text;
/** 显示错误消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowErrorMessage:(NSString *)text;
/** 显示成功消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowSucceedMessage:(NSString *)text;
/** 显示提示消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowInfoMessage:(NSString *)text;
/** 显示警告消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowAlertMessage:(NSString *)text;
/** 显示自定义的 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowImage:(UIImage *)image withMessage:(NSString *)message;

@end
