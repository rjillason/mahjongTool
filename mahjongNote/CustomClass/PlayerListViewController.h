//
//  PlayerListViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 30/12/2015.
//  Copyright © 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatePlayerViewController.h"
#import "PlayerInfoManager.h"


@interface PlayerListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CreatePlayerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate> {
    CreatePlayerViewController *playerViewController;
    NSMutableArray* playerInfoArray;

    NSMutableArray* selectedPlayerArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImagePickerController* imagePicker;
@property (strong, nonatomic) IBOutlet UIView *selectedPlayerView;
@property (strong, nonatomic) IBOutlet UIImageView *player1Img;
@property (strong, nonatomic) IBOutlet UIImageView *player2Img;
@property (strong, nonatomic) IBOutlet UIImageView *player3Img;
@property (strong, nonatomic) IBOutlet UIImageView *player4Img;
@property (strong, nonatomic) IBOutlet UIView *player1View;
@property (strong, nonatomic) IBOutlet UIView *player2View;
@property (strong, nonatomic) IBOutlet UIView *player3View;
@property (strong, nonatomic) IBOutlet UIView *player4View;


- (void) initPlayerViews;
- (void) updateSelectedPlayerImages;
- (void) updateSelectedPlayerImageByInfo :(UIImageView*) imgView :(PlayerInfo*) info;
- (void) updatePlayerInfoArray;
- (void) cellOnLongPress:(UILongPressGestureRecognizer*)pGesture;

- (IBAction)lockOnClick:(id)sender;
- (IBAction)createPlayerOnClick:(id)sender;
- (IBAction)playerButtonOnClick:(UIButton *)sender;

// calculate x pos of player 1,2,3,4
- (CGRect) playerViewRect :(double)screenWidth :(int)index :(CGRect)bound;
@end