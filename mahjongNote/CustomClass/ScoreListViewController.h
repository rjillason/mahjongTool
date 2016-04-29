//
//  ScoreListViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 30/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordManager.h"

@interface ScoreListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray* recordArray;
    int selectedIndex;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)SaveButtonOnClick:(id)sender;

- (RecordRow*) getAccumRecordRow : (int) index;

//- (void) addRecord;

@end
