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
        loadExerciseData()
    }
    //MARK: - Variables
    var counter = 0
    var muscleType = ["Biceps", "Legs", "Triceps", "Shoulder", "Chest", "Back", "Cardio"]
    var exercise = [Exercise](){
        didSet{
            exerciseTableView.reloadData()
        }
    }
    var filteredExercise = [Exercise]()
    //MARK: - UI Objects
    lazy var exerciseTableView: UITableView = {
        let layout = UITableView()
        layout.register(ExerciseInfoCell.self, forCellReuseIdentifier: "exerciseCell")
        layout.backgroundColor = .clear
        layout.delegate = self
        layout.dataSource = self
        return layout
    }()
    lazy var createWorkoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Create", for: .normal)
        button.isHidden = true
        return button
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
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        return cv
    }()

    private func loadExerciseData(){
        FirestoreService.manager.getExercises { (Result) in
            switch Result{
            case .failure(let error):
                print(error)
            case .success(let exercise):
                self.exercise = exercise
//                filteredExercise = exercise
            }
        }
    }
    private func setUpView(){
        view.backgroundColor = #colorLiteral(red: 0.2929434776, green: 0.360488832, blue: 0.4110850692, alpha: 0.7299604024)
    }
    private func setUpConstraints(){
        constrainExerciseCV()
        constrainExerciseTableView()
        constrainWorkoutButton()
    }
    //MARK: - Constraints
    
    private func constrainExerciseTableView(){
        view.addSubview(exerciseTableView)
        exerciseTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            exerciseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            exerciseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            exerciseTableView.topAnchor.constraint(equalTo: muscleTypeCV.bottomAnchor, constant: 15)
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
    private func constrainWorkoutButton(){
        view.addSubview(createWorkoutButton)
        createWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createWorkoutButton.bottomAnchor.constraint(equalTo: exerciseTableView.bottomAnchor, constant: -20),
            createWorkoutButton.leadingAnchor.constraint(equalTo: exerciseTableView.leadingAnchor, constant: 0),
            createWorkoutButton.trailingAnchor.constraint(equalTo: exerciseTableView.trailingAnchor, constant: 0),
            createWorkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
//MARK: - UITableView
extension ExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exerciseTableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseInfoCell
        let data = exercise[indexPath.row]
        cell?.exerciseTitleLabel.text = data.name
        cell?.cellImage.image = UIImage(named: "muscle")
        cell?.delegate = self
        cell?.exerciseIsPicked.tag = indexPath.row
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}

//MARK: - UICollectionViewCell
extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return muscleType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = muscleTypeCV.dequeueReusableCell(withReuseIdentifier: "muscleCell", for: indexPath) as? MuscleTypeCVCell
        let data = muscleType[indexPath.row]
       
        cell?.muscleNameLabel.text = data
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = muscleType[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: 40 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var filtered = muscleType[indexPath.row]
        filteredExercise = exercise
        var new = filteredExercise.map { (exercise) -> Exercise? in
            if exercise.type == filtered{
                return exercise
            }
            return nil
        }
  
        }
    }

//MARK: - Button Protocol
extension ExerciseViewController: ButtonFunction{
    func selectAction(tag: Int) {
        let selectedIndex = IndexPath(row: tag, section: 0)
        let selected = exerciseTableView.cellForRow(at: selectedIndex ) as! ExerciseInfoCell
        selected.exerciseIsPicked.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        counter += 1
        if counter >= 1{
            createWorkoutButton.isHidden = false
        }
    }
    
}
