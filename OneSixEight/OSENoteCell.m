//
//  OSENoteCell.m
//  OneSixEight
//
//  Created by Tian Y He on 2/3/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "OSENoteCell.h"

@implementation OSENoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 2, 100, 40)];
        self.dateLabel.textColor = [UIColor orangeColor];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        [self addSubview:self.dateLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
