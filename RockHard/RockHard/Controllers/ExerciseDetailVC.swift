//
//  ExerciseDetailVC.swift
//  RockHard
//
//  Created by Eric Widjaja on 2/10/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit
class ExerciseDetailVC: UIViewController {
    //MARK: - Properties
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 500)
    
    
    //MARK: - Views
    lazy var detailScrollView: UIScrollView = {
        let dsv = UIScrollView(frame: .zero)
        dsv.backgroundColor = .lightGray
        dsv.contentSize = contentViewSize
        dsv.frame = view.bounds
        dsv.autoresizingMask = .flexibleHeight
        dsv.showsVerticalScrollIndicator = true
        dsv.bounces = true
        return dsv
    }()
    
    lazy var detailContainerView: UIView = {
        let detailCV = UIView()
        detailCV.backgroundColor = .orange
        //hint --> UIView.frame.size == UIScrollView.contentSize
        detailCV.frame.size = contentViewSize
        return detailCV
        
    }()
    
    lazy var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        //pass data from ExerciseVC
        label.text = "Hamstring Curl"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var muscleTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        //pass data from ExerciseVC
        label.text = "Legs"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var detailImage: UIImageView = {
        let imgView = UIImageView()
        //pass data from ExerciseVC
        imgView.image = UIImage(named: "LifeFitnessPro-LyingLegCurl")
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    lazy var bodyImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon")
        imgView.contentMode = .scaleToFill
        imgView.isUserInteractionEnabled = true
        imgView.isHighlighted = false
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        imgView.addGestureRecognizer(rightSwipe)
        
        return imgView
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
    
    var isShowingFront = true
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        switch isShowingFront {
        case true:
            bodyImage.image = UIImage(named: "bodyBack")
            isShowingFront = false
            print(isShowingFront)
            
        case false:
            bodyImage.image = UIImage(named: "bodyFront")
            isShowingFront = true
            print(isShowingFront)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDVCConstraints()
        view.backgroundColor = #colorLiteral(red: 0.9130935073, green: 0.7633427978, blue: 0, alpha: 0.5682791096)
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(detailContainerView)
    }
}

extension ExerciseDetailVC {
    private func setDVCConstraints() {
        [exerciseNameLabel, muscleTypeLabel, detailImage, exerciseDescription, arButton, bodyImage].forEach{detailContainerView.addSubview($0)}
        [exerciseNameLabel, muscleTypeLabel, detailImage, exerciseDescription, arButton, bodyImage].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setExerciseNameLabelConstraints()
        setMuscleTypeLabelConstraints()
        setDetailImageConstraints()
        setARButtonConstraints()
        setExerciseDescriptionConstraints()
        setBodyImageConstraints()
    }
    
    private func setExerciseNameLabelConstraints() {
        NSLayoutConstraint.activate([
            exerciseNameLabel.topAnchor.constraint(equalTo:
                detailContainerView.topAnchor, constant: 10),
            exerciseNameLabel.widthAnchor.constraint(equalToConstant: 400),
            exerciseNameLabel.centerXAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.centerXAnchor),
            exerciseNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setMuscleTypeLabelConstraints() {
        NSLayoutConstraint.activate([
            muscleTypeLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor),
            muscleTypeLabel.widthAnchor.constraint(equalToConstant: 200),
            muscleTypeLabel.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 30),
            muscleTypeLabel.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    private func setDetailImageConstraints() {
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: muscleTypeLabel.bottomAnchor, constant: 1),
            detailImage.centerXAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.centerXAnchor),
            detailImage.heightAnchor.constraint(equalToConstant: 350),
            detailImage.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor),
        ])
    }
    
    private func setARButtonConstraints() {
        NSLayoutConstraint.activate([
            arButton.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 25),
            arButton.centerXAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.centerXAnchor, constant: 130),
            arButton.heightAnchor.constraint(equalToConstant: 30),
            arButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    private func setExerciseDescriptionConstraints() {
        NSLayoutConstraint.activate([
            exerciseDescription.topAnchor.constraint(equalTo: arButton.bottomAnchor, constant: 25),
            exerciseDescription.widthAnchor.constraint(equalToConstant: 400),
            exerciseDescription.centerXAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.centerXAnchor),
            exerciseDescription.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    private func setBodyImageConstraints(){
        NSLayoutConstraint.activate([
            bodyImage.topAnchor.constraint(equalTo: exerciseDescription.bottomAnchor, constant: 0),
            bodyImage.widthAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.widthAnchor),
            bodyImage.heightAnchor.constraint(equalToConstant: 400),
            bodyImage.centerXAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
