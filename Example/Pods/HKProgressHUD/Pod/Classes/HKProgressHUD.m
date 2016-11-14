//
//  HKProgressHUD.m
//  HKProgressHUD
//
//  Created by Harley.xk on 15/12/15.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKProgressHUD.h"
#import "HKRoundProgressView.h"

typedef NS_ENUM(NSUInteger, HKProgressHUDMode)
{
    /** 使用 UIActivityIndicatorView 显示正在执行任务 */
    HKProgressHUDModeActivity,
    /** 使用圆形的进度条显示当前任务进度 */
    HKProgressHUDModeProgress,
    /** 使用自定义的图片显示一段文字 */
    HKProgressHUDModeImage,
    /** 显示一段纯文字 */
    HKProgressHUDModeText
};

@interface HKProgressHUD ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *hudView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet HKRoundProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hudHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *positionY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *positionX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceBetweenIconAndLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelMinWidth;

@property (weak,   nonatomic) UIView *parent;
@property (assign, nonatomic) BOOL isShown;

@property (assign, nonatomic) HKProgressHUDMode mode;
@property (copy,   nonatomic) NSString *message;
@property (assign, nonatomic) CGFloat progress;
@property (strong, nonatomic) UIImage *customImage;

@end

@implementation HKProgressHUD

+ (NSBundle *)bundle
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[HKProgressHUD class]];
    NSString *resourcePath = [frameworkBundle pathForResource:@"HKProgressHUD" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:resourcePath];
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    return bundle;
}

- (NSBundle *)bundle
{
    return [[self class] bundle];
}

+ (HKProgressHUD *)setupWithView:(UIView *)view
{
    HKProgressHUD *progressHUD = [[self bundle] loadNibNamed:@"HKProgressHUD" owner:nil options:nil][0];
    [progressHUD setupWithView:view];
    return progressHUD;
}

- (void)setupWithView:(UIView *)view
{
    [view addSubview:self];
    self.parent = view;
    [self pinEdgesToSuperview];
    
    self.hudView.layer.cornerRadius = 10;
    self.hidden = YES;
    
    self.maskColor = [UIColor clearColor];
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.850];
    self.tintColor = [UIColor whiteColor];
}

- (void)pinEdgesToSuperview
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.parent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.parent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.parent attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.parent attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self.parent addConstraint:top];
    [self.parent addConstraint:bottom];
    [self.parent addConstraint:leading];
    [self.parent addConstraint:trailing];
    
    [self layoutIfNeeded];
}

- (void)updateAndShow
{
    self.positionX.constant = self.offsetX;
    self.positionY.constant = self.offsetY;
    
    self.backgroundView.backgroundColor = self.maskColor;
    self.hudView.backgroundColor = self.backgroundColor;
    self.iconView.tintColor = self.tintColor;
    self.activityView.tintColor = self.tintColor;
    self.progressView.tintColor = self.tintColor;
    self.progressView.lineBackgroundColor = self.backgroundColor;
    self.textLabel.textColor = self.tintColor;
    
    if (self.message.length > 0) {
        self.spaceBetweenIconAndLabel.constant = 8;
        self.textLabelMinWidth.constant = 70;
        self.hudHeight.constant = 100;
        self.textLabelHeight.constant = 20;
    }else {
        self.spaceBetweenIconAndLabel.constant = 0;
        self.textLabelMinWidth.constant = 42;
        self.hudHeight.constant = 72;
        self.textLabelHeight.constant = 0;
    }
    self.textLabel.text = self.message;
    
    switch (self.mode) {
        case HKProgressHUDModeActivity:
        {
            self.iconView.hidden = YES;
            self.progressView.hidden = YES;
            self.activityView.hidden = NO;
            break;
        }
        case HKProgressHUDModeProgress:
        {
            self.iconView.hidden = YES;
            self.progressView.hidden = NO;
            self.activityView.hidden = YES;
            break;
        }
        case HKProgressHUDModeImage:
        {
            self.iconView.hidden = NO;
            self.iconView.image = self.customImage;
            self.progressView.hidden = YES;
            self.activityView.hidden = YES;
            break;
        }
        case HKProgressHUDModeText:
        {
            self.iconView.hidden = YES;
            self.progressView.hidden = YES;
            self.activityView.hidden = YES;
            self.hudHeight.constant = 52;
            break;
        }
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self show];
    });
}

