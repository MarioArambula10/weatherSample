//
//  WeatherTableView.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class WeatherTableView: BaseTableView<WeatherCell, WeatherData> {
    
    
    convenience init(items: [WeatherData]) {
        self.init(with: .zero, cell: WeatherCell.self, items: items)
        
    }
    
    
    override init(with frame: CGRect, style: UITableView.Style = .grouped, cell: WeatherCell.Type, items: [WeatherData], cellDelegate: BaseTableViewCellDelegate? = nil) {
        super.init(with: frame, style: style, cell: cell, items: items, cellDelegate: cellDelegate)
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 80
        
        backgroundColor = .clear
        separatorColor = Colors.customLightGray
        
        refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl?.tintColor = Colors.customMediumGray
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        let title = SimpleCustomLabel(fontName: FontNames.HelveticaNeue.regular, size: 32, textColor: Colors.customBlue, alignment: .center)
        title.text = "Hello Stockholm!"
        view.addSubview(title)
        title.centerInSuperView()
        
        return view
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 100
    }
    
    
    @objc private func refreshTable() {
        
        let urlString = AppUrl.shared.getStockholmWeatherForcastUrl()
        
        NetworkManager.shared.performRequest(urlString: urlString, paidLoad: nil, groupedTask: true, completion: {
            
            (response: Result<JsonResponse<[WeatherData]>, GenericError>) in
            
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
            
            switch response {
                
            case .success(let resp):
                
                guard let data = resp.data else { return }
                
                DispatchQueue.main.async {
                    self.items = data
                    self.reloadData()
                }
                
            case .failure:
                break
            }
        })
    }
}
