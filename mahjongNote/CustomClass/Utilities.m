//
//  Utilities.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 10/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "Utilities.h"
#import "PlayerInfoManager.h"
#import "RecordManager.h"
#import "DBManager.h"

@implementation Utilities

#define max_compress_count 3
#define max_prefer_data_length 100000

static NSMutableDictionary * s_fanTableDict;

+ (NSMutableDictionary*) getFanTableDict {
    if (!s_fanTableDict) {
        s_fanTableDict = [[NSMutableDictionary alloc] init];
    }
    
    [s_fanTableDict setValue:@"4" forKey:@"3"];
    [s_fanTableDict setValue:@"8" forKey:@"4"];
    [s_fanTableDict setValue:@"12" forKey:@"5"];
    [s_fanTableDict setValue:@"16" forKey:@"6"];
    [s_fanTableDict setValue:@"24" forKey:@"7"];
    [s_fanTableDict setValue:@"32" forKey:@"8"];
    [s_fanTableDict setValue:@"64" forKey:@"9"];
    [s_fanTableDict setValue:@"128" forKey:@"10"];
    
    return s_fanTableDict;
}

+ (void) setFanTableDict: (NSMutableDictionary*) fanTableDict {
    if (!s_fanTableDict) {
        s_fanTableDict = [[NSMutableDictionary alloc] init];
    }
    s_fanTableDict = [NSMutableDictionary dictionaryWithDictionary:fanTableDict];
}

+ (void)saveImageToFile:(UIImage *)image :(NSString *)imgName {
    if (!image || [imgName length] == 0) {
        LOG("saveImageToFile - invalid !");
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPath = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat: @"%@.jpg", imgName]];
    float compressionRatio = 1.0f;
    NSData* imgData = UIImageJPEGRepresentation(image, compressionRatio);
    LOG("init data length : %d", imgData.length);

    int retryCount = 0;
    while ([imgData length] > max_prefer_data_length && retryCount < max_compress_count) {
        compressionRatio=compressionRatio*0.5;
        imgData=UIImageJPEGRepresentation(image,compressionRatio);
        retryCount++;
        LOG("new data length : %d  retryCount : %d", imgData.length, retryCount);
    }
    
    [imgData writeToFile:fullPath atomically:YES];
}

+(UIImage *)loadImageFromFile:(NSString *)imgName {
    return [self loadImageFromFile:imgName :default_imgURL2];
}


+(UIImage *)loadImageFromFile:(NSString *)imgName :(NSString*)defaultImg {
    if ([imgName length] == 0) {
        LOG("loadImageFromFile - invalid !");
        return nil;
    }
    if ([imgName isEqualToString:default_imgValue]) {
        return [UIImage imageNamed:defaultImg];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPath = [documentsDirectory stringByAppendingPathComponent: imgName];
    UIImage* image = [UIImage imageWithContentsOfFile:fullPath];
    return image;
}

+ (void) makeImageViewRoundedCorner :(UIImageView*) imgView :(double)radius {
    if (!imgView) {return;}
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = radius;
}

//
// DB function
//
+ (void)updateTransactionsToDB:(NSMutableArray *)transactionArray :(BOOL)reverse {
    PlayerInfoManager* manager = [PlayerInfoManager sharedManager];
    
    for (Transaction* transaction in transactionArray) {
        if (transaction) {
            PlayerInfo* payeeInfo = [manager getPlayerInfoFromIndex:transaction.payeeIndex];
            PlayerInfo* payerInfo = [manager getPlayerInfoFromIndex:transaction.payerIndex];
            
            int payeeNewTotalIncome = 0;
            int payerNewTotalDeficit = 0;
            
            if (!reverse) {
                payeeNewTotalIncome = payeeInfo.totalIncome + transaction.amount;
                payerNewTotalDeficit = payerInfo.totalDeficit + transaction.amount;
            } else {
                payeeNewTotalIncome = payeeInfo.totalIncome - transaction.amount;
                payerNewTotalDeficit = payerInfo.totalDeficit - transaction.amount;
            }
            
            // Update PlayerInfo local reference
            payeeInfo.totalIncome = payeeNewTotalIncome;
            payerInfo.totalDeficit = payerNewTotalDeficit;
            
            // Update database PlayerInfo record
            NSString *query = [NSString stringWithFormat:@"Update PlayerInfo set totalIncome=%d where playerIndex=%d", payeeNewTotalIncome, payeeInfo.index];
            [[DBManager sharedManager] executeQuery:query];
            
            query = [NSString stringWithFormat:@"Update PlayerInfo set totalDeficit=%d where playerIndex=%d", payerNewTotalDeficit, payerInfo.index];
            [[DBManager sharedManager] executeQuery:query];
        }
    }
    
    // update Player Info after transaction
    [[PlayerInfoManager sharedManager] updatePlayerInfoFromDB];
}

@end
