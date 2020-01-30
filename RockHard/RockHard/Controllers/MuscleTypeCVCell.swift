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
            
              }
          
          required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
    lazy var muscleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    lazy var muscleName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    private func constrainImageView(){
           contentView.addSubview(postImage)
           postImage.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               postImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
               postImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
               postImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
               postImage.bottomAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 0)
           ])
       }
 
    
}
