//
//  GridBigTableCell.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 12/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "GridBigTableCell.h"

@implementation GridBigTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setAllLabelColor : (UIColor*) color {
    self.indexLabel.textColor = color;
    self.score1Label.textColor = color;
    self.score2Label.textColor = color;
    self.score3Label.textColor = color;
    self.score4Label.textColor = color;
    self.accumLabel.textColor = color;
    self.accScore1Label.textColor = color;
    self.accScore2Label.textColor = color;
    self.accScore3Label.textColor = color;
    self.accScore4Label.textColor = color;
}

@end
