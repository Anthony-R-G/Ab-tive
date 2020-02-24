//
//  FindBuddyVC.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/24/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class FindBuddyVC: UIViewController{

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - Variables
    var buddyRequests = [BuddyRequest](){
        didSet{
            buddyRequestTableVC.reloadData()
        }
    }
    //MARK: - UI Objects
    var buddyRequestTableVC: UITableView = {
    let tableVC = UITableView()
    tableVC.register(WorkoutDayCell.self, forCellReuseIdentifier: "buddyCell")
    tableVC.backgroundColor = .lightGray
    tableVC.delegate = self
    tableVC.dataSource = self
    return tableVC
    }()
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    private func setUpView(){
        view.backgroundColor = .white
    }
    
    //MARK: - Constraints
    
}
extension FindBuddyVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = buddyRequestTableVC.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as? BuddyRequestCell else {return UITableViewCell()}
        
    }
    
    
}
