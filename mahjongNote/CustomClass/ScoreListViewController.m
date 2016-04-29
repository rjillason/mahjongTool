//
//  ScoreListViewController.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 30/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "ScoreListViewController.h"
#import "GridTableViewCell.h"
#import "PlayerInfoManager.h"
#import "GridBigTableCell.h"
#import "Utilities.h"

@interface ScoreListViewController ()

@end

//static NSString *CellIdentifier = @"Cell";
static NSString *CellIdentifier = @"gridBigTableCell";
@implementation ScoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    recordArray = [[RecordManager sharedManager] recordArray];
    
    selectedIndex = -1;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)SaveButtonOnClick:(id)sender {
    
}

- (RecordRow*) getAccumRecordRow : (int) index {
    int score1 = 0;
    int score2 = 0;
    int score3 = 0;
    int score4 = 0;
    
    for (int a = 0 ; a < index; a++) {
        RecordRow * tempRecord = [recordArray objectAtIndex:a];
        score1 += [[tempRecord.scoreArray objectAtIndex:0] intValue];
        score2 += [[tempRecord.scoreArray objectAtIndex:1] intValue];
        score3 += [[tempRecord.scoreArray objectAtIndex:2] intValue];
        score4 += [[tempRecord.scoreArray objectAtIndex:3] intValue];
    }
    
    RecordRow * accumRecordRow = [[RecordRow alloc] init];
    
    [accumRecordRow.scoreArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%i", score1]];
    [accumRecordRow.scoreArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%i", score2]];
    [accumRecordRow.scoreArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%i", score3]];
    [accumRecordRow.scoreArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%i", score4]];
    
    return accumRecordRow;
}


#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // first row is used to show PlayerName
    return [recordArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GridBigTableCell *cell = (GridBigTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GridBigTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // PlayerName should be shown in first row
    if (indexPath.row == 0) {
        cell.indexLabel.text = @"玩家名稱";
//        NSMutableArray* selectedPlayerInfoArray = [[PlayerInfoManager sharedManager] getSelectedPlayerInfoArray];
        cell.score1Label.text = [[PlayerInfoManager sharedManager] getSelectedPlayerNameAtIndex:0];
        cell.score2Label.text = [[PlayerInfoManager sharedManager] getSelectedPlayerNameAtIndex:1];
        cell.score3Label.text = [[PlayerInfoManager sharedManager] getSelectedPlayerNameAtIndex:2];
        cell.score4Label.text = [[PlayerInfoManager sharedManager] getSelectedPlayerNameAtIndex:3];
        return cell;
    }
    
    // set text
    RecordRow * row = [recordArray objectAtIndex:indexPath.row - 1];
    
    cell.indexLabel.text = [NSString stringWithFormat:@"第%i局", (int)indexPath.row];
    cell.score1Label.text = row.scoreArray[0];
    cell.score2Label.text = row.scoreArray[1];
    cell.score3Label.text = row.scoreArray[2];
    cell.score4Label.text = row.scoreArray[3];
    
    cell.accumLabel.text = @"目前累積";
    
    // Configure the cell
    if (selectedIndex == indexPath.row) {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        cell.indexLabel.font = [UIFont systemFontOfSize:11];
        [cell setAllLabelColor:[UIColor whiteColor]];
        
        [cell.accumLabel setHidden:false];
        [cell.accScore1Label setHidden:false];
        [cell.accScore2Label setHidden:false];
        [cell.accScore3Label setHidden:false];
        [cell.accScore4Label setHidden:false];
        
        RecordRow * accumRecordRow = [self getAccumRecordRow:selectedIndex];
        cell.accScore1Label.text = accumRecordRow.scoreArray[0];
        cell.accScore2Label.text = accumRecordRow.scoreArray[1];
        cell.accScore3Label.text = accumRecordRow.scoreArray[2];
        cell.accScore4Label.text = accumRecordRow.scoreArray[3];
        
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.indexLabel.font = [UIFont systemFontOfSize:11];
        [cell setAllLabelColor:[UIColor blackColor]];
        
        [cell.accumLabel setHidden:true];
        [cell.accScore1Label setHidden:true];
        [cell.accScore2Label setHidden:true];
        [cell.accScore3Label setHidden:true];
        [cell.accScore4Label setHidden:true];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return  (indexPath.row != 0)? YES : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        int index = indexPath.row - 1;
        RecordRow *removeRecord = [recordArray objectAtIndex:index];
        [Utilities updateTransactionsToDB:removeRecord.transactionArray :YES];
        [recordArray removeObjectAtIndex:index];
        
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - TableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedIndex == indexPath.row && selectedIndex != 0) {
        return 88;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // User tap expanded row
    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    // User taps different row
    if (selectedIndex != -1) {
        NSIndexPath* prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = (int)indexPath.row;
        [tableView reloadRowsAtIndexPaths:@[prevPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // User taps new row when no row is expanding
    selectedIndex = (int)indexPath.row;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end


