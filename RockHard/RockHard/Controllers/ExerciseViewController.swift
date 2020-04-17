

import UIKit
import Kingfisher

class ExerciseViewController: UIViewController {
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        loadExerciseData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        switch state {
        case .viewWorkout, .createWorkout:
            print("hey")
        default:
            self.navigationController?.navigationBar.isHidden = true

        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
    //MARK: - Variables
    enum currentState {
        case createWorkout
        case viewWorkout
        case exerciseView
    }
    var currentUser = FirebaseAuthService.manager.currentUser
    var weekDay = "Monday"
    var state = currentState.exerciseView
    var workoutPlan: WorkoutPlan?
    var workoutCard: WorkoutCard?
    var pickedExercises = [Exercise](){
        didSet{
            if self.pickedExercises.isEmpty {
                createWorkoutButton.isHidden = true
            }else {
                createWorkoutButton.isHidden = false
            }
        }
    }
    var exercises = [Exercise]()
    var filteredExercise = [Exercise](){
        didSet{
            exerciseCV.reloadData()
        }
    }
    var weekDays = ["Monday","Tuesday","Wednesday", "Thursday", "Friday","Saturday","Sunday"]
    var muscleType = ["Biceps", "Legs", "Triceps", "Shoulder", "Chest", "Back", "Cardio"]
    var selectedMuscleTypes = [String]()
    
    //MARK: - Objc Functions
    @objc private func presetnWorkoutView (){
        view.backgroundColor = #colorLiteral(red: 0.2632220984, green: 0.2616633773, blue: 0.2644240856, alpha: 0.8305329623)
        createWorkoutView.isHidden = false
        exerciseCV.isHidden = true
        createWorkoutButton.backgroundColor = .gray
    }
    @objc private func saveWorkout(){
        guard let userID = currentUser else {return}
        if workoutPlan != nil{
            
            let workout = WorkoutCard(workoutDay: weekDay, workoutName: workoutNameTextField.text!, exercises: pickedExercises)
            workoutPlan?.workoutCards.append(workout)
            FirestoreService.manager.updateWorkoutPlan(userID: userID.uid, workoutPlan: workoutPlan!) { (result) in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(()):
                    print("")
                }
            }
        }else{
            let workout = WorkoutCard(workoutDay: weekDay, workoutName: workoutNameTextField.text!, exercises: pickedExercises)
            let workoutPlan = WorkoutPlan(planName: "", creatorID: userID.uid , workoutCards: [workout])
         
            FirestoreService.manager.createWorkoutPlan(userID: userID.uid, plan: workoutPlan) { (Resut) in
                switch Resut{
                case .failure(let error):
                    print(error)
                case .success(()):
                    print("yes")
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Regular Functions
    private func filterExercise () -> [Exercise]{
        var filtered = exercises.filter { (exercise) -> Bool in
            selectedMuscleTypes.contains(exercise.type)
        }
        if filtered.count == 0{
            filtered = exercises
            return filtered
        }
        return filtered
    }
    
    private func loadExerciseData(){
        FirestoreService.manager.getExercises { (Result) in
            switch Result{
            case .failure(let error):
                print(error)
            case .success(let exercise):
                self.exercises = exercise
                self.filteredExercise = exercise
                
            }
        }
    }
    private func setUpView(){
        view.backgroundColor = #colorLiteral(red: 0.2964071631, green: 0.2576555014, blue: 0.2364076376, alpha: 1)
        weekDayPicker.delegate = self
        weekDayPicker.dataSource = self
    }
    
    
    private func setUpConstraints(){
        constrainExercisesTitleLabel()
        constrainExerciseCV()
        constrainExerciseTableView()
        constrainWorkoutButton()
        constrainCreateWorkoutView()
        constrainworkoutNameLabel()
        constrainPickerView()
        constrainsaveWorkoutButton()
    }
    //MARK: - ExerciseView UI Objects
    lazy var exerciseCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(ExerciseInfoCell.self, forCellWithReuseIdentifier: "exerciseCell")
        cv.backgroundColor = .clear
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var createWorkoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Create", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(presetnWorkoutView), for: .touchUpInside)
        return button
    }()
    
    lazy var muscleTypeCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(MuscleTypeCVCell.self, forCellWithReuseIdentifier: "muscleCell")
        cv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1788848459)
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        return cv
    }()
    lazy var exerciseTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercises"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        
        return label
    }()
    
    lazy var createWorkoutView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 20
        view.isHidden = true
        
