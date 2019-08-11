//
//  WeatherViewCell.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

class WeatherViewCell: BaseTableViewCell<WeatherData> {
    
    let icon = UIImageView(image: UIImage(named: ImageNames.weatherIcon))
    let tempLabel = SimpleCustomLabel(fontName: FontNames.HelveticaNeue.regular, size: 28, textColor: Colors.customMediumGray, alignment: .right)
    let maxLabel  = SimpleCustomLabel(fontName: FontNames.HelveticaNeue.regular, size: 18, textColor: Colors.customMediumGray, alignment: .left)
    let minLabel  = SimpleCustomLabel(fontName: FontNames.HelveticaNeue.regular, size: 18, textColor: Colors.customMediumGray, alignment: .left)
    let descriptionLabel = SimpleCustomLabel(fontName: FontNames.HelveticaNeue.regular, size: 16, textColor: Colors.customMediumGray, alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        icon.contentMode = .scaleAspectFit
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        
        let tempStack = UIStackView(arrangedSubviews: [minLabel, maxLabel, descriptionLabel])
        tempStack.axis = .vertical
        tempStack.alignment = .leading
        tempStack.distribution = .fill
        tempStack.spacing = 5
        
        [icon, tempLabel, tempStack].forEach({ contentView.addSubview($0) })
        
        icon.anchor(leading: contentView.leadingAnchor,
                    padding: .init(top: 0, left: 20, bottom: 0, right: 0),
                    size: .init(width: 52, height: 52))
        
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        tempStack.anchor(top: contentView.topAnchor,
                         leading: icon.trailingAnchor,
                         bottom: contentView.bottomAnchor,
                         padding: .init(top: 20, left: 20, bottom: 20, right: 0))
        
        tempLabel.anchor(leading: tempStack.trailingAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        
        tempLabel.centerYAnchor.constraint(equalTo: tempStack.centerYAnchor).isActive = true
    }
}
