//
//  BuddyRequestCell.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/24/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//
import UIKit

class BuddyRequestCell: UITableViewCell {

    //MARK: - Lifecycle

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpConstraints()
     }
     
     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var profilePicture: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        return image
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    lazy var requestDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }()
    lazy var requestDateCreatedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    lazy var requestDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    private func setUpConstraints(){
        constraiProfilePicture()
        constrainUserNameLabel()
        constrainRequestDescriptionLabel()
        constrainDateCreatedLabel()
        constrainRequestDateLabel()
    }
    //MARK: - Constraints
    private func constraiProfilePicture(){
        contentView.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePicture.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            profilePicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            profilePicture.heightAnchor.constraint(equalToConstant: 40),
            profilePicture.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func constrainUserNameLabel(){
        contentView.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 20),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
            userNameLabel.widthAnchor.constraint(equalToConstant: 80),
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }
    private func constrainRequestDescriptionLabel(){
        contentView.addSubview(requestDescriptionLabel)
        requestDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestDescriptionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            requestDescriptionLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor, constant: 0),
            requestDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            requestDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    private func constrainDateCreatedLabel(){
        contentView.addSubview(requestDateCreatedLabel)
        requestDateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestDateCreatedLabel.topAnchor.constraint(equalTo: requestDescriptionLabel.bottomAnchor, constant: 0),
            requestDateCreatedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            requestDateCreatedLabel.heightAnchor.constraint(equalToConstant: 20),
            requestDateCreatedLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func constrainRequestDateLabel(){
        contentView.addSubview(requestDateLabel)
        requestDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            requestDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            requestDateLabel.heightAnchor.constraint(equalToConstant: 20),
            requestDateLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
