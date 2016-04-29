//
//  GridBigTableCell.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 12/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerListTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView* playerImageView;
@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UILabel* incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel* winRateLabel;
@property (strong, nonatomic) IBOutlet UILabel* invoteRoundLabel;


@end
