//
//  PlayerInfoManager
//  mahjongNote
//
//  Created by Chan Hin Chun on 31/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <foundation/Foundation.h>
#import "PlayerInfo.h"

@interface PlayerInfoManager : NSObject {
}

@property (nonatomic, strong) NSMutableArray* playerInfoArray;
@property (nonatomic, strong) NSMutableArray* selectedPlayerInfoArray;

+(id)sharedManager;

- (NSMutableArray*) getAllPlayerInfoArray;
- (PlayerInfo*) getPlayerInfoFromIndex:(int) index;
- (PlayerInfo*) addPlayerToDB:(NSString*) name :(NSString*) imgURL;

// PlayerList到揀左既4條友
- (NSMutableArray*) getSelectedPlayerInfoArray;
- (NSString*) getSelectedPlayerNameAtIndex:(int) index;

// load data from db
- (BOOL) updatePlayerInfoFromDB;

@end