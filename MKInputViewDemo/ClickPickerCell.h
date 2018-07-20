//
//  SexPickerCell.h
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/18.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kSexPickerCellIdentifier;

@interface ClickPickerCell : UITableViewCell


/**
  array[index]
 */
@property (nonatomic,copy) void (^selectClickPickerBlock)(NSInteger index , id str);


+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView dataSource:(NSArray *)array;




/**
  override  子类重写

 @param title title
 */
- (void)setTitle:(NSString *)title;
- (void)setDetailTitle:(NSString *)title;
@end
