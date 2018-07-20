//
//  DataPickerCell.h
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/18.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kDataPickerCellIdentifier;
@interface DatePickerCell : UITableViewCell

@property (nonatomic,copy)void (^selectDatePickerBlock)(NSDate *date);


+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

@end