        return view
    }()
    
    //MARK: - CreateWorkoutView UI Objects
    
    lazy var workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the name of this workout"
        return label
    }()
    lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the day of this workout"
        return label
    }()
    lazy var workoutNameTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    lazy var weekDayPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    lazy var saveWorkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Workout", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.addTarget(self, action: #selector(saveWorkout), for: .touchUpInside)
        return button
    }()
    
    //MARK: - CreateWorkoutView Constraints
    private func constrainCreateWorkoutView(){
        view.addSubview(createWorkoutView)
        createWorkoutView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createWorkoutView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            createWorkoutView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            createWorkoutView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
            createWorkoutView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
        ])}
    
    private func constrainworkoutNameLabel(){
        let stackView = UIStackView(arrangedSubviews: [workoutNameLabel, workoutNameTextField,weekDayLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        createWorkoutView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: createWorkoutView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: createWorkoutView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: createWorkoutView.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    private func constrainPickerView(){
        createWorkoutView.addSubview(weekDayPicker)
        weekDayPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekDayPicker.topAnchor.constraint(equalTo: weekDayLabel.bottomAnchor, constant: 0),
            weekDayPicker.leadingAnchor.constraint(equalTo: createWorkoutView.leadingAnchor, constant: 0),
            weekDayPicker.trailingAnchor.constraint(equalTo: createWorkoutView.trailingAnchor, constant: 0),
            weekDayPicker.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    private func constrainsaveWorkoutButton(){
        createWorkoutView.addSubview(saveWorkoutButton)
        saveWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveWorkoutButton.topAnchor.constraint(equalTo: weekDayPicker.bottomAnchor, constant: 20),
            saveWorkoutButton.leadingAnchor.constraint(equalTo: createWorkoutView.leadingAnchor, constant: 0),
            saveWorkoutButton.trailingAnchor.constraint(equalTo: createWorkoutView.trailingAnchor, constant: 0),
            saveWorkoutButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    //MARK: - ExerciseView Constraints
    private func constrainExercisesTitleLabel(){
        view.addSubview(exerciseTitleLabel)
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exerciseTitleLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    private func constrainExerciseTableView(){
        view.addSubview(exerciseCV)
        exerciseCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            exerciseCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            exerciseCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            exerciseCV.topAnchor.constraint(equalTo: muscleTypeCV.bottomAnchor, constant: 10)
        ])
    }
    private func constrainExerciseCV(){
        view.addSubview(muscleTypeCV)
        muscleTypeCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            muscleTypeCV.topAnchor.constraint(equalTo: exerciseTitleLabel.bottomAnchor, constant: 5),
            muscleTypeCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            muscleTypeCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            muscleTypeCV.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    private func constrainWorkoutButton(){
        view.addSubview(createWorkoutButton)
        createWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createWorkoutButton.bottomAnchor.constraint(equalTo: exerciseCV.bottomAnchor, constant: -20),
            createWorkoutButton.leadingAnchor.constraint(equalTo: exerciseCV.leadingAnchor, constant: 0),
            createWorkoutButton.trailingAnchor.constraint(equalTo: exerciseCV.trailingAnchor, constant: 0),
            createWorkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - UICollectionViewCell
extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == muscleTypeCV{
            return muscleType.count
        }else {
            guard let exerciseCount = workoutCard?.exercises.count else {
                return filteredExercise.count
            }
            return exerciseCount
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == muscleTypeCV{
            guard let cell = muscleTypeCV.dequeueReusableCell(withReuseIdentifier: "muscleCell", for: indexPath) as? MuscleTypeCVCell else {return UICollectionViewCell()}
            let data = muscleType[indexPath.row]
            cell.muscleNameLabel.text = data
            return cell
        }else {
            guard let cell = exerciseCV.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as? ExerciseInfoCell else {return UICollectionViewCell()}
            var data: Exercise?
            switch state{
            case .viewWorkout:
                data = (workoutCard?.exercises[indexPath.row])!
                cell.exerciseRepsLabel.isHidden = false
            case .exerciseView:
                data = filteredExercise[indexPath.row]
            case .createWorkout:
                cell.exerciseIsPicked.isHidden = false
                data = filteredExercise[indexPath.row]
            }
            if pickedExercises.contains(where: { (Exercise) -> Bool in
                return Exercise.name == data?.name
            }){
                cell.isPicked = true
            }else {
                cell.isPicked = false
            }
            cell.exerciseTitleLabel.text = data?.name
            if let url =  URL(string: data?.cellImage ?? "") {
                cell.cellImage.kf.setImage(with: url)}
            cell.delegate = self
            cell.exerciseIsPicked.tag = indexPath.row
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == muscleTypeCV{
            let label = UILabel(frame: CGRect.zero)
            label.text = muscleType[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: 40 )} else {
            return CGSize(width: view.frame.width - 10, height: 200)
            
        }}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == muscleTypeCV{
            let selected = muscleTypeCV.cellForItem(at: indexPath) as! MuscleTypeCVCell
            selected.contentView.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            if selectedMuscleTypes.contains(muscleType[indexPath.row]){
                selectedMuscleTypes = selectedMuscleTypes.filter { (type) -> Bool in
                    return type != muscleType[indexPath.row]
                    
                }
                selected.contentView.backgroundColor = #colorLiteral(red: 0.4827054739, green: 0.08537527174, blue: 0.231207341, alpha: 1)
            }else{
                selectedMuscleTypes.append(muscleType[indexPath.row])
            }
            filteredExercise = filterExercise()
        }else {
            let exerciseDetail = ExerciseDetailVC()
            exerciseDetail.exercise = filteredExercise[indexPath.row]
            self.navigationController?.pushViewController(exerciseDetail, animated: true)
        }
    }
}

//MARK: - Button Protocol
extension ExerciseViewController: ButtonFunction{
    func selectAction(tag: Int) {
        let selectedIndex = IndexPath(row: tag, section: 0)
        let selected = exerciseCV.cellForItem(at: selectedIndex ) as! ExerciseInfoCell
        if selected.isPicked{
            pickedExercises.removeAll { (Exercise) -> Bool in
                return Exercise.name == filteredExercise[tag].name
            }
            selected.isPicked = false
        }else{
            pickedExercises.append(filteredExercise[tag])
            selected.isPicked = true
        }
        
    }
}

//MARK: - UI Picker Delegates
extension ExerciseViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekDays.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let day =  weekDays[row]
        return day
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weekDay = weekDays[row]
    }
}


