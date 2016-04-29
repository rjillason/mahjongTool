//
//  MaxFanNumberViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 23/5/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaxFanNumberViewController : UIViewController <UITableViewDataSource> {
    NSMutableArray* fanCostArray; // Array with certain fanNumber and MaxMoney
    
    NSArray* fanNumberArray;
    NSArray* maxMoneyArray;
    
    bool sharePenalty;
    int fanNumber;
    int maxMoney;
}

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@property (strong, nonatomic) IBOutlet UISegmentedControl* sharePenaltySegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl* fanNumberSegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl* maxMoneySegment;

-(IBAction)segmentOnChange:(id)sender;

//-(void)loadData:(NSString*) query;

@end
