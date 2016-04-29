//
//  PlayerManager.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 31/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <foundation/Foundation.h>

@interface PlayerManager : NSObject {
//    NSString* player1Name;
//    NSString* player2Name;
//    NSString* player3Name;
//    NSString* player4Name;
}

@property (nonatomic) NSString* player1Name;
@property (nonatomic) NSString* player2Name;
@property (nonatomic) NSString* player3Name;
@property (nonatomic) NSString* player4Name;

- (NSArray*) getPlayerNameArray;

+ (id)sharedManager;

@end