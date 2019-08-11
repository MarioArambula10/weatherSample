//
//  BaseTableView.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class BaseTableView<T: BaseTableViewCell<U>, U>: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    weak var baseTableViewCellDelegate: BaseTableViewCellDelegate?
    
    var cellId: String!
    var items: [U]!
    
    init(with frame: CGRect, style: UITableView.Style = .plain, cell: T.Type, items: [U], cellDelegate: BaseTableViewCellDelegate? = nil) {
        super.init(frame: frame, style: style)
        
        self.items = items
        self.cellId = String(describing: cell)
        self.baseTableViewCellDelegate = cellDelegate
        delegate = self
        dataSource = self
        register(cell, forCellReuseIdentifier: cellId)
        allowsSelection = true
        refreshControl = UIRefreshControl()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? T else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        cell.baseTableViewCellDelegate = baseTableViewCellDelegate
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? T else { return }
        cell.baseTableViewCellDelegate?.cellWasSelected(items[indexPath.row])
    }
}

