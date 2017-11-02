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
    QWAlertViewStyleAlert = 0,
    QWAlertViewStyleActionSheetDown,
    QWAlertViewStyleActionSheetTop,
    QWAlertViewStyleActiAlertLeft,
    QWAlertViewStyleActiAlertRight,

}QWAlertViewStyle;
///关闭模式
typedef enum{
    CloseStyleTapClose = 0,  // 触摸整个弹窗关闭
    CloseStyleButtonClose,   // 添加一个关闭按钮关闭
}CloseStyle;
typedef void(^showBlock)(void);;
typedef void(^dismissBlock)(void);
@interface QWAlertView : NSObject
///弹出回调
@property (nonatomic, copy) showBlock showBlock;
///关闭回调
@property (nonatomic, copy) dismissBlock dismissBlock;
///关闭模式
@property (nonatomic, assign) CloseStyle closeStyle;
/// 开启 或关闭 触摸关闭弹窗  （默认开启）
@property (nonatomic, assign) BOOL on;
/// 关闭按钮 图片 30*30
@property (nonatomic, strong) UIImage *closeImage;
/**  创建弹出试图 */
+ (QWAlertView *)sharedMask;
/*
 * show:withType:     弹出视图
 *
 * @param contentView 需要弹出的视图
 * @param style       弹出模式
 *
 */
- (void)show:(UIView *)contentView withType:(QWAlertViewStyle)style;
/**
 *  show:withType:animationFinish:dismissHandle: 弹出视图
 *
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
