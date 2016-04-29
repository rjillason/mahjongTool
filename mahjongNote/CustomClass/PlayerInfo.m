//
//  PlayerInfo.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 1/1/2016.
//  Copyright © 2016 Chan Hin Chun. All rights reserved.
//

#import "PlayerInfo.h"
#import "Utilities.h"


@implementation PlayerInfo

- (id)init
{
    return [self initWithInfo:0 :default_name :default_imgValue :0 :0 :0 :0 :0 :0 :0 :0 :0 :0 :0 :0 :0 :0 :0 :0];
}

- (id)initWithInfo:(int)index :(NSString*)name :(NSString*)imgURL :(int)totalIncome :(int)totalDeficit
                  :(int)totalInvoteRound :(int)totalInvoteGame  :(double)winRate  :(double)avgEatFan
                  :(double)avgBeEatenFan :(double)avgActivation :(int)comboWinRound :(int)maxComboWinRound
                  :(int)maxComboLoseRound :(int)comboWinGame :(int)maxComboWinGame :(int)maxComboLoseGame
                  :(int) rival :(int) boss{
    self = [super init];
    if(self) {
        [self setSelectedIndex:-1];
        [self setIndex:index];
        [self setName:name];
        [self setImgURL:imgURL];
        [self setTotalIncome:totalIncome];
        [self setTotalDeficit:totalDeficit];
        [self setTotalInvoteRound:totalInvoteRound];
        [self setTotalInvoteGame:totalInvoteGame];
        [self setWinRate:winRate];
        [self setAvgEatFan:avgEatFan];
        [self setAvgBeEatenFan:avgBeEatenFan];
        [self setAvgActivation:avgActivation];
        [self setComboWinRound:comboWinRound];
        [self setMaxComboWinRound:maxComboWinRound];
        [self setMaxComboLoseRound:maxComboLoseRound];
        [self setComboWinGame:comboWinGame];
        [self setMaxComboWinGame:maxComboWinGame];
        [self setMaxComboLoseGame:maxComboLoseGame];
        [self setRival:rival];
        [self setRival:boss];
    }
    return self;
}

@end
