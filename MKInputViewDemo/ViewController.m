//
//  ViewController.m
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/18.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerCell.h"
#import "ClickPickerCell.h"
#import "PickerViewCell.h"


#import "MKInputViewDemo-Swift.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DatePickerCell *cell = [DatePickerCell dequeueReusableWithTableView:tableView];
        cell.selectDatePickerBlock = ^(NSDate *date) {
            NSLog(@"%@",date);
        };
        return cell;
    }else if (indexPath.row == 1){
        
        ClickPickerCell *cell = [ClickPickerCell dequeueReusableWithTableView:tableView dataSource:@[@"男",@"女",@"ladyBoy"]];
        __weak typeof (cell)weakCell = cell;
        cell.selectClickPickerBlock = ^(NSInteger index, NSString *str) {
            [weakCell setDetailTitle:str];
        };
        return cell;
        
    }else {
        
        PickerViewCell *cell = [PickerViewCell dequeueReusableWithTableView:tableView withDataSource:@[@[@"a",@"b",@"c",@"d"],@[@"1",@"2",@"3",@"4"],@[@"🐔",@"🐶",@"🐖",@"🐂"]]];

        __weak typeof (cell)weakCell = cell;
        cell.selectPickerViewBlock = ^(NSArray *selectArray){
            [weakCell setDetailTitle:[selectArray componentsJoinedByString:@""]];
        };
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.isFirstResponder) {
        [cell resignFirstResponder];
    }else{
    [cell becomeFirstResponder];
    }
}

@end
