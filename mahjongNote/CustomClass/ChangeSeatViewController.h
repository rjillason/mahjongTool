//
//  ChangeSeatViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 30/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSeatViewController : UIViewController  {

}

@property (weak, nonatomic) IBOutlet UITextField *player1NameTxt;
@property (weak, nonatomic) IBOutlet UITextField *player2NameTxt;
@property (weak, nonatomic) IBOutlet UITextField *player3NameTxt;
@property (weak, nonatomic) IBOutlet UITextField *player4NameTxt;
@property (weak, nonatomic) IBOutlet UISwitch *changeSeatSwitch;

- (IBAction)confirmOnClick:(id)sender;


@end
