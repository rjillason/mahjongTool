//
//  MaxFanNumberViewController.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 23/5/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "MaxFanNumberViewController.h"
#import "DBManager.h"
#import "MaxFanNumberManager.h"

@interface MaxFanNumberViewController ()

@end

static NSString *CellIdentifier = @"Cell";

@implementation MaxFanNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fanNumberArray = [[NSArray alloc] initWithObjects:@"8",@"10",@"13",nil];
    maxMoneyArray = [[NSArray alloc] initWithObjects:@"32",@"64",@"96",@"128",@"256",@"512",nil];
    
    fanNumber = [[fanNumberArray objectAtIndex:0] intValue];
    
    maxMoney = [[maxMoneyArray objectAtIndex:0] intValue];
    
    // Form the query.
    NSString *query = @"select * from fanNumberTable where fanNumber = '8' and MaxMoney = '32'";
    [self loadData:query];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)segmentOnChange:(id)sender {
    sharePenalty = [[self sharePenaltySegment] selectedSegmentIndex];
    
    NSString* fanNumberStr = [fanNumberArray objectAtIndex:[[self fanNumberSegment] selectedSegmentIndex]];
    fanNumber = [fanNumberStr intValue];
    
    NSString* maxMoneyStr = [maxMoneyArray objectAtIndex:[[self maxMoneySegment] selectedSegmentIndex]];
    maxMoney = [maxMoneyStr intValue];
    
    [[MaxFanNumberManager sharedManager] setSharePenalty:sharePenalty];
    [[MaxFanNumberManager sharedManager] setFanNumber:fanNumber];
    
    NSString *query = [NSString stringWithFormat:@"select * from fanNumberTable where fanNumber = '%d' and MaxMoney = '%d'",fanNumber, maxMoney];
    
    [self loadData:query];
}

-(void)loadData:(NSString*) query{
    
    // Get the results.
    if (fanCostArray != nil) {
        fanCostArray = nil;
    }
    
    NSArray* tempResult = [[DBManager sharedManager] loadDataFromDB:query];
    if (tempResult == nil || [tempResult count] == 0) {
        [self.tableView setHidden: true];
        return ;
    } else {
        [self.tableView setHidden: false];
    }
    
    fanCostArray = [[NSMutableArray alloc] initWithArray:tempResult];

    NSMutableArray* tempArray = [fanCostArray objectAtIndex:0];
    NSMutableArray* tempFanCostArray =  [[NSMutableArray alloc] init];
    
    // first 2 index = fanNumber and MaxMoney, so skip it
    // also skip object with Number 0
    for (int a = 2; a < [tempArray count]; a++) {
        int number = [[tempArray objectAtIndex:a] intValue];
        if (number != 0) {
            [tempFanCostArray addObject:[tempArray objectAtIndex:a]];
        } else {
            break;
        }
    }
    
    [[MaxFanNumberManager sharedManager] setFanCostArray: tempFanCostArray];
    
    // Reload the table view.
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // from 3 - 13 fan
    return (fanNumber - 2) ;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"番數：%d",indexPath.row + 3];
    if (fanCostArray != nil && [fanCostArray count] > 0) {
        NSMutableArray* fanCostList = [fanCostArray objectAtIndex:0];
        
        if (fanCostList != nil && [fanCostList count] > 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",[[fanCostList objectAtIndex:indexPath.row + 2] intValue]];
        } else {
            cell.detailTextLabel.text = @"0";
        }
    } else {
        cell.detailTextLabel.text = @"0";
    }
    
    return cell;
}



@end
