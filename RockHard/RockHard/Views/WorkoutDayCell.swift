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
    setUpConstraints()
    contentView.backgroundColor = .black
    contentView.layer.borderColor = #colorLiteral(red: 0.4109278509, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
           contentView.backgroundColor = #colorLiteral(red: 0.7996713519, green: 0.6718267202, blue: 0.3871548772, alpha: 1)
           contentView.layer.borderWidth = 2
           contentView.layer.cornerRadius = 15
           contentView.layer.masksToBounds = true
     }
     
     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    //MARK: - Lifecycle
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var nameOfWorkoutLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    private func setUpConstraints(){
        nameOfWorkoutLabelConstraint()
        dayOfWeekLabelConstraint()
    }
    //MARK: - Constraints
    
    private func dayOfWeekLabelConstraint (){
        contentView.addSubview(dayOfWeekLabel)
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            dayOfWeekLabel.bottomAnchor.constraint(equalTo: nameOfWorkoutLabel.topAnchor, constant: 0),
            dayOfWeekLabel.heightAnchor.constraint(equalToConstant: 30),
            dayOfWeekLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func nameOfWorkoutLabelConstraint(){
        contentView.addSubview(nameOfWorkoutLabel)
        nameOfWorkoutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameOfWorkoutLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            nameOfWorkoutLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            nameOfWorkoutLabel.heightAnchor.constraint(equalToConstant: 30),
            nameOfWorkoutLabel.widthAnchor.constraint(equalToConstant: 200)
        ])

    }}
