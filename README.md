# QWAlertView
# 当前版本 0.3.0

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
///触摸任意位置关闭弹窗 默认NO
@property (nonatomic, assign) BOOL touchOff;
///当前是否正在展示弹窗
@property (nonatomic, assign,readonly) BOOL isShow;

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


