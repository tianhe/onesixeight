//
//  UITextField+OSE.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "UITextField+OSE.h"

@implementation UITextField (OSE)
+ (UITextField *)standardTextField
{
    UITextField *oseTextField = [[UITextField alloc] init];
    oseTextField.backgroundColor = [UIColor whiteColor];
    oseTextField.frame = CGRectMake(0, 0, 100, 40);
    oseTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    return oseTextField;
}

@end
