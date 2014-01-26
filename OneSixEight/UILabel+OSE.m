//
//  UILabel+OSE.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "UILabel+OSE.h"

@implementation UILabel (OSE)

+ (UILabel *)standardLabel
{
    UILabel *oseLabel = [[UILabel alloc] init];
    oseLabel.frame = CGRectMake(0, 0, 100, 40);
    oseLabel.textColor = [UIColor lightGrayColor];
    
    return oseLabel;
}

+ (UILabel *)standardFullLabel
{
    UILabel *oseLabel = [[UILabel alloc] init];
    int width = [UIScreen mainScreen].bounds.size.width;
    oseLabel.frame = CGRectMake(0, 0, width-40, 40);
    oseLabel.textColor = [UIColor lightGrayColor];
    oseLabel.textAlignment = NSTextAlignmentCenter;
    
    return oseLabel;
}

+ (UILabel *)bigLabel
{
    UILabel *oseLabel = [[UILabel alloc] init];
    int width = [UIScreen mainScreen].bounds.size.width;
    oseLabel.frame = CGRectMake(0, 0, width-40, 80);
    oseLabel.textColor = [UIColor lightGrayColor];
    oseLabel.textAlignment = NSTextAlignmentCenter;
    oseLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
    
    return oseLabel;
}

@end
