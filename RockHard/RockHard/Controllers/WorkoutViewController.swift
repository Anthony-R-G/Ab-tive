//
//  WorkoutViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        getWorkout()
    }
    //MARK: - Variables
    var workout: WorkoutPlan?{
        didSet{
            workoutDayTableView.reloadData()
        }
    }
    
    //MARK: - UI Objects
    lazy var workoutDayTableView: UITableView = {
        let layout = UITableView()
        layout.register(WorkoutDayCell.self, forCellReuseIdentifier: "workoutCell")
        layout.backgroundColor = .lightGray
        layout.delegate = self
        layout.dataSource = self
        return layout
    }()
    
    lazy var savedWorkoutButton: UIButton = {
    let button = UIButton()
        button.setTitle("Saved\nWorkouts", for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
          button.backgroundColor = #colorLiteral(red: 0.7273315191, green: 0.7141847014, blue: 0.6132777929, alpha: 1)
        return button
    }()
    
    lazy var createWorkoutButton: UIButton = {
        let button = UIButton()
          button.layer.cornerRadius = 12
        button.setTitle("Create\nWorkout", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(createWorkoutAction), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.7273315191, green: 0.7141847014, blue: 0.6132777929, alpha: 1)
        return button
    }()
    lazy var workoutStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [savedWorkoutButton ,createWorkoutButton])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        return stack
    }()
    lazy var stackBackgroundView:  UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        return view
    }()
    lazy var workoutTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    
    //MARK: - Objc Functions
    @objc private func createWorkoutAction(){
        let exerciseVC = ExerciseViewController()
        exerciseVC.state = .add
        self.navigationController?.pushViewController(exerciseVC, animated: true)
    }
    //MARK: - Regular Functions
    private func setUpView(){
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    private func getWorkout(){
        FirestoreService.manager.getWorkoutPlan { (Result) in
            switch Result{
            case .failure(let error):
                print(error)
            case .success(let plan):
                self.workout = plan.first
                print(plan)
            }
        }
    }
    private func setUpConstraints(){
        constrainStackView()

        constrainWorkoutTableView()
        constrainStackBackgroundView()

    }
    //MARK: - Constraints
    private func constrainStackView(){
        view.addSubview(workoutStackView)
        workoutStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            workoutStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            workoutStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func constrainWorkoutTableView(){
        view.addSubview(workoutDayTableView)
        workoutDayTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutDayTableView.topAnchor.constraint(equalTo: workoutStackView.bottomAnchor, constant: 150),
            workoutDayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            workoutDayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            workoutDayTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func constrainStackBackgroundView(){
         view.addSubview(stackBackgroundView)
        view.insertSubview(workoutStackView, aboveSubview: stackBackgroundView)
        stackBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackBackgroundView.heightAnchor.constraint(equalToConstant: 200)
        
        ])
    }
}
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = workoutDayTableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as? WorkoutDayCell else
        {return UITableViewCell()}
        if let data = workout?.workoutCards[indexPath.row]{
            cell.dayOfWeekLabel.text = data.workoutDay
            cell.nameOfWorkoutLabel.text = data.workoutName
            
        }
        return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
