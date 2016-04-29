//
//  RecordManager.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 3/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <foundation/Foundation.h>

@interface RecordManager : NSObject {
    
}

@property (nonatomic, strong) NSMutableArray* recordArray;

+ (id)sharedManager;

@end

@interface RecordRow : NSObject {
}

@property (nonatomic, strong) NSMutableArray* scoreArray;
@property (nonatomic, strong) NSMutableArray* transactionArray;

- (id) init;
@end

@interface Transaction : NSObject {
}

@property int payerIndex;        //比錢人
@property int payeeIndex;        //收錢人
@property int fanNumber;    //番數
@property int amount;       //交易金額

- (id)initWithInfo:(int) payeeIndex :(int)payerIndex :(int)fanNumber :(int)amount;

@end