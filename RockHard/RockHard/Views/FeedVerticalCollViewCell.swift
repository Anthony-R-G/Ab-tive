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
    
    
    
    private func setConstraints(){
        [feedPostImage].forEach{addSubview($0)}
        [feedPostImage].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            feedPostImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedPostImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            feedPostImage.heightAnchor.constraint(equalTo: heightAnchor),
            feedPostImage.widthAnchor.constraint(equalTo: widthAnchor)])
        
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

