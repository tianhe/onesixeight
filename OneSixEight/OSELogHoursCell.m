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
        self.hoursInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 50, 40)];
        self.hoursInfoLabel.textColor = [UIColor blackColor];
        self.hoursInfoLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.hoursInfoLabel];
        
        self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(250, 0, 50, 40)];
        self.progressBar.progressViewStyle = UIProgressViewStyleDefault;
        [self addSubview:self.progressBar];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
