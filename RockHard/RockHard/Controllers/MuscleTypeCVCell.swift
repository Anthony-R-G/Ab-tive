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
        contentView.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.6470412612, green: 0.7913685441, blue: 0.8968411088, alpha: 1)
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
    private func constrainMuscleLabel(){
        contentView.addSubview(muscleNameLabel)
        muscleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            muscleNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            muscleNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            muscleNameLabel.heightAnchor.constraint(equalToConstant: 50),
            muscleNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
        ])
    }
}
