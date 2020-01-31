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
        label.textAlignment = .left
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
            muscleNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            muscleNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            muscleNameLabel.heightAnchor.constraint(equalToConstant: 50),
            muscleNameLabel.widthAnchor.constraint(equalToConstant: 100),
            muscleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            muscleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15)
        ])
    }
}
