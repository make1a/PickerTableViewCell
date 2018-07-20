//
//  SwiftDemoViewController.swift
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/20.
//  Copyright © 2018年 MAKE. All rights reserved.
//

import UIKit

class SwiftDemoViewController: UIViewController {
    
    
    let array1 = ["男","女","ladyBoy"]
    let array2 = [["a","b","c","d"],["1","2","3","4"],["🐔","🐶","🐖","🐂"]]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SwiftDemoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
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
}
