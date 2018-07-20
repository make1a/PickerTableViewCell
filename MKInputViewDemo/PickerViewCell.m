//
//  TwoRowPickerCell.m
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/19.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import "PickerViewCell.h"

NSString *const kTwoRowPickerCellIdentifier = @"kTwoRowPickerCellIdentifier";

@interface PickerViewCell ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong, readwrite) UIView *inputView;

@property (nonatomic, strong, readwrite) UIToolbar *inputAccessoryView;
@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)NSArray * dataSource;
@property (nonatomic,strong)NSMutableArray * resultArray;
@end

@implementation PickerViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView withDataSource:(NSArray *)dataSource
{
    PickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTwoRowPickerCellIdentifier];
    if (cell == nil)
    {
        cell = [[PickerViewCell alloc]initWithDataSource:dataSource];
    }
    return cell;
}

- (instancetype)initWithDataSource:(NSArray *)array
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kTwoRowPickerCellIdentifier];
    if (self)
    {
        self.dataSource = array;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.text = @"pickerCell";
        self.detailTextLabel.text = @"🐖🐖";
        [self masLayoutSubview];
    }
    return self;
}

- (void)masLayoutSubview
{
    
}

- (void)setTitle:(NSString *)title{
    self.textLabel.text = title;
}
- (void)setDetailTitle:(NSString *)title{
    self.detailTextLabel.text = title;
}

#pragma  mark - action
- (void)done{
    
    [self resignFirstResponder];
    NSMutableArray *resultArray = @[].mutableCopy;
    for (int i = 0; i<self.dataSource.count; i++) {
        
        NSInteger row = [self.pickerView selectedRowInComponent:i];
        [resultArray addObject:self.dataSource[i][row]];
    }
    
    if (self.selectPickerViewBlock) {
        self.selectPickerViewBlock(resultArray);
    }
    
}



#pragma  mark - UIpickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataSource.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [self.dataSource[component] count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataSource[component][row];
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.resultArray replaceObjectAtIndex:component withObject:self.dataSource[component][row]];
    NSLog(@"self.resultArray==\n%@",self.resultArray);
    if (self.selectPickerViewBlock) {
        self.selectPickerViewBlock(self.resultArray);
    }
}


#pragma  mark - 懒加载
- (UIView *)inputView{
    if (!_inputView) {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 220)];
        _inputView.backgroundColor = [UIColor whiteColor];
        [_inputView addSubview:self.pickerView];
    }
    return _inputView;
}


- (UIToolbar *)inputAccessoryView{
    if (!_inputAccessoryView) {
        _inputAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,self.frame.size.width,40}];
//        _inputAccessoryView.barTintColor = [UIColor orangeColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:@selector(resignFirstResponder)];

        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_inputAccessoryView setItems:@[cancel,space,finish]];
    }
    return _inputAccessoryView;
}


- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:self.inputView.frame];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [_pickerView selectRow:0 inComponent:0 animated:0];
    }
    return _pickerView;
}

- (NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = @[].mutableCopy;
        for (NSArray *array in self.dataSource) {
            [_resultArray addObject:array.firstObject];
        }
    }
    return _resultArray;
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
@end
