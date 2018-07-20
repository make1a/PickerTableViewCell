//
//  ClickPickerCell.swift
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/19.
//  Copyright © 2018年 MAKE. All rights reserved.
//

import UIKit
fileprivate extension Selector {
    static let doneAction = #selector(MKClickPickerCell.done)
    static let cancelFirstResponse = #selector(MKClickPickerCell.resignFirstResponder)
}

class MKClickPickerCell: UITableViewCell {
    
    
    // MARK: lazy var
    
    var selectClickPickerBlock: ((_ index: Int,Any)->Void)?
    
    var dataSource: [String]?
    
    private lazy var myInputView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: self.height))
        view.backgroundColor = .groupTableViewBackground
        self.snpLayoutSubview(view)
        return view
    }()
    
    
    override var inputView: UIView?{ return myInputView }
    
    override var canBecomeFirstResponder: Bool { return true }
    
    
    //MARK: action
    @objc func done(sender: UIButton){
        self.resignFirstResponder()
        if let selectClickPickerBlock = self.selectClickPickerBlock {
            selectClickPickerBlock(sender.tag-100,dataSource![sender.tag-100])
        }
    }
    
    // MARK: 布局
    private func snpLayoutSubview(_ superView: UIView) {
        
        guard let datasource = self.dataSource else { return }
        var buttonTag: Int = 100
        for title in datasource {
            let button = UIButton.init(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.tag = buttonTag
            button.backgroundColor = .white
            let x = CGFloat(0)
            let y = CGFloat((48+1)*(buttonTag-100))
            let width = CGFloat(UIScreen.main.bounds.size.width)
            let height = CGFloat(48)
            button.frame = .init(x: x, y: y, width: width, height: height)
            button.addTarget(self, action: .doneAction, for: .touchUpInside)
            superView.addSubview(button)
            buttonTag += 1
        }
        
        /// 退出按钮
        let cancelButton = UIButton.init(type: .custom)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.setTitleColor(.gray, for: .normal)
        let x = CGFloat(0)
        let y = CGFloat(self.height-48)
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(48)
        cancelButton.frame = .init(x: x, y: y, width: width, height: height)
        cancelButton.addTarget(self, action: .cancelFirstResponse, for: .touchUpInside)
        superView.addSubview(cancelButton)
    }
    
    
    // MARK: init方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static let identifier = "kClickPickerCellIdentifier"
    
    static func dequeueReusable(WithTableView tableView:UITableView, dataSource: [String]) -> MKClickPickerCell {
        
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: MKClickPickerCell.identifier)
        
        if  let cell = reusableCell {
            return cell as! MKClickPickerCell
        }else{
            let cell = MKClickPickerCell.init(style: .value1, reuseIdentifier: MKClickPickerCell.identifier)
            cell.dataSource = dataSource
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "MKClickPickerCell"
            cell.detailTextLabel?.text = "🐖"
            return cell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
}

extension MKClickPickerCell {

    var height: Int {
        return ((self.dataSource?.count)! + 1) * 48 + 20
    }
    
}
