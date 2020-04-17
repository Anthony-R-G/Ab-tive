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
//        loadPlans()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getWorkout()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    var currentUser = FirebaseAuthService.manager.currentUser
    //MARK: - Variables
    let weekDayNumbers = [
        "Sunday": 0,
        "Monday": 1,
        "Tuesday": 2,
        "Wednesday": 3,
        "Thursday": 4,
        "Friday": 5,
        "Saturday": 6,
    ]
    var workout: WorkoutPlan?
    var workoutCards: [WorkoutCard]?{
        didSet{
            if workoutCards != nil{
                workoutCards!.sort(by: { (weekDayNumbers[$0.workoutDay] ?? 7) < (weekDayNumbers[$1.workoutDay] ?? 7) })}
            workoutDayTableView.reloadData()
        }
    }
//    var plans = [WorkoutPlan]()
    
    //MARK: - UI Objects
    lazy var workoutDayTableView: UITableView = {
        let layout = UITableView()
        layout.register(WorkoutDayCell.self, forCellReuseIdentifier: "workoutCell")
        layout.backgroundColor = .clear
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
        button.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var createWorkoutButton: UIButton = {
        let button = UIButton()
          button.layer.cornerRadius = 12
        button.setTitle("Create\nWorkout", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(createWorkoutAction), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        button.tintColor = .white
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
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
        view.backgroundColor = #colorLiteral(red: 0.2446492016, green: 0.2107246518, blue: 0.193783313, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return view
    }()
    lazy var workoutTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(saveWorkout))
        button.isEnabled = false
        return button
    }()

    
    //MARK: - Objc Functions
    @objc private func createWorkoutAction(){
        let exerciseVC = ExerciseViewController()
        exerciseVC.state = .createWorkout
        exerciseVC.workoutPlan = workout
        self.navigationController?.pushViewController(exerciseVC, animated: true)
    }
    @objc private func saveWorkout(){
        let saveMenu = UIAlertController.init(title: "Save", message: "Pick an Option", preferredStyle: .alert)
        saveMenu.addTextField { (UITextField) in
            self.workout?.planName = UITextField.text!
        }
        let saveAlert = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (alert) in
            try? PlanPersistence.manager.saveImage(info: self.workout!)
        }
        saveMenu.addAction(saveAlert)
        present(saveMenu, animated: true)
      
    }
    
    //MARK: - Regular Functions
//    private func loadPlans(){
//        do {
//            plans = try PlanPersistence.manager.getPlans()
//        }catch{
//            print(error)
//        }
//        print(plans.count)
//    }
    private func setUpView(){
        view.backgroundColor = #colorLiteral(red: 0.2964071631, green: 0.2576555014, blue: 0.2364076376, alpha: 1)
        self.navigationItem.rightBarButtonItem = saveButton
    }
    private func getWorkout(){
        guard let userId = currentUser?.uid else {return}
        FirestoreService.manager.getWorkoutPlan(userId: userId) { (Result) in
            switch Result{
            case .failure(let error):
                print(error)
            case .success(let plan):
                self.workout = plan
                self.workoutCards = plan?.workoutCards
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
            workoutDayTableView.topAnchor.constraint(equalTo: workoutStackView.bottomAnchor, constant: 50),
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
            stackBackgroundView.heightAnchor.constraint(equalToConstant: 100)
        
        ])
    }
}
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutCards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = workoutDayTableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as? WorkoutDayCell else
        {return UITableViewCell()}
        if let data = workoutCards?[indexPath.row]{
            cell.backgroundColor = .clear
            cell.dayOfWeekLabel.text = data.workoutDay
            cell.nameOfWorkoutLabel.text = data.workoutName
        }
        return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutCard = workout?.workoutCards[indexPath.row]
        let exerciseVC = ExerciseViewController()
        exerciseVC.state = .viewWorkout
        exerciseVC.workoutCard = workoutCard
        exerciseVC.muscleTypeCV.isHidden = true
        self.navigationController?.pushViewController(exerciseVC, animated: true)
    }
    }
