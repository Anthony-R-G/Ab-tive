//
//  MuscleTypeCVCell.swift
//  RockHard
//
//  Created by albert coelho oliveira on 1/30/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class MuscleTypeCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
              super.init(frame: frame)
            setUpConstraints()
              }
          
          required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
   
    lazy var muscleNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    private func setUpConstraints(){
       constrainMuscleLabel()
    }
    private func constrainMuscleLabel(){
        contentView.addSubview(muscleNameLabel)
        muscleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            muscleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            muscleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            muscleNameLabel.heightAnchor.constraint(equalToConstant: 50),
            muscleNameLabel.centerYAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>, constant: <#T##CGFloat#>)
        ])
    }
}
