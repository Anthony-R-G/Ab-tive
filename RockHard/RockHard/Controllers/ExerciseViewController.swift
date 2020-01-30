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
    
    //MARK: - UI Objects
 lazy var exerciseTableView: UITableView = {
      let layout = UITableView()
      layout.register(ExerciseInfoCell.self, forCellReuseIdentifier: "exerciseCell")
      layout.backgroundColor = .white
        layout.delegate = self
        layout.dataSource = self
      return layout
  }()
    //MARK: - Objc Functions
    
    //MARK: - Regular Functions
    private func setUpView(){
    view.backgroundColor = .white
    }
    private func setUpConstraints(){
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
            exerciseTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
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
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}
extension ExerciseViewController: ButtonFunction{
    func selectAction(tag: Int) {
        let selectedIndex = IndexPath(row: tag, section: 0)
        let selected = exerciseTableView.cellForRow(at: selectedIndex ) as! ExerciseInfoCell
        selected.exerciseIsPicked.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
