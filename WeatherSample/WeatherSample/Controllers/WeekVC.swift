//
//  WeekVC.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class WeekVC: BaseVC {
    
    private let table = WeatherTableView(items: [])
    private var weeklyWeatherData: [WeatherData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeatherData()
        setupViews()
        
        view.showActivityIndicator()
        
        NetworkManager.group.notify(queue: .main) {
            
            self.view.hideActivityIndicator()
            self.table.items = self.weeklyWeatherData ?? []
            self.table.reloadData()
        }
    }
    
    
    private func fetchWeatherData() {
        
        let urlString = AppUrl.shared.getStockholmWeatherForcastUrl()
        
        NetworkManager.shared.performRequest(urlString: urlString, paidLoad: nil, groupedTask: true, completion: {
            
            (response: Result<JsonResponse<[WeatherData]>, GenericError>) in
            
            switch response {
                
            case .success(let resp):
                
                guard let data = resp.data else {
                    self.displayErrorAlert(err: AppError.Generic.unexpected.localizedDescription)
                    return
                }
                
                self.weeklyWeatherData = data
                
            case .failure(let err):
                self.displayErrorAlert(err: err.description)
            }
        })
    }
    

    private func displayErrorAlert(err: String?) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "Error", message: err ?? "Unxpected Error.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func setupViews() {
        
        [table].forEach({ view.addSubview($0) })
        
        table.anchorAllEdgesToSuperView()
    }
}
