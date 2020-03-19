//
//  MKPickerViewCell.swift
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/20.
//  Copyright © 2018年 MAKE. All rights reserved.
//

import UIKit
fileprivate extension Selector {
    static let cancelAction = #selector(MKPickerViewCell.resignFirstResponder)
    static let doneAction = #selector(MKPickerViewCell.done)
}
class MKPickerViewCell: UITableViewCell {
    
        
    let rect = CGRect.init(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: 220)
    
    var dataSource: [[String]] = []
    
    ///初始化结果数组
    lazy var resultArray: [String] = {
        var resultArray:[String] = []
        for array in self.dataSource {
            let array = array as [String]
            if let string = array.first {
                resultArray.append(array.first!)
            }
        }
        return resultArray
    }()
    
    /// 结果回调
    var selectPickerViewBlock: ((_ reslutArray: [String] )->Void)?
    
    private lazy var myInputView: UIView = {
        let myInputView = UIView.init(frame: self.rect)
        myInputView.backgroundColor = .white
        myInputView.addSubview(self.pickerView)
        return myInputView
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView.init(frame: self.rect)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: false)
        return pickerView
    }()
    
    lazy var myInputAccessoryView: UIToolbar = {
        let myInputAccessoryView = UIToolbar.init(frame: .init(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: 40))
        let space = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: .cancelAction)
        let finish = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: .doneAction)
        myInputAccessoryView.setItems([cancel,space,finish], animated: false)
        return myInputAccessoryView
    }()
    
    override var inputView: UIView? { return myInputView }
    
    override var inputAccessoryView: UIView? { return myInputAccessoryView }
    
    override var canBecomeFirstResponder: Bool { return true }
    
    //MARK: init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifier = "kMKPickerViewCellIdentifier"
    
    static func dequeueReusable(WithTableView tableView:UITableView , dataSource: [[String]]) -> MKPickerViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: MKPickerViewCell.identifier)
        if  let cell = reusableCell {
            return cell as! MKPickerViewCell
        }else{
            let cell = MKPickerViewCell.init(style: .default, reuseIdentifier: MKPickerViewCell.identifier)
            cell.dataSource = dataSource
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "MKPickerViewCell"
            cell.detailTextLabel?.text = "🐲"
            return cell
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        snpLayoutSubview()
    }
    
    //MARK: action
    @objc func done()  {
        resignFirstResponder()
        if let blcok = selectPickerViewBlock {
            blcok(self.resultArray)
        }
    }
    
    //MARK:布局
    func snpLayoutSubview() {
        
    }
    
}

extension MKPickerViewCell: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataSource[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        resultArray[component] = dataSource[component][row]
        if let selectPickerViewBlock = selectPickerViewBlock {
            selectPickerViewBlock(self.resultArray)
        }
    }
}
