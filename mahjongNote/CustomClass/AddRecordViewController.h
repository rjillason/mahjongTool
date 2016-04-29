//
//  AddRecordViewController.h
//  mahjongNote
//
//  Created by Chan Hin Chun on 3/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPPickerViewCell.h"

typedef enum RecordType : NSUInteger {
    EatWooPerson,
    FanNumber,
    EatWay,
    SevenHead
} RecordType;

@interface AddRecordViewController : UIViewController <CPPickerViewDelegate, CPPickerViewDataSource> {
    NSMutableArray* array1; // PlayerInfo
    NSMutableArray* array2;
    NSMutableArray* array3;
    NSMutableArray* array4; // PlayerInfo
    int index1;
    int index2;
    int index3;
    int index4;
    
    NSMutableArray* fanCostArray;
}

@property (strong, nonatomic) CPPickerView* pickerView1;
@property (strong, nonatomic) CPPickerView* pickerView2;
@property (strong, nonatomic) CPPickerView* pickerView3;
@property (strong, nonatomic) CPPickerView* pickerView4;
@property (strong, nonatomic) IBOutlet UIView *pickerView1Container;
@property (strong, nonatomic) IBOutlet UIView *pickerView2Container;
@property (strong, nonatomic) IBOutlet UIView *pickerView3Container;
@property (strong, nonatomic) IBOutlet UIView *pickerView4Container;
@property (strong, nonatomic) IBOutlet UILabel *sevenHeadLabel;

- (IBAction)cancelOnClick:(id)sender;
- (void)eatWooOnClick;
- (void)initCPPickerView:(CPPickerView*) pickerView :(UIView*) container :(RecordType) type;
- (IBAction)addRecordOnClick:(id)sender;

@end
