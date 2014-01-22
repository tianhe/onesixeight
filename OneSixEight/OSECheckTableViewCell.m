//
//  OSECheckViewCell.m
//  OneSixEight
//
//  Created by Tian Y He on 1/19/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSECheckTableViewCell.h"

@implementation OSECheckTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.hoursInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 158, 40)];
        self.hoursInfoLabel.textColor = [UIColor blackColor];
        self.hoursInfoLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.hoursInfoLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
