//
//  QWAlertView.h
//  AlertTest
//
//  Created by jonh on 2017/10/26.
//  Copyright © 2017年 jonh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
///弹窗模式
typedef enum{
    ///默认 从窗口正中 弹出
    QWAlertViewStyleAlert = 0,
    ///下
    QWAlertViewStyleAlertDown,
    ///上
    QWAlertViewStyleAlertTop,
    ///左
    QWAlertViewStyleAlertLeft,
    ///右
    QWAlertViewStyleAlertRight,
    ///无动画效果
    QWAlertViewStyleNone,
    
}QWAlertViewStyle;
typedef void(^showBlock)(void);;
typedef void(^dismissBlock)(void);
@interface QWAlertView : NSObject
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

@end