- (void)reset
{
    self.iconView.hidden = YES;
    self.progressView.hidden = YES;
    self.activityView.hidden = YES;

    self.iconView.image = nil;
    self.message = nil;
    self.progress = 0;
    self.progressView.progress = 0;
}

- (void)show
{
    if (self.isShown) {
        return;
    }
    self.isShown = YES;

    self.alpha = 0.f;
    self.hidden = NO;
    [self.parent bringSubviewToFront:self];
    
    [self.layer removeAllAnimations];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide
{
    if (!self.isShown) {
        return;
    }
    self.isShown = NO;

    [self.layer removeAllAnimations];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
            [self reset];
        }
    }];
}

- (void)autoHide
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}

- (UIImage *)templateIconWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName inBundle:[self bundle] compatibleWithTraitCollection:nil];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

#pragma mark - Show & Hide Progress
/** 显示 UIActivityIndicatorView 与文字信息，直到主动取消 */
- (void)showActivityWithMessage:(NSString *)message
{
    self.mode = HKProgressHUDModeActivity;
    self.message = message;
    [self updateAndShow];
}
/** 显示圆形进度条与文字信息，直到主动取消 */
- (void)showProgress:(CGFloat)progress withMessage:(NSString *)message
{
    self.mode = HKProgressHUDModeProgress;
    self.message = message;
    self.progress = progress;
    self.progressView.progress = progress;
    [self updateAndShow];
}

#pragma mark - Show Messages
/** 显示一段纯文字，直到主动取消 */
- (void)showText:(NSString *)text
{
    self.mode = HKProgressHUDModeText;
    self.message = text;
    [self updateAndShow];
}

/** 显示错误消息 iocn 和消息内容，直到主动取消 */
- (void)showErrorMessage:(NSString *)text
{
    self.mode = HKProgressHUDModeImage;
    self.message = text;
    self.customImage = [self templateIconWithName:@"icn_cross"];;
    [self updateAndShow];
}

/** 显示成功消息 iocn 和消息内容，直到主动取消 */
- (void)showSucceedMessage:(NSString *)text
{
    self.mode = HKProgressHUDModeImage;
    self.message = text;
    self.customImage = [self templateIconWithName:@"icn_check"];;
    [self updateAndShow];
}
/** 显示提示消息 iocn 和消息内容，直到主动取消 */
- (void)showInfoMessage:(NSString *)text
{
    self.mode = HKProgressHUDModeImage;
    self.message = text;
    self.customImage = [self templateIconWithName:@"icn_info"];;
    [self updateAndShow];
}
/** 显示警告消息 iocn 和消息内容，直到主动取消 */
- (void)showAlertMessage:(NSString *)text
{
    self.mode = HKProgressHUDModeImage;
    self.message = text;
    self.customImage = [self templateIconWithName:@"icn_alert"];;
    [self updateAndShow];
}
/** 显示自定义的 iocn 和消息内容，直到主动取消 */
- (void)showImage:(UIImage *)image withMessage:(NSString *)message
{
    self.mode = HKProgressHUDModeImage;
    self.message = message;
    self.customImage = image;
    [self updateAndShow];
}

/** 显示一段纯文字，1秒后自动隐藏 */
- (void)autoShowText:(NSString *)text
{
    [self showText:text];
    [self autoHide];
}

/** 显示错误消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowErrorMessage:(NSString *)text
{
    [self showErrorMessage:text];
    [self autoHide];
}
/** 显示成功消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowSucceedMessage:(NSString *)text
{
    [self showSucceedMessage:text];
    [self autoHide];
}
/** 显示提示消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowInfoMessage:(NSString *)text
{
    [self showInfoMessage:text];
    [self autoHide];
}
/** 显示警告消息 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowAlertMessage:(NSString *)text
{
    [self showAlertMessage:text];
    [self autoHide];
}
/** 显示自定义的 iocn 和消息内容，1秒后自动隐藏 */
- (void)autoShowImage:(UIImage *)image withMessage:(NSString *)message
{
    [self showImage:image withMessage:message];
    [self autoHide];
}

@end





