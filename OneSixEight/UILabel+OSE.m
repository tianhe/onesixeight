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
    oseLabel.textColor = [UIColor whiteColor];
    oseLabel.frame = CGRectMake(0, 0, 100, 40);
    return oseLabel;
}

@end
