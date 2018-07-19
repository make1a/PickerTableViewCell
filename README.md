# PickerTableViewCell
封装弹出选择试图的tableviewcell
![image](https://github.com/make1a/PickerTableViewCell/blob/master/aaa-2.gif)

### 选择日期DatePickerCell的使用：
```
 DatePickerCell *cell = [DatePickerCell dequeueReusableWithTableView:tableView];
 cell.selectDatePickerBlock = ^(NSDate *date) {
     NSLog(@"%@",date);
 };
```

### 弹出点击选择ClickPickerCell：
```
ClickPickerCell *cell = [ClickPickerCell dequeueReusableWithTableView:tableView dataSource:@[@"男",@"女",@"ladyBoy"]];
__weak typeof (cell)weakCell = cell;
cell.selectClickPickerBlock = ^(NSInteger index, NSString *str) {
    [weakCell setDetailTitle:str];
};
```

### 滑动选择PickerViewCell：
```
 PickerViewCell *cell = [PickerViewCell dequeueReusableWithTableView:tableView withDataSource:@[@[@"a",@"b",@"c",@"d"],@[@"1",@"2",@"3",@"4"],@[@"🐔",@"🐶",@"🐖",@"🐂"]]];
 __weak typeof (cell)weakCell = cell;
 cell.selectPickerViewBlock = ^(NSArray *selectArray){
     [weakCell setDetailTitle:[selectArray componentsJoinedByString:@""]];
 };
```

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [cell becomeFirstResponder];
}

```



