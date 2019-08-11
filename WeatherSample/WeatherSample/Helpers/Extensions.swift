//
//  Extensions.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import UIKit

extension UIView {
    
    enum ViewBorders {
        case top, left, bottom, right
    }
    
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func anchorSize(to view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    
    
    func anchorAllEdgesToSuperView() {
        
        guard let superView = superview else { return }
        anchor(top: superView.topAnchor, leading: superView.leadingAnchor, bottom: superView.bottomAnchor, trailing: superView.trailingAnchor)
    }
    
    
    func centerInSuperView(padding: (top: CGFloat, left: CGFloat)? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        
        if let padding = padding {
            
            if padding.top != 0 {
                self.anchor(top: superView.topAnchor, padding: .init(top: padding.top, left: 0, bottom: 0, right: 0))
            }
            
            if padding.left != 0 {
                self.anchor(leading: superView.leadingAnchor, padding: .init(top: 0, left: padding.left, bottom: 0, right: 0))
            }
        }
    }
    
    
    func showActivityIndicator(activityColor: UIColor = .darkGray, backgroundColor: UIColor = .lightGray, bigIndicator: Bool = true) {
        
        DispatchQueue.main.async {
            
            self.isUserInteractionEnabled = false
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = backgroundColor
            backgroundView.tag = ViewTags.activityIndicator.rawValue
            
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = bigIndicator ? .whiteLarge : .white
            activityIndicator.color = activityColor
            activityIndicator.startAnimating()
            
            [backgroundView].forEach({ self.addSubview($0) })
            
            backgroundView.centerInSuperView()
            backgroundView.anchor(size: .init(width: 80, height: 80))
            backgroundView.layer.cornerRadius = 5
            backgroundView.clipsToBounds = true
            
            [activityIndicator].forEach({ backgroundView.addSubview($0) })
            
            activityIndicator.anchorSize(to: backgroundView)
            activityIndicator.centerInSuperView()
            
            self.bringSubviewToFront(activityIndicator)
        }
    }
    
    
    func hideActivityIndicator() {
        if let activityIndicator = viewWithTag(ViewTags.activityIndicator.rawValue){
            activityIndicator.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}


extension Date {
    
    func toString(withFormat format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    
    convenience init(netHex:Int) {
        
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
