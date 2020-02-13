//
//  workoutDayCell.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/6/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class WorkoutDayCell: UITableViewCell {

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         backgroundColor = #colorLiteral(red: 0.7996713519, green: 0.6718267202, blue: 0.3871548772, alpha: 1)
    setUpConstraints()
     }
     
     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    //MARK: - Lifecycle
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var nameOfWorkoutLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    private func setUpConstraints(){
        dayOfWeekLabelConstraint()
        nameOfWorkoutLabelConstraint()
    }
    //MARK: - Constraints
    
    private func dayOfWeekLabelConstraint (){
        contentView.addSubview(dayOfWeekLabel)
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayOfWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            dayOfWeekLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            dayOfWeekLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func nameOfWorkoutLabelConstraint(){
        contentView.addSubview(nameOfWorkoutLabel)
        nameOfWorkoutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameOfWorkoutLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor, constant: 0),
            nameOfWorkoutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameOfWorkoutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            nameOfWorkoutLabel.heightAnchor.constraint(equalToConstant: 30)
        
        
        ])

    }}
