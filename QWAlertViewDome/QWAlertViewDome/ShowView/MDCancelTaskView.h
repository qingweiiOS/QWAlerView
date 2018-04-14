//
//  MDCancelTaskView.h
//
//  Created by 卿伟 on 2018/1/2.
//  Copyright © 2018年 jonh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickQueRenBlock)(NSArray *whyArry);
@interface MDCancelTaskView : UIView

- (IBAction)action_QueDing:(UIButton *)sender;

- (IBAction)action_Cancel:(UIButton *)sender;
@property (nonatomic ,strong) ClickQueRenBlock queenBlock;

@end
