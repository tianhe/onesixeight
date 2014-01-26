//
//  UIButton+OSE.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "UIButton+OSE.h"

@implementation UIButton (OSE)

+ (UIButton *)standardButton
{
    UIButton *oseButton = [[UIButton alloc] init];
    [oseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [oseButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [oseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    [oseButton.layer setBorderColor:[[UIColor blueColor] CGColor]];
    [oseButton.layer setBorderWidth:1];
    oseButton.backgroundColor = [UIColor clearColor];
    oseButton.frame = CGRectMake(0, 0, 280, 40);
    return oseButton;
}

+ (UIButton *)standardRedButton
{
    UIButton *oseButton = [[UIButton alloc] init];
    [oseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [oseButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [oseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [oseButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [oseButton.layer setBorderWidth:1];
    oseButton.backgroundColor = [UIColor clearColor];
    oseButton.frame = CGRectMake(0, 0, 280, 40);
    return oseButton;
}

+ (UIButton *)standardHalfButton
{
    UIButton *oseButton = [[UIButton alloc] init];
    [oseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [oseButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [oseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    [oseButton.layer setBorderColor:[[UIColor blueColor] CGColor]];
    [oseButton.layer setBorderWidth:1];
    oseButton.backgroundColor = [UIColor clearColor];
    oseButton.frame = CGRectMake(0, 0, 120, 40);
    return oseButton;
}

+ (UIButton *)solidHalfButton
{
    UIButton *oseButton = [[UIButton alloc] init];
    [oseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [oseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    oseButton.backgroundColor = [UIColor grayColor];
    oseButton.frame = CGRectMake(0, 0, 120, 40);
    return oseButton;
}
@end
