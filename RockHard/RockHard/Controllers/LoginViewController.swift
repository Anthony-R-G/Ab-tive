//
//  LoginViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 2/13/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: -- Lazy UI Properties
    lazy var emailTextField: UITextField = { Utilities.createTextfield(placeholderMsg: "Email Address", isSecureEntry: false)
        
    }()
    
    lazy var passwordTextField: UITextField = {
        Utilities.createTextfield(placeholderMsg: "Password", isSecureEntry: true)
    }()
    
    lazy var fitBuddyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 21)
        label.textColor = .white
        label.text = "Fit Buddy"
        label.textAlignment = .center
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1.0
        button.showsTouchWhenHighlighted = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var appLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gymIcon")
        return iv
    }()
    
    //MARK: -- Data Handling Methods
    
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            Utilities.showAlert(vc: self, message: error.localizedDescription)
        case .success:
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else { return }
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                window.rootViewController = MainTabBarController()
            })
        }
    }
    
    //MARK: -- Objective C/Interfacing Methods
    @objc func loginButtonPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            Utilities.showAlert(vc: self, message: "Please fill out all fields")
            return
        }
        
        guard email.isValidEmail else {
            Utilities.showAlert(vc: self,message: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            Utilities.showAlert(vc: self, message: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
            self.handleLoginResponse(with: result)
        }
    }

    @objc private func signUpButtonPressed() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .formSheet
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //MARK: UI/Life Cycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func addDelegatesTextField(){
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        addDelegatesTextField()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "loginScreenBG")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

//MARK: -- Constraints
extension LoginViewController {
    
    private func setConstraints() {
        [emailTextField, passwordTextField, loginButton, signUpButton, appLogo, fitBuddyLabel].forEach({view.addSubview($0)})
        
        [emailTextField, passwordTextField, loginButton, signUpButton, appLogo, fitBuddyLabel].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        configureGymLogoConstraints()
        configureFitBuddyLabel()
        configureTextFieldConstraints()
        configureSignUpButtonConstraints()
        configureLoginButtonConstraints()
    }
    
    private func configureLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            loginButton.widthAnchor.constraint(equalToConstant: 350),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSignUpButtonConstraints() {
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 70),
            signUpButton.widthAnchor.constraint(equalToConstant: 350),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureTextFieldConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor, constant: -200),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 70),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureGymLogoConstraints() {
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            appLogo.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -360),
            appLogo.widthAnchor.constraint(equalToConstant: 400),
            appLogo.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureFitBuddyLabel(){
        NSLayoutConstraint.activate([
            fitBuddyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fitBuddyLabel.topAnchor.constraint(equalTo: appLogo.bottomAnchor),
            fitBuddyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            fitBuddyLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

