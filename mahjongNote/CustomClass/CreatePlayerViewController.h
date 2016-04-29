//
//  CreatePlayerViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 2/1/2016.
//  Copyright © 2016 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreatePlayerViewControllerDelegate;

@interface CreatePlayerViewController : UIViewController{
    UIButton* blockTouchButton;
}

@property (strong, nonatomic) IBOutlet UITextField* playerNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView* playerImageView;
@property (weak, nonatomic) id<CreatePlayerViewControllerDelegate> delegate;
@property BOOL isImageChosen;

- (IBAction)createPlayer:(id)sender;
- (IBAction)imageViewOnClick:(id)sender;

- (BOOL) checkPlayerNameValid:(NSString*) name;

@end

// If we call ImagePicker directly in MJPopup,
// MJPopup will become full screen instead of a popup
// So now delegate to PlayerListVC to open ImagePicker
@protocol CreatePlayerViewControllerDelegate <NSObject>

- (void)chooseImage;
- (void)closePopup;

@end