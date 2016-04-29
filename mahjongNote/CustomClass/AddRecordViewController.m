//
//  AddRecordViewController.m
//  mahjongNote
//
//  Created by Chan Hin Chun on 3/4/15.
//  Copyright (c) 2015 Chan Hin Chun. All rights reserved.
//

#import "AddRecordViewController.h"
#import "PlayerInfoManager.h"
#import "RecordManager.h"
#import "Utilities.h"
#import "MaxFanNumberManager.h"
#import "DBManager.h"

@interface AddRecordViewController ()

@end

static NSString *CellIdentifier = @"Cell";

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableArray* tempArray = [[ MaxFanNumberManager sharedManager] fanCostArray];
    
    fanCostArray = [[ MaxFanNumberManager sharedManager] fanCostArray];
    NSMutableArray* array = [[PlayerInfoManager sharedManager] getSelectedPlayerInfoArray];
    if (array) {
        array1 = [[NSMutableArray alloc]initWithArray:array];
    } else {
        array1 = [[NSMutableArray alloc]initWithObjects:@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    }
    array2 = [[NSMutableArray alloc]initWithObjects:@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    int tempFanNumber = 3;
    for (int a = 0; a < [fanCostArray count]; a++) {
        [array2 addObject: [NSString stringWithFormat:@"%i",tempFanNumber++]];
    }
    
    array3 = [[NSMutableArray alloc]initWithObjects:@"出銃",@"自摸",@"包自摸",nil];
    array4 = [NSMutableArray arrayWithArray: array1];
    [array4 removeObjectAtIndex:0];
    
    [self initCPPickerView:self.pickerView1 :self.pickerView1Container :EatWooPerson];
    [self initCPPickerView:self.pickerView2 :self.pickerView2Container :FanNumber];
    [self initCPPickerView:self.pickerView3 :self.pickerView3Container :EatWay];
    [self initCPPickerView:self.pickerView4 :self.pickerView4Container :SevenHead];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelOnClick:(id)sender {
    [self dismissViewControllerAnimated:true completion:NULL];
}

- (void) eatWooOnClick{
}

#pragma mark - CPPickerViewDataSource

- (NSInteger)numberOfItemsInPickerView:(CPPickerView *)pickerView
{
    switch ([pickerView tag]) {
        case EatWooPerson:
            return [array1 count];
            break;
        case FanNumber:
            return [array2 count];
            break;
        case EatWay:
            return [array3 count];
            break;
        case SevenHead:
            return [array4 count];
            break;
    }
    return 1;
}

- (NSString *)pickerView:(CPPickerView *)pickerView titleForItem:(NSInteger)item
{
    PlayerInfo* info;
    switch ([pickerView tag]) {
        case EatWooPerson:
            // array 1 is containing PlayerInfo @#!$@#$!@#$!#@$@#$%@$%
            info = [array1 objectAtIndex:item];
            return info.name;
        case FanNumber:
            return [array2 objectAtIndex:item];
        case EatWay:
            return [array3 objectAtIndex:item];
        case SevenHead:
            info = [array4 objectAtIndex:item];
            return info.name;
    }
    return [NSString stringWithFormat:@"%ld", item + 1];
}

#pragma mark - CPPickerViewDelegate

- (void)pickerView:(CPPickerView *)pickerView didSelectItem:(NSInteger)item
{
    switch ([pickerView tag]) {
        case EatWooPerson:
            array4 = [NSMutableArray arrayWithArray:array1];
            [array4 removeObjectAtIndex:item];
            
            //TODO: find a way to reloadData instead of remove and add
            [self.pickerView4 removeFromSuperview];
            [self initCPPickerView:self.pickerView4 :self.pickerView4Container :SevenHead];
            index1 = (int)item;
            break;
        case FanNumber:
            index2 = (int)item;
            break;
        case EatWay:
            index3 = (int)item;
            if (item == 2) {
                self.sevenHeadLabel.text = @"包自摸玩家";
            } else {
                self.sevenHeadLabel.text = @"出銃玩家";
            }
            break;
        case SevenHead:
            index4 = (int)item;
            break;
    }
}

- (void) initCPPickerView: (CPPickerView*) pickerView : (UIView*) container :(RecordType) type{
    CGSize tempSize = [container frame].size;
    CGRect tempRect = CGRectMake(0, 0, tempSize.width, tempSize.height) ;
    pickerView = [[CPPickerView alloc] initWithFrame:tempRect];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.allowSlowDeceleration = YES;
    [pickerView setTag:type];
    [pickerView reloadData];
    [container addSubview:pickerView];
}

- (IBAction)addRecordOnClick:(id)sender {
    // payee index
    PlayerInfo* payeeInfo = [array1 objectAtIndex:index1];
    int payeeIndex = index1;
    
    int fanNumber = [[array2 objectAtIndex:index2] intValue];
    int eatWay = index3;
    
    NSMutableDictionary* fanTableDict = [Utilities getFanTableDict];
    int normalCost = [[fanTableDict objectForKey:[NSString stringWithFormat:@"%d", fanNumber]] intValue];
    
    NSMutableArray* transactionArray = [[NSMutableArray alloc] init];
    RecordRow* row = [[RecordRow alloc] init];
    switch (eatWay) {
        case 0: // 出統
        {
            // find payer
            PlayerInfo* payerInfo = [array4 objectAtIndex:index4];
            int payerIndex = (int)[array1 indexOfObject:payerInfo];
            
            [row.scoreArray replaceObjectAtIndex:payeeIndex withObject:[NSString stringWithFormat:@"%i",normalCost]];
            [row.scoreArray replaceObjectAtIndex:payerIndex withObject:[NSString stringWithFormat:@"-%i",normalCost]];
            
            Transaction* transaction = [[Transaction alloc]initWithInfo:payeeInfo.index :payerInfo.index
                                                                       :fanNumber :normalCost];
            [transactionArray addObject: transaction];
            break;
        }
        case 1: // 自摸無人包
        {
            [row.scoreArray replaceObjectAtIndex:payeeIndex withObject:[NSString stringWithFormat:@"%i",(normalCost/2*3)]];
            for (int a = 0; a < [row.scoreArray count]; a++) {
                if (a != payeeIndex) {
                    [row.scoreArray replaceObjectAtIndex:a withObject:[NSString stringWithFormat:@"-%i",normalCost/2]];
                    
                    // find payer
                    PlayerInfo* payerInfo = [array1 objectAtIndex:a];
                    Transaction* transaction = [[Transaction alloc]initWithInfo:payeeInfo.index :payerInfo.index :fanNumber :(normalCost/2)];
                    [transactionArray addObject:transaction];
                }
            }
            break;
        }
        case 2: // 自摸有人包
        {
            // find payer
            PlayerInfo* payerInfo = [array4 objectAtIndex:index4];
            int payerIndex = (int)[array1 indexOfObject:payerInfo];
            
            [row.scoreArray replaceObjectAtIndex:payeeIndex withObject:[NSString stringWithFormat:@"%i",(normalCost/2*3)]];
            [row.scoreArray replaceObjectAtIndex:payerIndex withObject:[NSString stringWithFormat:@"-%i",(normalCost/2*3)]];
            
            Transaction* transaction = [[Transaction alloc]initWithInfo:payeeInfo.index :payerInfo.index
                                                                       :fanNumber :(normalCost/2*3)];
            [transactionArray addObject: transaction];
            break;
        }
        default:
            break;
    }
    // insert Transaction into db
    [Utilities updateTransactionsToDB:transactionArray :NO];
    
    [row.transactionArray addObjectsFromArray:transactionArray];
    [[[RecordManager sharedManager] recordArray] addObject:row];
    
    [self dismissViewControllerAnimated:true completion:NULL];
}

@end
