//
//  MDCancelTaskView.m
//
//  Created by 卿伟 on 2018/1/2.
//  Copyright © 2018年 jonh. All rights reserved.
//

#import "MDCancelTaskView.h"
#import "QWAlertView.h"
@interface MDCancelTaskView ()<UITextViewDelegate>{
    
    
}
@property (weak, nonatomic) IBOutlet        UIView *whyTwoView;
@property (weak, nonatomic) IBOutlet       UIView *whyFourView;
@property (weak, nonatomic) IBOutlet      UIView *otherWhyView;
@property (weak, nonatomic) IBOutlet UITextView *otherTextView;
@property (weak, nonatomic) IBOutlet        UIView *whyOneView;
@property (weak, nonatomic) IBOutlet      UIView *whyThreeView;
@property (nonatomic ,strong)         NSMutableArray *whrArray;
@end
@implementation MDCancelTaskView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.otherTextView.delegate = self;
}
- (NSMutableArray *)whrArray{
    if(!_whrArray){
        _whrArray = [NSMutableArray array];
    }
    return _whrArray;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -150);
    }];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    
}
- (IBAction)action_QueDing:(UIButton *)sender {
  
}
- (IBAction)touch_selectWhy:(UITapGestureRecognizer *)sender {
   
}

- (IBAction)action_Cancel:(UIButton *)sender {
    [[QWAlertView sharedMask] dismiss];
}
@end
