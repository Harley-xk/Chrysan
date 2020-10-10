
<h1>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/icon.png" height=35>  Chrysan</img>
</h1>

[![CI Status](http://img.shields.io/travis/Harley-xk/Chrysan.svg?style=flat)](https://travis-ci.org/Harley-xk/Chrysan)
[![Version](https://img.shields.io/cocoapods/v/Chrysan.svg?style=flat)](http://cocoapods.org/pods/Chrysan)
[![Language](https://img.shields.io/badge/language-Swift%205-orange.svg)](https://swift.org)
[![License](https://img.shields.io/cocoapods/l/Chrysan.svg?style=flat)](http://cocoapods.org/pods/Chrysan)
[![Platform](https://img.shields.io/cocoapods/p/Chrysan.svg?style=flat)](http://cocoapods.org/pods/Chrysan)
[![twitter](https://img.shields.io/badge/twitter-Harley--xk-blue.svg)](https://twitter.com/Harley86589)
[![weibo](https://img.shields.io/badge/weibo-%E7%BE%A4%E6%98%9F%E9%99%A8%E8%90%BD-orange.svg)](https://weibo.com/u/1161848005)

> Chrysan 是一个简单易用的 HUD 库，使用 iOS 自带的 UIBlurEffect 毛玻璃特效。

使用基于 UIViewPropertyAnimator 的**动画**，可以自定义想要的效果

<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/animation-spring.gif" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/animation-cubic.gif" height=400></img>

多种内置的指示器效果，同样支持自定义，并且支持 **GIF** 动图

<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/indicator-system.gif" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/indicator-ring.gif" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/indicator-ring-dots.gif" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/animation-gif.gif" height=400></img>

进度指示器，内置环形和条形进度指示器，支持自定义进度文字和颜色

<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/progress-ring.gif" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/progress-bar.gif" height=400></img>

静态状态指示器, 内置带动画的成功和失败指示器，支持自定义路径动画

<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/state-success.png" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/state-failure.png" height=400></img>

支持自定义扩展更多状态，支持自定义图标指示器，支持使用系统内置 SF Symbols 作为图标

<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/state-custom.png" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/icon-sf-1.png" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/icon-sf-2.png" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/icon-sf-3.png" height=400></img>

纯文本展示，支持单行和多行文本

<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/text-single-line.png" height=400></img>
<img src="https://me.harley-xk.studio/post-images/README/github-chrysan/text-multi-line.png" height=400></img>


### 适配

Chrysan 2.x 是一个完全重写的版本，以支持更多的指示器类型、更多的动画配置，以及完全开放的自定义 API。

Chrysan 2.x 支持 iOS 11+ 以及 Swift 5.3+。如需支持更早的版本，请使用 1.x 版。

### 安装

> 注意：Chrysan 依赖 SnapKit 5.x 进行 UI 布局，确保你没有引用与其冲突的其他第三方库

#### 通过 CocoaPods 安装

```ruby
pod 'Chrysan'
```

#### 通过 SPM 安装

向 Package.swift 添加依赖：

```swift
dependencies: [
    .package(url: "https://github.com/Harley-xk/Chrysan.git", .upToNextMajor(from: "2.0.0")),
],
```

#### 通过 Carthage 安装

```ruby
github "Harley-xk/Chrysan"
```

在命令行执行 `carthage update` 来完成编译，然后将 `Chrysan.framework` 添加到你的项目中。

**确保将 `Chrysan.framework` 添加到 target 的 `Embedded Binaries` 配置项中**

### 使用

#### 在 ViewController 中访问 Chrysan

通过 viewController.`chrysan` 方法可以访问当前视图控制器的 chrysan 组件并自动创建。chrysan 会自动添加到 viewController 的根视图。

#### 快速显示 Chrysan

```swift
chrysan.changeStatus(to: .loading(message: "正在加载"))
```

#### 显示进度

```swift
let progress = 0.1

// 显示进度
chrysan.changeStatus(to: .progress(message: "正在下载", progress: progress))

// 自定义进度文字
chrysan.changeStatus(to: .progress(message: "正在下载", progress: progress, progressText: "325/512"))
```

#### 隐藏 Chrysan

```swift
// 立刻隐藏 chrysan
chrysan.hide()
// 1 秒后隐藏 chrysan
chrysan.hide(afterDelay: 1)
```

#### 预设状态

Chrysan 内置了多种状态可以使用：

```swift

public extension Status {
    /// 预设状态：静默状态
    static let idle = Status(id: .idle)

    /// 纯文本的状态，此时一般只显示文本内容
    /// - Parameter message: 文本内容，支持多行
    static func plain(message: String) -> Status {
        return Status(id: .plain, message: message)
    }

    /// 加载中状态, 所有的 loading 状态都具有相同的 id
    /// - Parameter message: 自定义消息内容
    static func loading(message: String? = nil) -> Status {
        return Status(id: .loading, message: message)
    }

    /// 预设状态：带进度的状态，所有的 progress 状态都具有相同的 id
    static func progress(
        message: String? = nil,
        progress: Double,
        progressText: String? = nil
    ) -> Status {
        return Status(
            id: .progress,
            message: message,
            progress: progress,
            progressText: progressText
        )
    }

    /// 预设状态：成功
    static func success(message: String? = nil) -> Status {
        return Status(id: .success, message: message)
    }

    /// 预设状态：失败
    static func failure(message: String? = nil) -> Status {
        return Status(id: .failure, message: message)
    }
}
```

更多内容请查看示例以及代码注释。
