//
//  Utilities.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 10/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define LOG(format, ...) NSLog(@format, ##__VA_ARGS__)

// PlayerInfo
#define default_name @"Player"
#define default_imgURL @"template_pic.jpg"
#define default_imgURL2 @"template_pic2.jpg"
#define default_imgValue @"_default"


@interface Utilities : NSObject {
    
}

+ (NSMutableDictionary*) getFanTableDict;
+ (void) setFanTableDict: (NSMutableDictionary*) fanTableDict;

+ (void) saveImageToFile:(UIImage*)image :(NSString*)imgName;
+ (UIImage*) loadImageFromFile:(NSString*)imgName;
+ (UIImage*) loadImageFromFile:(NSString*)imgName :(NSString*)defaultImg;

+ (void) makeImageViewRoundedCorner :(UIImageView*) imgView :(double)radius;

// DB related
+ (void) updateTransactionsToDB :(NSMutableArray*) transactionArray :(BOOL)reverse;

@end
