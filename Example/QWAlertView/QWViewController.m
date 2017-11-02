//
//  QWViewController.m
//  QWAlertView
//
//  Created by 772053795@qq.com on 10/30/2017.
//  Copyright (c) 2017 772053795@qq.com. All rights reserved.
//

#import "QWViewController.h"
#import <QWAlertView/QWAlertView.h>

@interface QWViewController ()

@end

@implementation QWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIView *temPViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
    temPViews.backgroundColor = [UIColor redColor];
    [[QWAlertView sharedMask] show:temPViews withType:QWAlertViewStyleAlert];
    [[QWAlertView sharedMask] setCloseImage:[UIImage imageNamed:@"inviteClose"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
