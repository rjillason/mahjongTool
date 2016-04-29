//
//  MaxFanNumberManager.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 4/7/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "MaxFanNumberManager.h"

@implementation MaxFanNumberManager

//@synthesize player1Name;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MaxFanNumberManager *sharedManager;
    
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.sharePenalty = false;
        self.fanNumber = 0;
        self.fanCostArray = [[NSMutableArray alloc]init];
    }
    return self;
}

//- (void) setFanCostArray:(NSMutableArray *)fanCostArray {
//    if (self.fanCostArray != nil) {
//        self.fanCostArray = nil;
//    }
//    self.fanCostArray = fanCostArray;
//}

@end
