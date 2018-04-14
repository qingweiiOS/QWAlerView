//
//  ViewController.m
//  QWAlertViewDome
//
//  Created by 卿伟 on 2018/4/14.
//  Copyright © 2018年 卿伟. All rights reserved.
//

#import "ViewController.h"
#import "QWAlertView.h"
#import "MDCancelTaskView.h"
@interface ViewController ()
@property (nonatomic, strong) MDCancelTaskView *cancelTaskView;
@end

@implementation ViewController
- (MDCancelTaskView *)cancelTaskView{
    if(!_cancelTaskView){
     
        _cancelTaskView = [[[NSBundle mainBundle] loadNibNamed:@"MDCancelTaskView" owner:nil options:nil] firstObject];
        _cancelTaskView.frame = CGRectMake(0, 0, 300, 460);
       
    }
    return _cancelTaskView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)action_showView:(UIButton *)sender {
    NSLog(@"%lu",sender.tag);
    [[QWAlertView sharedMask] show:self.cancelTaskView withType:(QWAlertViewStyle)sender.tag];

}


@end
