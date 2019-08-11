//
//  BaseTableViewCell.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//


import UIKit

protocol BaseTableViewCellDelegate: class {
    
    func cellWasSelected<U>(_  cellItem: U)
}


class BaseTableViewCell<U>: UITableViewCell {
    
    var item: U!
    
    weak var baseTableViewCellDelegate: BaseTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
