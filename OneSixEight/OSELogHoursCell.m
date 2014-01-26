//
//  OSELogHoursCell.m
//  OneSixEight
//
//  Created by Tian Y He on 1/25/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSELogHoursCell.h"

@implementation OSELogHoursCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.hoursInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 125, 40)];
        self.hoursInfoLabel.textColor = [UIColor blackColor];
        self.hoursInfoLabel.backgroundColor = [UIColor orangeColor];
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
