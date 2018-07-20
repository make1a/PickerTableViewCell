//
//  MKDatePickerCell.swift
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/19.
//  Copyright © 2018年 MAKE. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let cancelFirstResponse = #selector(MKDatePickerCell.resignFirstResponder)
    static let doneAction = #selector(MKDatePickerCell.done)
}

class MKDatePickerCell: UITableViewCell {
    
    
    /// 选择日期的回调
    var datePickerSelectBlock: ((_ date: Date) -> Void)?
    
    private static let inputViewRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 220)
    
    lazy var dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker.init(frame: inputViewRect)
        dataPicker.date = Date()
        dataPicker.datePickerMode = .date
        return dataPicker
    }()
    
    lazy var myInputView: UIView = {
        let view = UIView.init(frame: inputViewRect)
        view.backgroundColor = .white
        view.addSubview(self.dataPicker)
        return view
    }()
    
    override var inputView: UIView?{
        return myInputView
    }
    
    override var inputAccessoryView: UIView?{
        let view = UIToolbar.init(frame: .init(x: 0, y: 0, width: self.frame.size.width, height: 40))
        let cancelItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: .cancelFirstResponse)
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: .doneAction)
        view.setItems([cancelItem,spaceItem,doneItem], animated: false)
        return view
    }
    
    /// canBecomeFirstResponder
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    
    
    static let identifier = "kMKDatePickerCellIdentifier"
    
    static func dequeueReusable(WithTableView tableView:UITableView) -> MKDatePickerCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: MKDatePickerCell.identifier)
        if  let cell = reusableCell {
            return cell as! MKDatePickerCell
        }else{
            let cell = MKDatePickerCell.init(style: .default, reuseIdentifier: MKDatePickerCell.identifier)
            return cell
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        snpLayoutSubview()
    }
    
    
    ///MARK: action
    
    func done() {
        self.resignFirstResponder()
        datePickerSelectBlock?(dataPicker.date)
    }
    
    
    func snpLayoutSubview() {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
