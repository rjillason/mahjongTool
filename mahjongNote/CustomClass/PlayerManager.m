//
//  PlayerManager.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 31/3/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "PlayerManager.h"

@implementation PlayerManager

//@synthesize player1Name;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static PlayerManager *sharedManager;
    
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.player1Name = @"a";
        self.player2Name = @"b";
        self.player3Name = @"c";
        self.player4Name = @"d";
    }
    return self;
}

- (NSArray*) getPlayerNameArray {
    NSArray* array = [[NSArray alloc]initWithObjects:self.player1Name, self.player2Name,
                      self.player3Name, self.player4Name, nil];
    return array;
}

@end
