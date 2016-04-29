//
//  PlayerInfoManager
//  mahjongNote
//
//  Created by Chan Hin Chun on 31/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "PlayerInfoManager.h"
#import "DBManager.h"
#import "Utilities.h"

@implementation PlayerInfoManager

//@synthesize player1Name;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static PlayerInfoManager *sharedManager;
    
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.playerInfoArray = [[NSMutableArray alloc]init];
        self.selectedPlayerInfoArray = [[NSMutableArray alloc]initWithObjects:
                                        [[PlayerInfo alloc]init], [[PlayerInfo alloc]init],
                                        [[PlayerInfo alloc]init], [[PlayerInfo alloc]init], nil];
    }
    return self;
}

- (NSMutableArray*) getAllPlayerInfoArray {
    if ([self.playerInfoArray count] == 0) {
        return nil;
    } else {
        return self.playerInfoArray;
    }
}

- (PlayerInfo *)getPlayerInfoFromIndex:(int) index {
    PlayerInfo* result = nil;
    for (int a = 0; a < [self.playerInfoArray count]; a++) {
        PlayerInfo* info = [self.playerInfoArray objectAtIndex:a];
        if (info.index == index) {
            result = info;
            break;
        }
    }
    return result;
}

- (PlayerInfo *)addPlayerToDB:(NSString *)name :(NSString *)imgURL {

    NSString *query = [NSString stringWithFormat:@"insert into PlayerInfo (playername, imgURL) values ('%@', '%@')", name, imgURL];
    [[DBManager sharedManager] executeQuery:query];
    
    PlayerInfo* newPlayerInfo = [[PlayerInfo alloc] init];
    newPlayerInfo.name = name;
    newPlayerInfo.imgURL = imgURL;
    
    return newPlayerInfo;
}

- (BOOL) updatePlayerInfoFromDB {
    // remove all object before reload data from DB
    if ([self.playerInfoArray count] > 0) {
        [self.playerInfoArray removeAllObjects];
    }
    // Form the query.
    NSString *query = @"select * from PlayerInfo";
    NSArray* tempResult = [[DBManager sharedManager] loadDataFromDB:query];
    
    for (int a = 0; a < [tempResult count]; a++ ){
        NSArray* tempInfoArray = [tempResult objectAtIndex:a];

        int index = [[tempInfoArray objectAtIndex:0] intValue];
        NSString* name = [tempInfoArray objectAtIndex:1];
        NSString* imgURL = [tempInfoArray objectAtIndex:2];
        double income = [[tempInfoArray objectAtIndex:3] doubleValue];
        double deficit = [[tempInfoArray objectAtIndex:4] doubleValue];
        int invokeRound = [[tempInfoArray objectAtIndex:5] intValue];
        int invokeGame = [[tempInfoArray objectAtIndex:6] intValue];
        double winRate = [[tempInfoArray objectAtIndex:7] doubleValue];
        double avgEatFan = [[tempInfoArray objectAtIndex:8] doubleValue];
        double avgBeEatenFan = [[tempInfoArray objectAtIndex:9] doubleValue];
        double activation = [[tempInfoArray objectAtIndex:10] doubleValue];
        int comboWinRound = [[tempInfoArray objectAtIndex:11] intValue];
        int maxComboWinRound = [[tempInfoArray objectAtIndex:12] intValue];
        int maxComboLoseRound = [[tempInfoArray objectAtIndex:13] intValue];
        int comboWinGame = [[tempInfoArray objectAtIndex:14] intValue];
        int maxComboWinGame = [[tempInfoArray objectAtIndex:15] intValue];
        int maxComboLoseGame = [[tempInfoArray objectAtIndex:16] intValue];
        int rival = [[tempInfoArray objectAtIndex:17] intValue];
        int boss = [[tempInfoArray objectAtIndex:18] intValue];
        
        PlayerInfo* playerInfo = [[PlayerInfo alloc] initWithInfo:index :name :imgURL :income :deficit :invokeRound :invokeGame :winRate :avgEatFan :avgBeEatenFan :activation :comboWinRound :maxComboWinRound :maxComboLoseRound :comboWinGame :maxComboWinGame :maxComboLoseGame :rival :boss];
        
        [self.playerInfoArray addObject:playerInfo];
    }
    
    return false;
}

- (NSMutableArray *)getSelectedPlayerInfoArray {
    return [self selectedPlayerInfoArray];
}

- (NSString *)getSelectedPlayerNameAtIndex:(int)index {
    if (index >= [[self selectedPlayerInfoArray] count]) {
        NSLog(@"getSelectedPlayerNameAtIndex - index too large");
        return @"";
    }
    PlayerInfo* info = [[self selectedPlayerInfoArray] objectAtIndex:index];
    if (info) {
        return info.name;
    }
    return @"";
}

@end
