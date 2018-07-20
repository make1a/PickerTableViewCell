//
//  TwoRowPickerCell.h
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/19.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kTwoRowPickerCellIdentifier;


@interface PickerViewCell : UITableViewCell


/**
 selectArray = [@"a",@"2",@"🐶"];
 */
@property (nonatomic,copy)void (^selectPickerViewBlock)(NSArray *selectArray);


/**

 @param dataSource @[@[@"a",@"b",@"c",@"d"],@[@"1",@"2",@"3",@"4"],@[@"🐔",@"🐶",@"🐖",@"🐂"]]
 */
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView withDataSource:(NSArray *)dataSource;


/**
 override  子类重写
 eg:
 
 - (void)setTitle:(NSString *)title{
    self.textLabel.text = @"aaa";
  }
 
 */
- (void)setTitle:(NSString *)title;
- (void)setDetailTitle:(NSString *)title;

@end
