# QWAlertView
# 当前版本 0.2.2

`pod 'QWAlertView'`

### 效果图

![](https://github.com/qingweiiOS/QWAlerView/blob/master/180646qm8ybtxt488lplbt.gif)

### 代码

```ruby
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
```

## License

QWAlertView is available under the MIT license. See the LICENSE file for more info.


