//
//  RecordManager.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 3/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "RecordManager.h"
#import "DBManager.h"
#import "PlayerInfoManager.h"

@implementation RecordManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static RecordManager *sharedManager;
    
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.recordArray = [[NSMutableArray alloc]init];
    }
    return self;
}

@end

@implementation RecordRow

- (id)init
{
    self = [super init];
    if (self)
    {
        self.scoreArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0", nil];
        self.transactionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

@implementation Transaction

- (id)init
{
    return [self initWithInfo:0 :0 :0 :0];
}

- (id)initWithInfo:(int)payeeIndex :(int)payerIndex :(int)fanNumber :(int)amount {
    self.payeeIndex = payeeIndex;
    self.payerIndex = payerIndex;
    self.fanNumber = fanNumber;
    self.amount = amount;
    return self;
}

@end