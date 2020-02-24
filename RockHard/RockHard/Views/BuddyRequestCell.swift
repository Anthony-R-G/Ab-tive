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
    
     }
     
     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    //MARK: - Variables
    //MARK: - UI Objects
    lazy var profilePicture: UIImageView = {
        let image = UIImageView()
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
    //MARK: - Constraints
    
}
