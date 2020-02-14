//  FeedVerticalCollViewCell.swift
//  RockHard
//  Created by Eric Widjaja on 1/28/20.
//  Copyright © 2020 Rockstars. All rights reserved.


import UIKit

class FeedVerticalCollViewCell: UICollectionViewCell {
    
    lazy var feedPostImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var feedPostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 4
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var userProfilePicture: UIImageView = {
        let iv = UIImageView()
        var frame = iv.frame
        iv.image = #imageLiteral(resourceName: "defaultUser")
        frame.size.width = 45
        frame.size.height = 45
        iv.frame = frame
        iv.layer.cornerRadius = iv.frame.size.width / 2
        iv.clipsToBounds = true
        iv.backgroundColor = .clear
        return iv
    }()
    
    lazy var darkOverlay: UIView = {
        let uv = UIView()
        uv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6019103168)
        uv.layer.cornerRadius = 20
        uv.clipsToBounds = true
        uv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return uv
    }()
    
    private func setConstraints(){
       
        [feedPostImage, darkOverlay, feedPostLabel  ,userNameLabel, userProfilePicture,].forEach{addSubview($0)}
        [feedPostImage, darkOverlay ,feedPostLabel, userNameLabel, userProfilePicture].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setFeedPostImageConstraints()
        setFeedLabelConstraints()
        setDarkOverlayConstraints()
        setUserProfilePictureConstraints()
        setUserNameLabelConstraints()
    }

    private func setFeedPostImageConstraints(){
        NSLayoutConstraint.activate([
            feedPostImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedPostImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            feedPostImage.heightAnchor.constraint(equalTo: heightAnchor),
            feedPostImage.widthAnchor.constraint(equalTo: widthAnchor)])
        
    }
    
    private func setFeedLabelConstraints(){
        NSLayoutConstraint.activate([
            feedPostLabel.topAnchor.constraint(equalTo: darkOverlay.topAnchor, constant: 30),
            feedPostLabel.leadingAnchor.constraint(equalTo: userProfilePicture.trailingAnchor, constant: 10),
            feedPostLabel.heightAnchor.constraint(equalToConstant: 80),
            feedPostLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setDarkOverlayConstraints(){
        NSLayoutConstraint.activate([
            darkOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            darkOverlay.widthAnchor.constraint(equalTo: widthAnchor),
            darkOverlay.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setUserNameLabelConstraints(){
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userProfilePicture.trailingAnchor, constant: 10),
            userNameLabel.topAnchor.constraint(equalTo: darkOverlay.topAnchor, constant: 13),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20),
            userNameLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setUserProfilePictureConstraints(){
        NSLayoutConstraint.activate([
            userProfilePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userProfilePicture.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            userProfilePicture.heightAnchor.constraint(equalToConstant: 45),
            userProfilePicture.widthAnchor.constraint(equalToConstant: 45)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


