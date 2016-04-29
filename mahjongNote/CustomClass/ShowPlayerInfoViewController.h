//
//  ShowPlayerInfoViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 12/1/2016.
//  Copyright © 2016 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerInfo.h"
#import "mahjongNote-Swift.h"

@interface ShowPlayerInfoViewController : UIViewController <ChartViewDelegate>

@property (strong, nonatomic) PlayerInfo* info;
@property (nonatomic, strong) IBOutlet RadarChartView *chartView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) IBOutlet UILabel* nameLabel;

- (IBAction)cancelOnClick:(id)sender;

- (void)initChart;


@end
