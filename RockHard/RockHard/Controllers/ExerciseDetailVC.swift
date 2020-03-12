//  ExerciseDetailVC.swift
//  RockHard
//  Created by Eric Widjaja on 2/10/20.
//  Copyright © 2020 Rockstars. All rights reserved.

import UIKit
class ExerciseDetailVC: UIViewController {
    
    //MARK: - Properties
    //    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 550)
    
    var detailScrollView = UIScrollView(frame: UIScreen.main.bounds)
    var detailContainerView = UIView()
    
    
    var exercise: Exercise?
    
    //MARK: - detail UIObjects
    //    lazy var detailScrollView: UIScrollView = {
    //        let dsv = UIScrollView(frame: .zero)
    //        dsv.backgroundColor = .clear
    //        //dsv.contentSize = contentViewSize
    //        dsv.frame = view.bounds
    //        dsv.autoresizingMask = .flexibleHeight
    //        dsv.showsVerticalScrollIndicator = true
    //        dsv.bounces = true
    //        return dsv
    //    }()
    
    //    lazy var detailContainerView: UIView = {
    //        let detailCV = UIView()
    //        detailCV.backgroundColor = .clear
    //        //hint --> UIView.frame.size == UIScrollView.contentSize
    //        detailCV.frame.size = contentViewSize
    //        return detailCV
    //    }()
    
    lazy var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        //pass data from ExerciseVC
        label.textColor = .white
        //        label.backgroundColor = .red
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    lazy var muscleTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        //pass data from ExerciseVC
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var exerciseInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        //pass data from ExerciseVC
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    lazy var detailImage: UIImageView = {
        let imgView = UIImageView()
        //pass data from ExerciseVC
        imgView.layer.cornerRadius = 16
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    lazy var bodyImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        imgView.contentMode = .scaleToFill
        return imgView }()
    
    lazy var arButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.3748272657, blue: 0, alpha: 0.7335455908)
        button.layer.cornerRadius = 12
        button.setTitle("AR View", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(segueTo3DView), for: .touchUpInside)
        
        return button
    }()
    
    lazy var exerciseDescription: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.isEditable = false
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.textAlignment = .justified
        tv.adjustsFontForContentSizeCategory = false
        return tv
    }()
    
    var testHeight = CGFloat()
    
    @objc private func segueTo3DView(){
        let arVC = ARModelViewController()
        self.navigationController?.pushViewController(arVC, animated: true)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewConstraints()
        setContainerViewConstraints()
        self.view.layoutIfNeeded()
        //        detailScrollView.updateContentView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailScrollView)
        
        detailScrollView.addSubview(detailContainerView)
        setDVCConstraints()
        setUpLabels()
        getExerciseImage()
        getMuscleImage()
        
        detailScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 600)
        
        //MARK: - Background & Blur Effect
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "feedvcdark")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func adjustTextViewHeight(arg: UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    //MARK: - Private Functions
    private func setUpLabels(){
        muscleTypeLabel.text = "Muscle type: \n    \(exercise?.type ?? "")"
        exerciseNameLabel.text = exercise?.name ?? ""
        
        let descriptions = exercise?.comments
        exerciseDescription.text = "Steps:  \n\n\(descriptions!.joined(separator: " \n\n" ))"
        
        let info = exercise?.exerciseInfo ?? ""
        exerciseInfoLabel.text = "\nDescription:\n" + "   \(info.description)"
        
    }
    private func getExerciseImage() {
        FirebaseStorageService.exerciseManager.getImage(url: exercise?.cellImage ?? "") { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                self.detailImage.image = image
            }
        }
    }
    
    private func getMuscleImage() {
        FirebaseStorageService.exerciseManager.getImage(url: exercise?.detailImage ?? "") {
            ( result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let frontImage):
                self.bodyImage.image = frontImage
            }
        }
    }
}

//MARK: - Extension
extension ExerciseDetailVC {
    
    private func setDVCConstraints() {
        [detailScrollView, detailContainerView, exerciseNameLabel, exerciseInfoLabel, detailImage ,muscleTypeLabel, arButton, exerciseDescription, bodyImage].forEach{$0.translatesAutoresizingMaskIntoConstraints = false }
        
        [exerciseNameLabel, exerciseInfoLabel, detailImage, muscleTypeLabel, arButton, exerciseDescription, bodyImage].forEach{detailContainerView.addSubview($0)}
        
        
        
        setExerciseNameLabelConstraints()
        setExerciseInfoLabel()
        setDetailImageConstraints()
        setMuscleTypeLabelConstraints()
        setARButtonConstraints()
        setExerciseDescriptionConstraints()
        setBodyImageConstraints()
    }
    
    private func setScrollViewConstraints() {
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setContainerViewConstraints(){
        NSLayoutConstraint.activate([
            detailContainerView.heightAnchor.constraint(equalTo: detailScrollView.heightAnchor),
            detailContainerView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor),
            //            detailContainerView.centerXAnchor.constraint(equalTo: detailScrollView.centerXAnchor),
            detailContainerView.centerYAnchor.constraint(equalTo: detailScrollView.centerYAnchor)
            
        ])
    }
    
    private func setExerciseNameLabelConstraints() {
        NSLayoutConstraint.activate([
            exerciseNameLabel.topAnchor.constraint(equalTo:
                detailContainerView.topAnchor, constant: 15),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 15),
            exerciseNameLabel.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor, multiplier: 0.9),
            exerciseNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setExerciseInfoLabel() {
        NSLayoutConstraint.activate([
            exerciseInfoLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor),
            exerciseInfoLabel.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 15),
            exerciseInfoLabel.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor, multiplier: 0.9)
            //            ,
            //            exerciseInfoLabel.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setDetailImageConstraints() {
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: exerciseInfoLabel.bottomAnchor, constant: 20),
            detailImage.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 15),
            detailImage.widthAnchor.constraint(equalTo: detailContainerView.widthAnchor, multiplier: 0.9)
            ,
            detailImage.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setMuscleTypeLabelConstraints() {
        NSLayoutConstraint.activate([
            muscleTypeLabel.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 10),
            muscleTypeLabel.widthAnchor.constraint(equalToConstant: 145),
            muscleTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            muscleTypeLabel.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 15)])
    }
    
    private func setARButtonConstraints() {
        NSLayoutConstraint.activate([
            arButton.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 10),
            arButton.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor, constant: -15),
            arButton.heightAnchor.constraint(equalToConstant: 40),
            arButton.widthAnchor.constraint(equalToConstant: 145)
        ])
    }
    
    private func setExerciseDescriptionConstraints() {
        NSLayoutConstraint.activate([
            exerciseDescription.topAnchor.constraint(equalTo: arButton.bottomAnchor, constant: 25),
            exerciseDescription.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 15),
            exerciseDescription.trailingAnchor.constraint(lessThanOrEqualTo: detailContainerView.trailingAnchor, constant: -15),
            //            exerciseDescription.centerXAnchor.constraint(equalTo: detailContainerView.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setBodyImageConstraints(){
        NSLayoutConstraint.activate([
            
            bodyImage.topAnchor.constraint(equalTo: exerciseDescription.bottomAnchor, constant: 15),
            bodyImage.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 15),
            bodyImage.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor, constant: -15),
            bodyImage.heightAnchor.constraint(equalToConstant: 280),
            //            bodyImage.centerXAnchor.constraint(equalTo: detailContainerView.centerXAnchor)
        ])
    }
}



extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last?.frame.maxY ?? contentSize.height
    }
}

