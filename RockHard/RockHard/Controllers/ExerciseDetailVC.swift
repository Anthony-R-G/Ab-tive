//
//  ExerciseDetailVC.swift
//  RockHard
//
//  Created by Eric Widjaja on 2/10/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit
class ExerciseDetailVC: UIViewController {
    
    lazy var detailImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "hamstringCurl")
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    lazy var exerciseNameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "Hamstring Curl"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var arButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.9130935073, green: 0.7633427978, blue: 0, alpha: 0.5682791096)
        button.layer.cornerRadius = 12
        button.setTitle("AR View", for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 18)
        return button
    }()
    
    lazy var exerciseDescription: UITextView = {
        
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isEditable = false
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.textAlignment = .justified
        tv.adjustsFontForContentSizeCategory = true
        tv.text = "Lie on your stomach on the machine with your hands in front of you, slightly wider than your shoulders..."
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDVCConstraints()
        view.backgroundColor = #colorLiteral(red: 0.9130935073, green: 0.7633427978, blue: 0, alpha: 0.5682791096)
        
    }
}
extension ExerciseDetailVC {
    private func setDVCConstraints() {
        [detailImage, exerciseNameLabel, exerciseDescription, arButton].forEach{view.addSubview($0)}
        [detailImage, exerciseNameLabel, exerciseDescription, arButton].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setDetailImageConstraints()
        setARButtonConstraints()
        setExerciseNameLabelConstraints()
        setExerciseDescriptionConstraints()
    }
    
    private func setDetailImageConstraints() {
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            detailImage.heightAnchor.constraint(equalToConstant: 300),
            detailImage.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setARButtonConstraints() {
        NSLayoutConstraint.activate([
            arButton.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 10),
            arButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 130),
            arButton.heightAnchor.constraint(equalToConstant: 30),
            arButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setExerciseNameLabelConstraints() {
        NSLayoutConstraint.activate([
            exerciseNameLabel.topAnchor.constraint(equalTo:
                detailImage.bottomAnchor, constant: -25),
            exerciseNameLabel.widthAnchor.constraint(equalToConstant: 400),
            exerciseNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            exerciseNameLabel.heightAnchor.constraint(equalToConstant: 150)
         ])
    }
    private func setExerciseDescriptionConstraints() {
        NSLayoutConstraint.activate([
            exerciseDescription.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: -40),
            exerciseDescription.widthAnchor.constraint(equalToConstant: 400),
            exerciseDescription.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            exerciseDescription.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
