//
//  SignupViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 2/13/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Firebase

class SignUpViewController: UIViewController {
    //MARK: -- Lazy UI Properties
    lazy var emailTextField: UITextField = {
        Utilities.createTextfield(placeholderMsg: "Email Address", isSecureEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        Utilities.createTextfield(placeholderMsg: "Password", isSecureEntry: true)
    }()
    
    lazy var userNameTextField: UITextField = {
        Utilities.createTextfield(placeholderMsg: "Username", isSecureEntry: false)
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.0
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Create Account"
        return label
    }()

    
    //MARK: -- Data Handling Methods
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user, userName: self!.userNameTextField.text!)) { [weak self] newResult in
                    self?.handleCreatedUserInFirestore(result: newResult)
                }
            case .failure(let error):
                Utilities.showAlert(vc: self!, message: error.localizedDescription)
            }
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<(), Error>) {
        switch result {
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else { return }
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                
                window.rootViewController = MainTabBarController()
            }, completion: nil)
        case .failure(let error):
            Utilities.showAlert(vc: self, message: error.localizedDescription)
        }
    }
    
    
    @objc func signUpButtonPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            Utilities.showAlert(vc: self, message: "Please fill out all fields.")
            return
        }
        
        guard email.isValidEmail else {
            Utilities.showAlert(vc: self, message: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            Utilities.showAlert(vc: self, message: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
            self?.handleCreateAccountResponse(with: result)
        }
    }
    
    //MARK: -- Life Cycle Methods
 
   override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.barStyle = .black
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "loginScreenBG")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

//MARK: -- Constraints
extension SignUpViewController {
    
    private func setConstraints() {
        [createAccountLabel,emailTextField, passwordTextField, userNameTextField ,signUpButton].forEach({view.addSubview($0)})
        [createAccountLabel,emailTextField, passwordTextField, userNameTextField, signUpButton].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        setTitleLabelConstraints()
        setEmailTextFieldConstraints()
        setPasswordTextFieldConstraints()
        setSignUpButtonConstraints()
        setUsernameTextFieldConstraints()
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountLabel.heightAnchor.constraint(equalToConstant: 70),
            createAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setUsernameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 45),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setEmailTextFieldConstraints() {
        NSLayoutConstraint.activate([
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 60),
            userNameTextField.widthAnchor.constraint(equalToConstant: 300),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: userNameTextField.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 45),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setSignUpButtonConstraints() {
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
