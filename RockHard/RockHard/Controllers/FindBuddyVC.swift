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
        setUpConstraints()
      
    }
    //MARK: - Variables
    var buddyRequests = [BuddyRequest](){
        didSet{
            buddyRequestTableVC.reloadData()
        }
    }
    
    //MARK: - UI Objects
    lazy var createRequestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.sizeToFit()
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        return button
    }()
    lazy var buddyRequestTableVC: UITableView = {
    let tableVC = UITableView()
    tableVC.register(BuddyRequestCell.self, forCellReuseIdentifier: "buddyCell")
    tableVC.backgroundColor = .lightGray
    tableVC.delegate = self
    tableVC.dataSource = self
    return tableVC
    }()
    lazy var typeOfRequestSegmented: UISegmentedControl = {
    let segment = UISegmentedControl(items: ["My Request", "New Requests"])
        segment.selectedSegmentIndex = 0
    return segment
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
    private func setUpConstraints(){
        constraintTypeOfRequestSegmented()
          constrainBuddyRequestTableVC()
            constrainCreateRequestButton()
        
    }
    
    
    //MARK: - Constraints
    private func constrainBuddyRequestTableVC(){
        view.addSubview(buddyRequestTableVC)
        buddyRequestTableVC.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buddyRequestTableVC.topAnchor.constraint(equalTo: typeOfRequestSegmented.bottomAnchor, constant: 0),
            buddyRequestTableVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            buddyRequestTableVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            buddyRequestTableVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    private func constrainCreateRequestButton(){
        view.addSubview(createRequestButton)
        createRequestButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createRequestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            createRequestButton.heightAnchor.constraint(equalToConstant: 50),
            createRequestButton.widthAnchor.constraint(equalToConstant: 50),
            createRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    private func constraintTypeOfRequestSegmented(){
        view.addSubview(typeOfRequestSegmented)
        typeOfRequestSegmented.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeOfRequestSegmented.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            typeOfRequestSegmented.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            typeOfRequestSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            typeOfRequestSegmented.heightAnchor.constraint(equalToConstant: 40)
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
        cell.requestDescriptionLabel.text = requestData.requestInfo
        cell.requestDateCreatedLabel.text = requestData.createdDateFormat
        cell.requestDateLabel.text = requestData.requestedDateFormat
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
