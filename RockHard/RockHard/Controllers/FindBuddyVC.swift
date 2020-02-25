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
        setUpView()
        getBuddyRequest()
        constrainBuddyRequestTableVC()
    }
    //MARK: - Variables
    var buddyRequests = [BuddyRequest](){
        didSet{
            buddyRequestTableVC.reloadData()
        }
    }
    //MARK: - UI Objects
    lazy var buddyRequestTableVC: UITableView = {
    let tableVC = UITableView()
    tableVC.register(BuddyRequestCell.self, forCellReuseIdentifier: "buddyCell")
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
    private func getBuddyRequest(){
        FirestoreService.manager.getBuddyRequests { (Result) in
            switch Result{
            case .failure(let error):
                print(error)
            case .success(let requests):
                self.buddyRequests = requests
            }
        }
    }
    
    //MARK: - Constraints
    private func constrainBuddyRequestTableVC(){
        view.addSubview(buddyRequestTableVC)
        buddyRequestTableVC.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buddyRequestTableVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            buddyRequestTableVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            buddyRequestTableVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            buddyRequestTableVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
extension FindBuddyVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buddyRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = buddyRequestTableVC.dequeueReusableCell(withIdentifier: "buddyCell", for: indexPath) as? BuddyRequestCell else {return UITableViewCell()}
        let requestData = buddyRequests[indexPath.row]
        cell.userNameLabel.text = requestData.creatorId
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
