
//
//  QWAlertView.m
//  AlertTest
//
//  Created by jonh on 2017/10/26.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "QWAlertView.h"
///屏幕宽度
#define SCREEN_W  [UIScreen mainScreen].bounds.size.width
///屏幕高度
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define KEYWINDOW     [[UIApplication sharedApplication] keyWindow]
#define ANIMATION_TIME 0.5
@interface QWAlertView ()
///遮罩层
@property (nonatomic, strong) CALayer *maskLayer;
//响应事件的控件
@property (nonatomic, strong) UIControl *control;
//保存弹出视图
@property (nonatomic, strong) UIView *contentView;
///弹出模式
@property (nonatomic, assign) QWAlertViewStyle alertStyle;
///动画前的位置
@property (nonatomic, assign) CGAffineTransform starTransForm;
///关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;
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
- (UIButton *)closeBtn{
    
    if(!_closeBtn){
        //添加按钮关闭
        _closeBtn = [[UIButton alloc] init];
        //        _closeBtn.backgroundColor = [UIColor whiteColor];
        //        _closeBtn.layer.cornerRadius = 15.0;
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.frame = CGRectMake(_contentView.frame.size.width - 30, 0, 30, 30);
        [_contentView addSubview:_closeBtn];
    }
    return _closeBtn;
}
- (void)show:(UIView *)contentView withType:(QWAlertViewStyle)style{
    //判断是否赋于大小
    CGFloat contentViewHeight =  contentView.frame.size.height;
    CGFloat contentViewWidth  =  contentView.frame.size.width;
    if(contentViewHeight == 0.00||contentViewWidth == 0.00){
        NSLog(@"弹出视图 必须 赋予宽高");
        return;
    }
    _contentView = contentView;
    _contentView.center = KEYWINDOW.center;
    _alertStyle = style;
    _on = YES;
    if (!_maskLayer) {
        [self addMaskLayer];
        // 根据弹出模式 添加动画
        switch (_alertStyle) {
            case QWAlertViewStyleAlert:
                _starTransForm = CGAffineTransformMakeScale(0.01, 0.01);
                break;
            case QWAlertViewStyleActiAlertLeft:
                _starTransForm = CGAffineTransformMakeTranslation(-SCREEN_W, 0);
                break;
            case QWAlertViewStyleActiAlertRight:
                _starTransForm = CGAffineTransformMakeTranslation(SCREEN_W, 0);
                break;
            case QWAlertViewStyleActionSheetTop:
              
                _starTransForm = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
                break;
            case QWAlertViewStyleActionSheetDown:
             
                _starTransForm = CGAffineTransformMakeTranslation(0, SCREEN_H);
                break;
            default:
                break;
        }
        [self alertAnimatedPrensent];
        
    }else {
        
        //
        _maskLayer = nil;
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
    _maskLayer = [CALayer layer];
    [_maskLayer setFrame:[[UIScreen mainScreen] bounds]];
    [_maskLayer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.30].CGColor];
    [[KEYWINDOW layer] addSublayer:_maskLayer];
    //判断关闭方式
    [self setCloseStyle:_closeStyle];
    [KEYWINDOW addSubview:_control];
    
}

//关闭 自带事件 由用户自己写事件关闭弹窗
- (void)setOn:(BOOL)on{
    _on = on;
    _control.enabled = _on;
    _closeBtn.hidden = !_on;
}
- (void)setCloseImage:(UIImage *)closeImage{
    
    [_closeBtn setImage:closeImage forState:UIControlStateNormal];
}
- (void)setCloseStyle:(CloseStyle)closeStyle{
    _closeStyle = closeStyle;
    //判断关闭方式
    if (_closeStyle == CloseStyleTapClose)
    {
        self.control.enabled = YES;
        self.closeBtn.hidden = YES;
    }else{
        self.control.enabled = NO;
        self.closeBtn.hidden = NO;
    }
    
}
- (void)dismiss{
    //设置初始值
    // 移除遮罩
    if (_maskLayer) {
        [_maskLayer removeFromSuperlayer];
        [_control removeFromSuperview];
        [_closeBtn removeFromSuperview];
        _maskLayer = nil;
        _control = nil;
        _closeBtn = nil;
    }
    //移除弹出框
    [self alertAnimatedOut];
    //回调动画完成回调
    if (_dismissBlock) {
        
        _dismissBlock();
    }
    
}
- (void)alertAnimatedPrensent{
    _contentView.transform = _starTransForm;
    [KEYWINDOW addSubview:_contentView];
    [UIView animateWithDuration:ANIMATION_TIME delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _contentView.transform = CGAffineTransformIdentity;
        KEYWINDOW.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        KEYWINDOW.userInteractionEnabled = YES;
        if (_showBlock) {
            //动画完成后回调
            _showBlock();
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
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        _contentView.transform = _starTransForm;
        KEYWINDOW.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        KEYWINDOW.userInteractionEnabled = YES;
        [_contentView removeFromSuperview];
        _contentView = nil;
    }];
    
}
@end
