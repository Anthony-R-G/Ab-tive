//
//  ExerciseInfoCell.swift
//  RockHard
//
//  Created by albert coelho oliveira on 1/28/20.
//  Copyright © 2020 Rockstars. All rights reserved.


import UIKit

class ExerciseInfoCell: UICollectionViewCell {
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Variables
    weak var delegate: ButtonFunction?
    var isPicked = true{
        didSet{
            if self.isPicked{
                exerciseIsPicked.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            }else {
                exerciseIsPicked.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        }}
    //MARK: - UI Objects
    lazy var cellImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var exerciseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6019103168)
        return label
    }()
    
    lazy var exerciseRepsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "3 Sets \n8 Reps"
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    lazy var exerciseIsPicked: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(savedAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    //MARK: - Objc Functions
    @objc func savedAction (){
        delegate?.selectAction(tag: exerciseIsPicked.tag)
    }
    //MARK: - Regular Functions
    func setUpContentView(){
        setUpCellImage()
        setUpExerciseTitleLabel()
        setUpExerciseRepsLabel()
        setUpIsPicked()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    //MARK: - Constraints
    private func setUpCellImage(){
        contentView.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    
    private func setUpExerciseTitleLabel(){
        contentView.addSubview(exerciseTitleLabel)
        contentView.bringSubviewToFront(exerciseTitleLabel)
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            exerciseTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            exerciseTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
            
        ])
    }
    private func setUpExerciseRepsLabel() {
        contentView.addSubview(exerciseRepsLabel)
        exerciseRepsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseRepsLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 18),
            exerciseRepsLabel.topAnchor.constraint(equalTo: exerciseTitleLabel.bottomAnchor, constant: -5),
            exerciseRepsLabel.heightAnchor.constraint(equalToConstant: 45),
            exerciseRepsLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setUpIsPicked(){
        contentView.addSubview(exerciseIsPicked)
        contentView.bringSubviewToFront(exerciseIsPicked)
        exerciseIsPicked.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseIsPicked.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            exerciseIsPicked.heightAnchor.constraint(equalToConstant: 50),
            exerciseIsPicked.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            exerciseIsPicked.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
