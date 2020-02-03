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
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5672089041)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Variables
    weak var delegate: ButtonFunction?
    //MARK: - UI Objects
    lazy var cellImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    lazy var exerciseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.backgroundColor = .white
        label.textColor = .white
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()
    lazy var exerciseIsPicked: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(savedAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        return button
    }()
    
    //MARK: - Objc Functions
    @objc func savedAction (){
        delegate?.selectAction(tag: exerciseIsPicked.tag)
      }
    //MARK: - Regular Functions
    func setUpContentView(){
        setUpCellImage()
        setUpIsPicked()
         setUpExerciseTitleLabel()
    }
    //MARK: - Constraints
    private func setUpCellImage(){
        contentView.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cellImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setUpExerciseTitleLabel(){
        contentView.addSubview(exerciseTitleLabel)
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            exerciseTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            exerciseTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: exerciseIsPicked.leadingAnchor, constant: -10)
            
        ])
    }
    private func setUpIsPicked(){
        contentView.addSubview(exerciseIsPicked)
        exerciseIsPicked.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseIsPicked.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
             exerciseIsPicked.heightAnchor.constraint(equalToConstant: 50),
             exerciseIsPicked.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
             exerciseIsPicked.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
