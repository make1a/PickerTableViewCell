# PickerTableViewCell
封装弹出选择试图的tableviewcell OC和Swift两个版本
![image](https://github.com/make1a/PickerTableViewCell/blob/master/a5677f33c60e4242e2b8fe44389ee895.GIF)

## OC:
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

## Swift:

```
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = MKDatePickerCell.dequeueReusable(WithTableView: tableView)
            cell.datePickerSelectBlock = {
               print($0)
            }
            return cell
        }else if indexPath.row == 1 {

            let cell = MKClickPickerCell.dequeueReusable(WithTableView: tableView, dataSource: array1)
            cell.selectClickPickerBlock = {
               print("index = \($0),str = \($1)")
            }
            return cell
            
        }else{
            let cell = MKPickerViewCell.dequeueReusable(WithTableView: tableView, dataSource: array2)
            cell.selectPickerViewBlock = { array in
              print(array.joined())  
            }
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celll = tableView.cellForRow(at: indexPath)
        guard let cell = celll else { return }
        if cell.isFirstResponder {
            cell.resignFirstResponder()
        }else{
            cell.becomeFirstResponder()
        }
    }

```

