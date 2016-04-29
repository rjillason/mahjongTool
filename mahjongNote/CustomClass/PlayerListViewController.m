//
//  PlayerListViewController.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 30/12/2015.
//  Copyright © 2015 Chan Hin Chun. All rights reserved.
//

#import "PlayerListViewController.h"
#import "PlayerListTableCell.h"
#import "UIViewController+MJPopupViewController.h"
#import "Utilities.h"
#import "mahjongNote-Swift.h"
#import "ShowPlayerInfoViewController.h"

#define DEFAULT_IMG [UIImage imageNamed:default_imgURL]

@interface PlayerListViewController ()

@end

@implementation PlayerListViewController


static NSString *CellIdentifier = @"PlayerListTableCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellOnLongPress:)];
    [self.tableView addGestureRecognizer:longPressRecognizer];

    [self initPlayerViews];
    
    selectedPlayerArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",nil];
    
    NSLog(@"abc");
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updatePlayerInfoArray];
    [self.tableView reloadData];
}

- (IBAction)playerButtonOnClick:(UIButton *)sender {
    int index = (int)[sender tag];
    PlayerInfo* info = [selectedPlayerArray objectAtIndex:index];
    if (![info isEqual: @""]) {
        info.selectedIndex = -1;
        [selectedPlayerArray replaceObjectAtIndex:index withObject:@""];
        [self updateSelectedPlayerImages];
    }
}

- (void)initPlayerViews {
    // make imageView round corner
    [Utilities makeImageViewRoundedCorner:self.player1Img :2];
    [Utilities makeImageViewRoundedCorner:self.player2Img :2];
    [Utilities makeImageViewRoundedCorner:self.player3Img :2];
    [Utilities makeImageViewRoundedCorner:self.player4Img :2];
    
    // calculate x pos of each image according to screen width
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    double screenWidth = screenBound.size.width;
    CGRect player1ImgBound = self.player1View.frame;
    
    CGRect player1Rect =  [self playerViewRect:screenWidth :1 :player1ImgBound];
    CGRect player2Rect =  [self playerViewRect:screenWidth :2 :player1ImgBound];
    CGRect player3Rect =  [self playerViewRect:screenWidth :3 :player1ImgBound];
    CGRect player4Rect =  [self playerViewRect:screenWidth :4 :player1ImgBound];
    
    // setFrame is not allowed to use in main thread with AutoLayout
    // so, we do it asyn
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.player1View setFrame:player1Rect];
        [self.player2View setFrame:player2Rect];
        [self.player3View setFrame:player3Rect];
        [self.player4View setFrame:player4Rect];
    });
}

- (void)updateSelectedPlayerImages {
    PlayerInfo* player1Info = [selectedPlayerArray objectAtIndex:0];
    PlayerInfo* player2Info = [selectedPlayerArray objectAtIndex:1];
    PlayerInfo* player3Info = [selectedPlayerArray objectAtIndex:2];
    PlayerInfo* player4Info = [selectedPlayerArray objectAtIndex:3];
    
    [self updateSelectedPlayerImageByInfo :self.player1Img :player1Info];
    [self updateSelectedPlayerImageByInfo :self.player2Img :player2Info];
    [self updateSelectedPlayerImageByInfo :self.player3Img :player3Info];
    [self updateSelectedPlayerImageByInfo :self.player4Img :player4Info];
}

- (void)updateSelectedPlayerImageByInfo:(UIImageView *)imgView :(PlayerInfo*)info {
    if (![info isEqual:@""]) {
        [imgView setImage:[Utilities loadImageFromFile:info.imgURL]];
    } else {
        [imgView setImage:DEFAULT_IMG];
    }
}

- (void)updatePlayerInfoArray {
    [[PlayerInfoManager sharedManager] updatePlayerInfoFromDB];
    playerInfoArray = [[PlayerInfoManager sharedManager] getAllPlayerInfoArray];
}

