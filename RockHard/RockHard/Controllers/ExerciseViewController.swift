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
          view.backgroundColor = .white
    }
    //MARK: - Variables
    
    //MARK: - UI Objects
 lazy var exerciseTableView: UITableView = {
      let layout = UITableView()
      layout.register(ExerciseInfoCell.self, forCellReuseIdentifier: "exerciseCell")
      layout.backgroundColor = .white
      return layout
  }()
    //MARK: - Objc Functions
    
    //MARK: - Regular Functions
    
    //MARK: - Constraints
    
}
extension ExerciseInfoCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }
    
    
}
