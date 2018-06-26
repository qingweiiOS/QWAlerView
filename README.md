# QWAlertView
# 当前版本 0.2.2
[![CI Status](http://img.shields.io/travis/772053795@qq.com/QWAlertView.svg?style=flat)](https://travis-ci.org/772053795@qq.com/QWAlertView)
[![Version](https://img.shields.io/cocoapods/v/QWAlertView.svg?style=flat)](http://cocoapods.org/pods/QWAlertView)
[![License](https://img.shields.io/cocoapods/l/QWAlertView.svg?style=flat)](http://cocoapods.org/pods/QWAlertView)
[![Platform](https://img.shields.io/cocoapods/p/QWAlertView.svg?style=flat)](http://cocoapods.org/pods/QWAlertView)


180646qm8ybtxt488lplbt.gif
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

QWAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QWAlertView'
```

## Author

772053795@qq.com, 772053795@qq.com


![示例](https://github.com/qingweiiOS/QWAlerView/blob/master/180646qm8ybtxt488lplbt.gif)
## CODE
[[QWAlertView sharedMask] show:自定义视图 withType:(QWAlertViewStyle)（弹出方向）];

///弹出动画完成后的 回调
@property (nonatomic, copy) showBlock showBlock;
///关闭回调
@property (nonatomic, copy) dismissBlock dismissBlock;
///关闭模式
@property (nonatomic, assign) CloseStyle closeStyle;
/// 开启或关闭 自带的 移除弹窗事件 如果关闭需要自己调用 dismiss
@property (nonatomic, assign) BOOL on;
/// 关闭按钮 图片 30*30
@property (nonatomic, strong) UIImage *closeImage;
/**  创建弹出试图 */
+ (QWAlertView *)sharedMask;
/**
* show:withType:     弹出视图
* @param contentView 需要弹出的视图
* @param style       弹出模式
*/
- (void)show:(UIView *)contentView withType:(QWAlertViewStyle)style;
/**
*  show:withType:animationFinish:dismissHandle: 弹出视图
*  @param contentView 需要弹出的视图
*  @param style       弹出模式
*  @param show        弹出回调
*  @param dismiss     消失回调
*
*/
- (void)show:(UIView *)contentView withType:(QWAlertViewStyle)style animationFinish:(showBlock)show dismissHandle:(dismissBlock)dismiss;
/**  移除弹出视图 */

- (void)dismiss;


## License

QWAlertView is available under the MIT license. See the LICENSE file for more info.


