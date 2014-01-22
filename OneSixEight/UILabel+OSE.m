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
    oseLabel.textColor = [UIColor whiteColor];
    return oseLabel;
}

+ (UILabel *)standardFullLabel
{
    UILabel *oseLabel = [[UILabel alloc] init];
    int width = [UIScreen mainScreen].bounds.size.width;
    oseLabel.frame = CGRectMake(0, 0, width-40, 40);
    oseLabel.textColor = [UIColor blackColor];
    oseLabel.backgroundColor = [UIColor whiteColor];
    return oseLabel;
}

@end