- (IBAction)lockOnClick:(id)sender {
    PlayerInfo* player1Info = [selectedPlayerArray objectAtIndex:0];
    PlayerInfo* player2Info = [selectedPlayerArray objectAtIndex:1];
    PlayerInfo* player3Info = [selectedPlayerArray objectAtIndex:2];
    PlayerInfo* player4Info = [selectedPlayerArray objectAtIndex:3];
    
    BOOL isSelected4Players = true;
    
    if ([player1Info isEqual:@""] ||[player2Info isEqual:@""] ||[player3Info isEqual:@""] ||[player4Info isEqual:@""] ) {
        isSelected4Players = false;
    }
    
    if (isSelected4Players) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"確定係呢4位玩家？"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Cancel",@"OK",nil];
        [alert setTag:1];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"請揀4位玩家"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)createPlayerOnClick:(id)sender {
    playerViewController = [[CreatePlayerViewController alloc] initWithNibName:@"CreatePlayerViewController" bundle:nil];
    
    playerViewController.delegate = self;
    
    void (^dismissAction)(void) = ^{
        LOG("CreatePlayerViewController dismiss");
        [self updatePlayerInfoArray];
        [self.tableView reloadData];
    };
    
    [self presentPopupViewController:playerViewController animationType:MJPopupViewAnimationFade dismissed:dismissAction];
}

- (void)cellOnLongPress:(UILongPressGestureRecognizer *)pGesture {
    if (pGesture.state == UIGestureRecognizerStateRecognized)
    {
    }
    if (pGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchPoint = [pGesture locationInView:self.tableView];
        NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
        LOG("end %d", (int)indexPath.row);
        
        if (indexPath != nil) {
            PlayerInfo* info = [playerInfoArray objectAtIndex:indexPath.row];
            if (info) {
                ShowPlayerInfoViewController* showPlayerInfoViewController =  [[ShowPlayerInfoViewController alloc] initWithNibName:@"ShowPlayerInfoViewController" bundle:nil];
                [showPlayerInfoViewController setInfo:info];
                [self presentViewController:showPlayerInfoViewController animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if ([alertView tag] == 1) {
        if (buttonIndex == 1) {
            // update SelectedPlayerInfoArray in PlayerInfoManager
            NSMutableArray* array = [[NSMutableArray alloc]initWithArray:selectedPlayerArray];
            [[PlayerInfoManager sharedManager] setSelectedPlayerInfoArray:array];
        }
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [playerInfoArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerListTableCell *cell = (PlayerListTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlayerListTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    PlayerInfo* info = [playerInfoArray objectAtIndex:indexPath.row];
    
    UIImage* image = nil;
    if (![info.imgURL isEqual: default_imgValue]) {
        image = [Utilities loadImageFromFile:info.imgURL];
    }
    [cell.playerImageView setImage: (image)? image:[UIImage imageNamed:default_imgURL2]];
    cell.nameLabel.text = info.name;
    cell.incomeLabel.text = [NSString stringWithFormat:@"%d", (int)(info.totalIncome - info.totalDeficit)];
    cell.winRateLabel.text = [NSString stringWithFormat:@"%d", (int)info.winRate];
    cell.invoteRoundLabel.text = [NSString stringWithFormat:@"%d", info.totalInvoteRound];
        
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[recordArray removeObjectAtIndex:indexPath.row - 1];
        
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage* img = info[UIImagePickerControllerOriginalImage];
    if (playerViewController) {
        [playerViewController.playerImageView setImage:img];
        playerViewController.isImageChosen = true;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - CreatePlayerDelegate
- (void)chooseImage {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)closePopup {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

#pragma mark - TableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!playerInfoArray || [playerInfoArray count] == 0) {
        return;
    }
    
    PlayerInfo* selectedPlayerInfo = [playerInfoArray objectAtIndex:indexPath.row];
    
    // check if Player is already selected
    if (selectedPlayerInfo.selectedIndex == -1) {
        // not selected, find the empty index
        for (int a = 0; a < 4; a++) {
            if ([[selectedPlayerArray objectAtIndex:a] isEqual: @""]) {
                selectedPlayerInfo.selectedIndex = a;
                [selectedPlayerArray replaceObjectAtIndex:a withObject:selectedPlayerInfo];
                [self updateSelectedPlayerImages];
                break;
            }
        }
    } else {
        // already selected
        NSLog(@"dllm selected");
    }
}

// calculate x pos of player 1,2,3,4
// autoLayout唔識根據Screen width平均分佈 buttons, 唯有自己計
- (CGRect) playerViewRect :(double)screenWidth :(int)index :(CGRect)bound {
    return CGRectMake(screenWidth/5*index-bound.size.width/2, bound.origin.y, bound.size.width, bound.size.height);
}

@end
