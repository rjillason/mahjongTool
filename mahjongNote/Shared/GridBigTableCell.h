//
//  GridBigTableCell.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 12/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridBigTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel* indexLabel;
@property (strong, nonatomic) IBOutlet UILabel* score1Label;
@property (strong, nonatomic) IBOutlet UILabel* score2Label;
@property (strong, nonatomic) IBOutlet UILabel* score3Label;
@property (strong, nonatomic) IBOutlet UILabel* score4Label;
@property (strong, nonatomic) IBOutlet UILabel* accumLabel;
@property (strong, nonatomic) IBOutlet UILabel* accScore1Label;
@property (strong, nonatomic) IBOutlet UILabel* accScore2Label;
@property (strong, nonatomic) IBOutlet UILabel* accScore3Label;
@property (strong, nonatomic) IBOutlet UILabel* accScore4Label;

- (void) setAllLabelColor : (UIColor*) color;

@end
