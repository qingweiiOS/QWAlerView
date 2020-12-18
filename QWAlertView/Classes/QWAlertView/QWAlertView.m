
//
//  QWAlertView.m
//  AlertTest
//
//  Created by jonh on 2017/10/26.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "QWAlertView.h"
///屏幕宽度
#define QSCREEN_W  [UIScreen mainScreen].bounds.size.width
///屏幕高度
#define QSCREEN_H [UIScreen mainScreen].bounds.size.height
#define QKEYWINDOW     [[UIApplication sharedApplication] keyWindow]
#define ANIMATION_TIME 0.5
#define QWWEAKSELF __weak typeof(self) weakSelf = self;
@interface QWAlertView ()
///遮罩层
@property (nonatomic, strong) UIView *maskLayer;
//响应事件的控件
@property (nonatomic, strong) UIControl *control;
//保存弹出视图
@property (nonatomic, strong) UIView *contentView;
///弹出模式
@property (nonatomic, assign) QWAlertViewStyle alertStyle;
///动画前的位置
@property (nonatomic, assign) CGAffineTransform starTransForm;
@end
@implementation QWAlertView
+ (QWAlertView *)sharedMask{
    static QWAlertView *alertView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!alertView) {
            alertView = [[QWAlertView alloc] init];
        }
    });
    return alertView;
}

- (UIControl *)control{
    
    if(!_control){
        
        _control = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_control addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _control.enabled = NO;
    }
    return _control;
}
- (void)show:(UIView *)contentView withType:(QWAlertViewStyle)style{
    //判断是否赋于大小
    CGFloat contentViewHeight =  contentView.frame.size.height;
    CGFloat contentViewWidth  =  contentView.frame.size.width;
    if(contentViewHeight == 0.00||contentViewWidth == 0.00){
        NSLog(@"弹出视图 必须 赋予宽高");
        return;
    }
    /// 如果上一次弹窗未关闭
    if(_isShow){
        [self clearLastPopover];
    }
    _contentView = contentView;
    _contentView.center = QKEYWINDOW.center;
    _alertStyle = style;
    _touchOff = NO;
    if (!_maskLayer) {
        [self addMaskLayer];
        // 根据弹出模式 添加动画
        switch (_alertStyle) {
            case QWAlertViewStyleAlert:
                _starTransForm = CGAffineTransformMakeScale(0.01, 0.01);
                break;
            case QWAlertViewStyleAlertLeft:
                _starTransForm = CGAffineTransformMakeTranslation(-QSCREEN_W, 0);
                break;
            case QWAlertViewStyleAlertRight:
                _starTransForm = CGAffineTransformMakeTranslation(QSCREEN_W, 0);
                break;
            case QWAlertViewStyleAlertTop:
                
                _starTransForm = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
                break;
            case QWAlertViewStyleAlertDown:
                
                _starTransForm = CGAffineTransformMakeTranslation(0, QSCREEN_H);
                break;
            default:
                _starTransForm = CGAffineTransformIdentity;
                
                break;
        }
        [self alertAnimatedPrensent];
        
    }else {
        
        //
        _maskLayer = nil;
    }
    
    _isShow = YES;
}
- (void)setTouchOff:(BOOL)touchOff{
    _touchOff = touchOff;
    if (_touchOff)
    {
        //判断关闭方式
        [QKEYWINDOW addSubview:self.control];
        self.control.enabled = YES;
        
    }else{
        self.control.enabled = NO;
        [self.control removeFromSuperview];
    }
}
//  自定义的alert或actionSheet内容view必须初始化大小
- (void)show:(UIView *)contentView withType:(QWAlertViewStyle)style animationFinish:(showBlock)show dismissHandle:(dismissBlock)dismiss {
    //保存 回调
    if (show) {
        _showBlock = [show copy];
    }
    if(dismiss){
        _dismissBlock = [dismiss copy];
    }
    [self show:contentView withType:style];
}
///添加遮罩
- (void)addMaskLayer{
    _maskLayer = [UIView new];
    [_maskLayer setFrame:[[UIScreen mainScreen] bounds]];
    [_maskLayer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.30]];
    [QKEYWINDOW  addSubview:_maskLayer];
   
}
- (void)clearLastPopover{
    // 移除遮罩
    if (_maskLayer) {
        [_maskLayer removeFromSuperview];
        [_control removeFromSuperview];
        
        _maskLayer = nil;
        _control = nil;
    }
    //移除弹出框
    QKEYWINDOW.userInteractionEnabled = YES;
    [self.contentView removeFromSuperview];
     self.contentView = nil;
    if (_dismissBlock) {
        _dismissBlock();
        _dismissBlock = nil;
    }
}
- (void)dismiss{
    // 移除遮罩
    if (_maskLayer) {
        [_maskLayer removeFromSuperview];
        [_control removeFromSuperview];
        
        _maskLayer = nil;
        _control = nil;
    }
    _isShow = NO;
    //移除弹出框
    [self alertAnimatedOut];
    //回调动画完成回调
    if (_dismissBlock) {
        _dismissBlock();
        _dismissBlock = nil;
    }
    
}
- (void)alertAnimatedPrensent{
    _contentView.transform = _starTransForm;
    [QKEYWINDOW addSubview:_contentView];
    QWWEAKSELF
    [UIView animateWithDuration:ANIMATION_TIME delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.contentView.transform = CGAffineTransformIdentity;
        QKEYWINDOW.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        QKEYWINDOW.userInteractionEnabled = YES;
        if (weakSelf.showBlock) {
            //动画完成后回调
            weakSelf.showBlock();
            weakSelf.showBlock = nil;
        }
    }];
}
- (void)addCoreAnimation{
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.duration = ANIMATION_TIME;
    [_contentView.layer addAnimation:animation forKey:@""];
    
}
- (void)alertAnimatedOut{
    QWWEAKSELF
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        weakSelf.contentView.transform = weakSelf.starTransForm;
        QKEYWINDOW.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        QKEYWINDOW.userInteractionEnabled = YES;
        [weakSelf.contentView removeFromSuperview];
         weakSelf.contentView = nil;
    }];
    
}
@end
