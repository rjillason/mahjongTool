//
//  ChangeSeatViewController.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 30/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "ChangeSeatViewController.h"
#import "PlayerManager.h"

@interface ChangeSeatViewController ()

@end

@implementation ChangeSeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmOnClick:(id)sender {
    if ([_player1NameTxt.text isEqual: @""] || [_player2NameTxt.text isEqual: @""] ||
        [_player3NameTxt.text isEqual: @""] || [_player4NameTxt.text isEqual: @""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"請輸入所有玩家名字" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [[PlayerManager sharedManager] setPlayer1Name:_player1NameTxt.text];
    [[PlayerManager sharedManager] setPlayer2Name:_player2NameTxt.text];
    [[PlayerManager sharedManager] setPlayer3Name:_player3NameTxt.text];
    [[PlayerManager sharedManager] setPlayer4Name:_player4NameTxt.text];
}

@end
