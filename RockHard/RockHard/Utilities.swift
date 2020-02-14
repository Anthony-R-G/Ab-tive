//
//  Utilities.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 2/13/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation

import UIKit

class Utilities {
    
   static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    
    //Password must have 8 characters minimum, a special character, and a number
        return passwordTest.evaluate(with: password)
    }
    
    static func styleTextField(_ textfield: UITextField) {
         let bottomLine = CALayer()
         bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
         bottomLine.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
         textfield.borderStyle = .none
         textfield.layer.addSublayer(bottomLine)
     }
    
    static func createTextfield(placeholderMsg: String, isSecureEntry: Bool) -> UITextField {
          let textField = UITextField()
              textField.attributedPlaceholder = NSAttributedString(string: placeholderMsg,
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .none
        textField.textColor = .white
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .white, width: 0.5)
        textField.backgroundColor = .clear
        if isSecureEntry == true {
            textField.isSecureTextEntry = true
        }
              return textField
    }
    
    static func showAlert(vc: UIViewController, message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alertVC, animated: true, completion: nil)
    }
     
}

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

//TODO: -- isEmailValid regular expression

extension String {
    var isValidEmail: Bool {

        // this pattern requires that an email use the following format:
        // [something]@[some domain].[some tld]
        let validEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", validEmailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {

        //this pattern requires that a password has at least one capital letter, one number, one lower case letter, and is at least 8 characters long
        //let validPasswordRegEx =  "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"

        //this pattern requires that a password be at least 8 characters long
        let validPasswordRegEx =  "[A-Z0-9a-z!@#$&*.-]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", validPasswordRegEx)
        return passwordPredicate.evaluate(with: self)
    }
}
