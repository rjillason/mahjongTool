//
//  CreatePlayerViewController.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 2/1/2016.
//  Copyright © 2016 Chan Hin Chun. All rights reserved.
//

#import "CreatePlayerViewController.h"
#import "Utilities.h"
#import "PlayerInfoManager.h"

@interface CreatePlayerViewController ()

@end

@implementation CreatePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isImageChosen = false;
    
    [Utilities makeImageViewRoundedCorner:self.playerImageView :5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPlayer:(id)sender {
    NSString* playerName = [[self playerNameTextField] text];

    if (![self checkPlayerNameValid:playerName]) {
        return;
    }
    NSString* imgURL = default_imgURL2;
    if (self.isImageChosen && self.playerImageView.image != nil) {
        // save the photo to file
        [Utilities saveImageToFile :self.playerImageView.image :playerName];
        imgURL = [NSString stringWithFormat:@"%@.jpg", playerName];
    }
    [[PlayerInfoManager sharedManager] addPlayerToDB:playerName :imgURL];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"成功創建啦!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.delegate closePopup];
}

- (void)imageViewOnClick:(id)sender{
    
    [self.delegate chooseImage];
}

- (BOOL) checkPlayerNameValid:(NSString*) name {
    if (name != nil && [name length] != 0) {
        LOG("Player Name %@ valid", name);
        return YES;
    }
    LOG("Player Name is empty");
    return NO;
}

@end
