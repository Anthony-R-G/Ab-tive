

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
    enum currentState: String{
        case add
        case view
    }
    var state = currentState.view
    var arrayOfbuttonStates = [Bool]()
    var pickedExercises = [Exercise](){
        didSet{
            if self.pickedExercises.isEmpty {
                createWorkoutButton.isHidden = true
            }else {
                createWorkoutButton.isHidden = false
            }
        }
    }
    var weekDays = ["Monday","Tuesday","Wednesday", "Thursday", "Friday","Saturday","Sunday"]
    var muscleType = ["Biceps", "Legs", "Triceps", "Shoulder", "Chest", "Back", "Cardio"]
    var exercise = [Exercise](){
        didSet{
            arrayOfbuttonStates = Array(repeating: true, count: self.exercise.count)
            exerciseTableView.reloadData()
        }
    }
    
    //MARK: - Objc Functions
    @objc private func presetnWorkoutView (){
        view.backgroundColor = #colorLiteral(red: 0.2632220984, green: 0.2616633773, blue: 0.2644240856, alpha: 0.8305329623)
        createWorkoutView.isHidden = false
        exerciseTableView.isHidden = true
        createWorkoutButton.backgroundColor = .gray
    }
    @objc private func saveWorkout(){
        let workout = WorkoutCard(workoutDay: "Monday", workoutName: workoutNameTextField.text!, exercises: pickedExercises)
        let workoutPlan = WorkoutPlan(planName: "kj", creatorID: "12231", workoutCards: [workout])
        FirestoreService.manager.createWorkoutPlan(plan: workoutPlan) { (Resut) in
            switch Resut{
            case .failure(let error):
                print(error)
            case .success(()):
                print("yes")
            }
        }
    }
    
    //MARK: - Regular Functions
    private func loadExerciseData(){
        FirestoreService.manager.getExercises { (Result) in
            switch Result{
            case .failure(let error):
                print(error)
            case .success(let exercise):
                self.exercise = exercise
            }
        }
    }
    private func setUpView(){
        view.backgroundColor = #colorLiteral(red: 0.2929434776, green: 0.360488832, blue: 0.4110850692, alpha: 0.7299604024)
        weekDayPicker.delegate = self
        weekDayPicker.dataSource = self
        
    }
    private func setUpConstraints(){
        constrainExerciseCV()
        constrainExerciseTableView()
        constrainWorkoutButton()
        constrainCreateWorkoutView()
        constrainworkoutNameLabel()
        constrainPickerView()
        constrainsaveWorkoutButton()
    }
    //MARK: - ExerciseView UI Objects
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
        button.addTarget(self, action: #selector(presetnWorkoutView), for: .touchUpInside)
        return button
    }()
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
        stackView.spacing = 10
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
        guard let cell = exerciseTableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseInfoCell else {return UITableViewCell()}
        let data = exercise[indexPath.row]
        cell.exerciseTitleLabel.text = data.name
        cell.cellImage.image = UIImage(named: "muscle")
        cell.delegate = self
        cell.exerciseIsPicked.tag = indexPath.row
        if state.rawValue == "add"{
            cell.exerciseIsPicked.isHidden = false
        }
        if arrayOfbuttonStates[indexPath.row] {
            cell.isPicked = false
        }else {
            cell.isPicked = true
        }
        return cell
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
}

//MARK: - Button Protocol
extension ExerciseViewController: ButtonFunction{
    func selectAction(tag: Int) {
        let selectedIndex = IndexPath(row: tag, section: 0)
        let selected = exerciseTableView.cellForRow(at: selectedIndex ) as! ExerciseInfoCell
        if selected.isPicked{
            pickedExercises.removeAll { (Exercise) -> Bool in
                return Exercise.name == exercise[tag].name
            }
            arrayOfbuttonStates[selectedIndex.row] = true
            selected.isPicked = false
        }else{
            pickedExercises.append(exercise[tag])
            arrayOfbuttonStates[selectedIndex.row] = false
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
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        workout?.workoutDay = weekDays[row]
//    }
}


