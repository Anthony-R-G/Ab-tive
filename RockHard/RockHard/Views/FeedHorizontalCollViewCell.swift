//  FeedCollectionViewCell.swift
//  RockHard
//
//  Created by Eric Widjaja on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class FeedHorizontalCollViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let label = UILabel()
    func setupLabel() {
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.init(name: "Rockwell", size: 20)
        label.textColor = .white
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        setupLabel()
        self.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
      
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
