//
//  BaseVC.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    lazy var safeArea: UILayoutGuide = view.safeAreaLayoutGuide
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    private func setupViews() {
        
        let backgroundView = UIImageView(image: UIImage(named: ImageNames.background))
        backgroundView.contentMode = .scaleAspectFit
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        [backgroundView].forEach({ view.addSubview($0) })
        
        [blurEffectView].forEach({ backgroundView.addSubview($0) })
        
        backgroundView.anchorAllEdgesToSuperView()
        blurEffectView.anchorAllEdgesToSuperView()
    }
}
