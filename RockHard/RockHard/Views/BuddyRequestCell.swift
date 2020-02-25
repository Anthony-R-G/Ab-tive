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
        return label
    }()
    lazy var requestDescriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var requestDateCreatedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var requestDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - Objc Functions
    //MARK: - Regular Functions
    private func setUpConstraints(){
        constraiProfilePicture()
        constrainUserNameLabel()
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
            userNameLabel.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 0),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            userNameLabel.widthAnchor.constraint(equalToConstant: 80),
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }
    
}
