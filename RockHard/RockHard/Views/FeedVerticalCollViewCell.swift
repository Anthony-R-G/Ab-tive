//  FeedVerticalCollViewCell.swift
//  RockHard
//  Created by Eric Widjaja on 1/28/20.
//  Copyright © 2020 Rockstars. All rights reserved.


import UIKit

class FeedVerticalCollViewCell: UICollectionViewCell {
    
    lazy var feedPostImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //        iv.layer.allowsGroupOpacity = true
        return iv
    }()
    
    lazy var feedPostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 8
        return label
    }()
    
    
    
    private func setConstraints(){
        [feedPostImage, feedPostLabel].forEach{addSubview($0)}
        [feedPostImage, feedPostLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setFeedPostImageConstraints()
        setFeedLabelConstraints()
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
            feedPostLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            feedPostLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedPostLabel.heightAnchor.constraint(equalToConstant: 80),
            feedPostLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85)
            
        ])
    }
    
    //    let containerView = UIView()
    //    func setUpContainerView() {
    //        containerView.backgroundColor = .white
    //        containerView.alpha = 0.70
    //    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

