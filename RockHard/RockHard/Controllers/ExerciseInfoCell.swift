//
//  ExerciseInfoCell.swift
//  RockHard
//
//  Created by albert coelho oliveira on 1/28/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class ExerciseInfoCell: UITableViewCell {

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
           setUpContentView()
        }
       
       required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var cellImage: UIImageView = {
           let view = UIImageView()
          return view
       }()
       lazy var exerciseTitleLabel: UILabel = {
          let label = UILabel()
           label.font = .boldSystemFont(ofSize: 24)
           label.backgroundColor = .white
          return label
       }()
       lazy var exerciseIsPicked: UIButton = {
           let view = UIButton()
           return view
       }()
    
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    func setUpContentView(){
           
       }
    //MARK: - Constraints


}
