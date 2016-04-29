//
//  MaxFanNumberManager.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 4/7/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//


#import <foundation/Foundation.h>

@interface MaxFanNumberManager : NSObject {
}

+ (id)sharedManager;

@property bool sharePenalty;
@property int fanNumber;
@property (nonatomic, strong) NSMutableArray* fanCostArray; // Array with certain fanNumber and MaxMoney

//- (void) setFanCostArray:(NSMutableArray *)fanCostArray;

@end