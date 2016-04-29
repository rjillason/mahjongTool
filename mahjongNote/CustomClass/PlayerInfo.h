//
//  PlayerInfo.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 1/1/2016.
//  Copyright © 2016 Chan Hin Chun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PlayerInfo : NSObject

// db value
@property int index;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* imgURL; // Profile image name
@property double totalIncome;      // 總收入
@property double totalDeficit;     // 總虧損
@property int totalInvoteRound; // 總參與圈數
@property int totalInvoteGame;  // 總參與場數
@property double winRate;       // 勝率
@property double avgEatFan;     // 平均食糊番數
@property double avgBeEatenFan; // 平均出銃番數 (唔計輸自摸)
@property double avgActivation;    // 平均活躍度 (有份贏/輸)
@property int comboWinRound;    // 目前連勝圈數
@property int maxComboWinRound; // 最高連勝圈數
@property int maxComboLoseRound; // 最高連敗圈數
@property int comboWinGame;     // 目前連勝場數
@property int maxComboWinGame;  // 最高連勝場數
@property int maxComboLoseGame;  // 最高連敗場數

@property int rival; // 宿敵
@property int boss;  // 米飯班主

// other
@property int selectedIndex;

- (id)initWithInfo:(int)index :(NSString*)name :(NSString*)imgURL :(int)totalIncome :(int)totalDeficit
                  :(int)totalInvoteRound :(int)totalInvoteGame  :(double)winRate  :(double)avgEatFan
                  :(double)avgBeEatenFan :(double)avgActivation :(int)comboWinRound :(int)maxComboWinRound
                  :(int)maxComboLoseRound :(int)comboWinGame :(int)maxComboWinGame :(int)maxComboLoseGame
                  :(int) rival :(int) boss;

@end
