//
//  DataPickerCell.m
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/18.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import "DatePickerCell.h"

NSString *const kDataPickerCellIdentifier = @"kDataPickerCellIdentifier";

@interface DatePickerCell ()

@property (nonatomic, strong, readwrite) UIView *inputView;

@property (nonatomic, strong, readwrite) UIToolbar *inputAccessoryView;

@property (nonatomic,strong)UIDatePicker * datePicker;

@end

@implementation DatePickerCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    DatePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:kDataPickerCellIdentifier];
    if (cell == nil)
    {
        cell = [[DatePickerCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kDataPickerCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.text = @"生日";
        self.detailTextLabel.text = @"保密";
        [self masLayoutSubview];
    }
    return self;
}

- (void)masLayoutSubview
{
}

#pragma  mark - action
- (void)done{
    [self resignFirstResponder];
    if (self.selectDatePickerBlock) {
        self.selectDatePickerBlock(self.datePicker.date);
    }
}

#pragma  mark - dataPicker



#pragma  mark - 懒加载
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        
        _datePicker = [[UIDatePicker alloc]initWithFrame:self.inputView.frame];
        [_datePicker setDate:[NSDate date]];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    
    }
    return _datePicker;
}

- (UIView *)inputView{
    if (!_inputView) {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 220)];
        _inputView.backgroundColor = [UIColor whiteColor];
        [_inputView addSubview:self.datePicker];
    }
    return _inputView;
}


- (UIToolbar *)inputAccessoryView{
    if (!_inputAccessoryView) {
        _inputAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,self.frame.size.width,40}];
//        _inputAccessoryView.barTintColor = [UIColor orangeColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_inputAccessoryView setItems:@[space,space,finish]];
    }
    return _inputAccessoryView;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

@end
