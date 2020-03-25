 //
//  ProfileViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
//    MARK: UI VARIABLES
   
        lazy var contentView: UIView = {
        let view = UIView()
            view.layer.cornerRadius = 20
            view.backgroundColor = UIColor.darkGray
            view.alpha = 0.3
        
        return view
        
    }()
    
    var profileImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = #imageLiteral(resourceName: "profileImage")
           imageView.contentMode = .scaleAspectFill
           imageView.layer.cornerRadius = 110/2
           imageView.layer.borderWidth = 3
           imageView.layer.borderColor = #colorLiteral(red: 0.5556545258, green: 0.1609915495, blue: 0.379331708, alpha: 1)
           imageView.clipsToBounds = true
           return imageView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.layer.cornerRadius = 20
        backgroundImage.image = #imageLiteral(resourceName: "Untitled design (2).png")
//        backgroundImage.backgroundColor = .red
        
        
        return backgroundImage
    }()
    
    lazy var userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Hildy A."
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont(name:"Kohinoor Telugu", size: 28)
//        nameLabel.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        return nameLabel
    }()
    
    lazy var buddySwitchLabel: UILabel = {
        let buddyLabel = UILabel()
        buddyLabel.text = "Buddy System"
        buddyLabel.textAlignment = .center
        buddyLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        buddyLabel.font = UIFont(name:"Kohinoor Telugu", size: 16)
//        buddyLabel.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        return buddyLabel
    }()
    
    lazy var buddySwitch: UISwitch = {
        let buddySwitch = UISwitch()
        return buddySwitch
    }()
    
    lazy var emailTextField: UITextField = {
        let emailTF = UITextField()
        emailTF.backgroundColor = #colorLiteral(red: 0.8044961691, green: 0.8000447154, blue: 0.7911967635, alpha: 1)
        emailTF.textAlignment = .center
        emailTF.text = "E-Mail"
        emailTF.textColor = UIColor.white
        return emailTF
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.backgroundColor = #colorLiteral(red: 0.8044961691, green: 0.8000447154, blue: 0.7911967635, alpha: 1)
        passwordTF.textAlignment = .center
        passwordTF.text = "Password"
        passwordTF.textColor = UIColor.white
        return passwordTF
    }()
    
    lazy var gymLabel: UILabel = {
        let gymLabel = UILabel()
        gymLabel.text = "Current Gym:"
        gymLabel.textAlignment = .center
        gymLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gymLabel.font = UIFont(name:"Kohinoor Telugu", size: 16)
        return gymLabel
    }()
    
    lazy var gymNameTextField: UITextField = {
        let gymNameTF = UITextField()
        gymNameTF.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        gymNameTF.textAlignment = .center
        gymNameTF.text = "Enter Gym Name"
        gymNameTF.textColor = UIColor.white
        return gymNameTF
    }()
    
    lazy var gymAddressTextField: UITextField = {
        let gymAddressTF = UITextField()
        gymAddressTF.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        gymAddressTF.textAlignment = .center
        gymAddressTF.text = "Enter Address"
        gymAddressTF.textColor = UIColor.white
        return gymAddressTF
    }()
    
    lazy var goalLabel: UILabel = {
        let goalLabel = UILabel()
        goalLabel.text = "Goal:"
        goalLabel.textAlignment = .center
        goalLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        goalLabel.font = UIFont(name:"Kohinoor Telugu-bold", size: 16)
        return goalLabel
    }()
    
    lazy var goalPicker: UIPickerView = {
        let goalPicker = UIPickerView()
        goalPicker.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return goalPicker
    }()
//    MARK: LIFECYCLE
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8664230704, green: 0.8668759465, blue: 0.8579339385, alpha: 1)
        addSubview()
        constraintBackgroundImage()
        constraintProfileImage()
        contraintContentView()
        constraintUserNameLabel()
        constraintBuddySwitchLabel()
        contraintBuddySwitch()
        constraintEmailTextField()
        constraintPassTextField()
        constraintGymLabel()
        constraintGymNameTextField()
        constraintGymAddressTextField()
        constraintGoalLabel()
        constraintGoalPicker()
            
        
    }
    
    private func addSubview() {
        contentView.addSubview(profileImageView)
        view.addSubview(backgroundImageView)

              view.addSubview(contentView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(buddySwitchLabel)
        contentView.addSubview(buddySwitch)
//        view.addSubview(backgroundImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        contentView.addSubview(gymLabel)
        view.addSubview(gymNameTextField)
        view.addSubview(gymAddressTextField)
        contentView.addSubview(goalLabel)
        view.addSubview(goalPicker)
        
    }

    //    MARK: CONSTRAINTS
    
    
    private func constraintProfileImage(){
        profileImageView.anchors(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: -45, paddingLeft: 40, width: 110, height: 110)
    }
    
    private func contraintContentView() {
        
        contentView.anchors(bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingBottom: 80, paddingLeft: 20, paddingRight: 20, height: view.frame.height/2)
    }

    private func constraintBackgroundImage() {
        backgroundImageView.anchors(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 70, paddingBottom: 70, paddingLeft: 10, paddingRight: 10)
    }
    

    private func constraintUserNameLabel() {
        userNameLabel.anchors (top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 65, paddingLeft: 24
            , width: 150, height: 35)
    }
    
    private func constraintBuddySwitchLabel() {
               buddySwitchLabel.anchors (top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 05, paddingLeft: 180
                   , width: 115, height: 25)
        }
    
    private func contraintBuddySwitch() {
        buddySwitch.anchors(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 05, paddingRight: 24)
    }
    
    private func constraintEmailTextField() {
        emailTextField.anchors(top: contentView.topAnchor,  left: contentView.leftAnchor, paddingTop: 120, paddingLeft: 40, width: 300, height: 25)
    }
    
    private func constraintPassTextField() {
        passwordTextField.anchors(top: contentView.topAnchor,  left: contentView.leftAnchor, paddingTop: 160, paddingLeft: 40, width: 300, height: 25)
    }
    
    private func constraintGymLabel() {
        gymLabel.anchors (top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 200, paddingLeft: 24
            , width: 115, height: 25)
    }

    private func constraintGymNameTextField() {
        gymNameTextField.anchors(top: contentView.topAnchor,  left: contentView.leftAnchor, paddingTop: 230, paddingLeft: 40, width: 300, height: 25)
    }
    
    private func constraintGymAddressTextField() {
        gymAddressTextField.anchors(top: contentView.topAnchor,  left: contentView.leftAnchor, paddingTop: 270, paddingLeft: 40, width: 300, height: 25)
    }
    
    private func constraintGoalLabel() {
        goalLabel.anchors (top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 310, paddingLeft: 5
            , width: 115, height: 25)
    }
    
    private func constraintGoalPicker() {
        goalPicker.anchors(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 340, paddingLeft: 40, width: 300, height: 100)
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

