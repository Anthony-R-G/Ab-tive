//
//  ExerciseViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
    }
    //MARK: - Variables
    var muscleType = ["Biceps", "Legs", "Triceps", "Shoulder", "Chest", "Back", "Cardio"]
    //MARK: - UI Objects
    lazy var exerciseTableView: UITableView = {
        let layout = UITableView()
        layout.register(ExerciseInfoCell.self, forCellReuseIdentifier: "exerciseCell")
        layout.backgroundColor = .clear
        layout.delegate = self
        layout.dataSource = self
        return layout
    }()
    //MARK: - Objc Functions
    
    //MARK: - Regular Functions
    lazy var muscleTypeCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(MuscleTypeCVCell.self, forCellWithReuseIdentifier: "muscleCell")
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    private func setUpView(){
        view.backgroundColor = .white
        let backgroundImage = UIImage(named: "backMuscle")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.5
        self.view.insertSubview(backgroundImageView, at: 0)
        
    }
    private func setUpConstraints(){
        constrainExerciseCV()
        constrainExerciseTableView()
        
    }
    //MARK: - Constraints
    
    private func constrainExerciseTableView(){
        view.addSubview(exerciseTableView)
        exerciseTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            exerciseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            exerciseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            exerciseTableView.topAnchor.constraint(equalTo: muscleTypeCV.bottomAnchor, constant: 0)
        ])
    }
    private func constrainExerciseCV(){
        view.addSubview(muscleTypeCV)
        muscleTypeCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            muscleTypeCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            muscleTypeCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            muscleTypeCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            muscleTypeCV.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }

}
extension ExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exerciseTableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseInfoCell
        cell?.exerciseTitleLabel.text = "ahhdddfjsdlkjflsjdlkfjskljflkds"
        cell?.cellImage.image = UIImage(named: "muscle")
        cell?.delegate = self
        
        cell?.exerciseIsPicked.tag = indexPath.row
        cell?.backgroundColor = .clear
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}
extension ExerciseViewController: ButtonFunction{
    func selectAction(tag: Int) {
        let selectedIndex = IndexPath(row: tag, section: 0)
        let selected = exerciseTableView.cellForRow(at: selectedIndex ) as! ExerciseInfoCell
        selected.exerciseIsPicked.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
}
extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return muscleType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = muscleTypeCV.dequeueReusableCell(withReuseIdentifier: "muscleCell", for: indexPath) as? MuscleTypeCVCell
        let data = muscleType[indexPath.row]
        cell?.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        cell?.backgroundColor = #colorLiteral(red: 0.6470412612, green: 0.7913685441, blue: 0.8968411088, alpha: 1)
        cell?.layer.borderWidth = 2
        cell?.layer.cornerRadius = 15
        cell?.muscleNameLabel.adjustsFontSizeToFitWidth = true
        cell?.layer.masksToBounds = true
        cell?.muscleNameLabel.text = data
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 40)
    }
}
