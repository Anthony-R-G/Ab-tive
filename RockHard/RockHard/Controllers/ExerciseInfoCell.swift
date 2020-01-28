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
    weak var delegate: ButtonFunction?
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
        let button = UIButton()
        button.addTarget(self, action: #selector(savedAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage.init(named: "checkmark.circle"), for: .normal)
        return button
    }()
    
    //MARK: - Objc Functions
    @objc func savedAction (){
        delegate?.selectAction(sender: exerciseIsPicked.tag)
      }
    //MARK: - Regular Functions
    func setUpContentView(){
        setUpCellImage()
        setUpExerciseTitleLabel()
        setUpIsPicked()
    }
    //MARK: - Constraints
    private func setUpCellImage(){
        contentView.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
            cellImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 50)
        ])
    }
    
    private func setUpExerciseTitleLabel(){
        contentView.addSubview(exerciseTitleLabel)
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 15),
            exerciseTitleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.20),
            exerciseTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            exerciseTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 50)
            
        ])
    }
    private func setUpIsPicked(){
        contentView.addSubview(exerciseIsPicked)
        exerciseIsPicked.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseIsPicked.leadingAnchor.constraint(equalTo: exerciseTitleLabel.trailingAnchor, constant: 15),
            exerciseIsPicked.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.20),
            exerciseIsPicked.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            exerciseIsPicked.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 50)
            
        ])
    }
    
}
