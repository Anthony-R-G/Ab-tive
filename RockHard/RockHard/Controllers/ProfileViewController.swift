//
//  ProfileViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
        
    }()
    
    var profileImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = #imageLiteral(resourceName: "profileImage")
           imageView.contentMode = .scaleAspectFill
           imageView.layer.cornerRadius = 120/2
           imageView.layer.borderWidth = 3
           imageView.layer.borderColor = #colorLiteral(red: 0.5556545258, green: 0.1609915495, blue: 0.379331708, alpha: 1)
           imageView.clipsToBounds = true
           return imageView
    }()
    lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = #imageLiteral(resourceName: "profilbackgroundImage")
//        backgroundImage.backgroundColor = .red
        
        
        return backgroundImage
    }()
    
    lazy var userNamelabel: UILabel = {
    let nameLabel = UILabel()
        nameLabel.text = "Hildy A."
        return nameLabel
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8664230704, green: 0.8668759465, blue: 0.8579339385, alpha: 1)
        addSubview()
       constraintProfileImage()
        contraintContentView()
        constraintBackgroundImage()
        
    }
    
    private func addSubview() {
        contentView.addSubview(profileImageView)
              view.addSubview(contentView)
//        contentView.addSubview(userNameLabel)
        view.addSubview(backgroundImageView)
    }
    
    private func constraintProfileImage(){
        profileImageView.anchors(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: -45, paddingLeft: 50, width: 120, height: 120)
    }
    
    private func contraintContentView() {
        contentView.anchors(bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingBottom: 20, paddingLeft: 20, paddingRight: 20, height: 350)
           }
    
    private func constraintBackgroundImage() {
        backgroundImageView.anchors(top: view.topAnchor, bottom: contentView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 120, paddingBottom: 70, paddingLeft: 20, paddingRight: 20)
    }
    
    private func constraintUserNameLabel(){
        userNamelabel.anchors (top: contentView.topAnchor, bottom: <#T##NSLayoutYAxisAnchor?#>, left: contentView.leftAnchor, right: <#T##NSLayoutXAxisAnchor?#>, paddingTop: <#T##CGFloat?#>, paddingBottom: <#T##CGFloat?#>, paddingLeft: <#T##CGFloat?#>, paddingRight: <#T##CGFloat?#>, width: <#T##CGFloat?#>, height: <#T##CGFloat?#>)
    }
    }





extension  UIView {
    func anchors(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
            }
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        if let right = right {
            if let paddingRight = paddingRight{
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        if let width = width {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        }
       if let height = height {
              heightAnchor.constraint(equalToConstant: height).isActive = true
              }
        }
}

