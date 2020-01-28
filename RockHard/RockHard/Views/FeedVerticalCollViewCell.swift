//  FeedVerticalCollViewCell.swift
//  RockHard
//  Created by Eric Widjaja on 1/28/20.
//  Copyright © 2020 Rockstars. All rights reserved.


import UIKit

class FeedVerticalCollViewCell: UICollectionViewCell {
    
    let feedImage = UIImageView()
    func setUpFeedImage() {
        feedImage.image = #imageLiteral(resourceName: "gymBuddyHolder")
        feedImage.contentMode = .scaleAspectFit
        feedImage.layer.cornerRadius = 20
        feedImage.clipsToBounds = true
        feedImage.layer.allowsGroupOpacity = true
        
        feedImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(feedImage)
        NSLayoutConstraint.activate([
            feedImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            feedImage.heightAnchor.constraint(equalTo: heightAnchor),
            feedImage.widthAnchor.constraint(equalTo: widthAnchor)])
    }
    
    let containerView = UIView()
    func setUpContainerView() {
        containerView.backgroundColor = .white
        containerView.alpha = 0.70
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 100, y: 150, width: 300, height: 300))
        setUpFeedImage()
        self.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

