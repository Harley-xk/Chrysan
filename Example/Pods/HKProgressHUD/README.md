# HKProgressHUD

HKProgressHUD is a simple and clean hud sdk inspired by MBProgressHUD.

##### Why not MBProgressHUD?
MBProgressHUD is too old, it has so much code dealing with ARC and MRC, whitch is hard to read.And it has bugs using in Autolyout system.

HKProgressHUD is easy to use with Objective-C. 
The view is managed by xib and AutoLayout, so it fits any UI situation.

##### Use with cocoapods
Add this line to your podfile:

```
pod 'HKProgressHUD', :git => 'https://github.com/Harley-xk/HKProgressHUD.git'
```
##### Use in a UIViewController

* import head file

```objc
#import <UIViewController+HKProgressHUD.h>
```
* show an activity view with a message, the activity here is a system  UIActivityIndicatorView with large white style.

```objc
// at the start of some task
[self hk_showActivityWithMessage:@"Processing..."];

// when the task finished, hide the hud manually
[self hk_hideProgressHUD];
```

* show a round progress view with message, the round progress view here is a circle drawing with the percentage of the progress.

```objc
// when the progress changed
CGFloat progress = 0.1;
[self hk_showProgress:progress withMessage: @"Processing..."];

// when the task finished, hide the hud manually
[self hk_hideProgressHUD];

```

* show a single line text:

```objc
[self hk_autoShowText:@"This is a Message!"];
```
* show message with default icons. with the prefix "auto", the hud will hide automaticity, otherwise, you should hide it by your self

```objc
// show message with info icon
[self hk_autoShowInfoMessage:@"Here is some tips"];

// show message with alert icon
[self hk_autoShowAlertMessage:@"Warning, something will be wrong!"];

// show message with success icon
[self hk_autoShowSucceedMessage:@"Done, have fun!"];

// show message with failure icon
[self hk_autoShowErrorMessage:@"Oh no! Something is wrong!"];

// show message with your custom icon
UIImage *icon = [UIImage imageNamed:@"custom_icon"];
[self hk_autoShowImage:icon withMessage:@"It's an intersting thing!"];
```

##### Use in a UIView
HKProgressHUD can use in a single view. All the above methods are avaliable.

All you need to do is seting up the HUD before first useage.

```objc
// get your view in witch the hud will be shown
UIView *view = ...
// set up before first useage
[view hk_setupProgressHUD];

// use any APIs above as you like!
...
```

##### Use directly with HKProgressHUD
HKProgressHUD is packaged with UIView and UIViewController, so it can be used simply. It is not recommended to use it directly. If you try to do so, go deep into the API comments.

### See the sample project for more infomations!
