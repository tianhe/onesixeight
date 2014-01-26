//
//  OSEPlanTableViewCell.m
//  OneSixEight
//
//  Created by Tian Y He on 1/20/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSEPlanTableViewCell.h"

@implementation OSEPlanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.hoursInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 50, 40)];
        self.hoursInfoLabel.textColor = [UIColor orangeColor];
        self.hoursInfoLabel.textAlignment = NSTextAlignmentRight;

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
