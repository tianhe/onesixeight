//
//  UIView+OSE.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "UIView+OSE.h"

@implementation UIView (OSE)

- (void)setOriginAtX:(CGFloat)x andY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(x, y);
    self.frame = frame;
}

@end
